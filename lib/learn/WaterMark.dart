import 'dart:ui';
import 'dart:math' as math;

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "水印",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("flutter 全屏水印"),
      ),
      // body: Column(
      //   children: [_getWaterMark()],
      // ),
      body: TestWaterMark(),
    );
  }
}

class WaterMarkWidget extends StatefulWidget {
  const WaterMarkWidget(
      {Key? key, required this.painter, this.repeat = ImageRepeat.repeat})
      : super(key: key);

  /// 单元水印画笔
  final WaterMarkPainter painter;

  /// 单元水印的重复方式
  final ImageRepeat repeat;

  @override
  State<WaterMarkWidget> createState() => _WaterMarkWidgetState();
}

class _WaterMarkWidgetState extends State<WaterMarkWidget> {
  late Future<MemoryImage> _memoryImageFuture;

  @override
  void initState() {
    _memoryImageFuture = _getWaterMarkImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // _memoryImageFuture = _getWaterMarkImage();
    return SizedBox.expand(
      child: FutureBuilder(
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            // 如果单元水印还没有绘制好先返回一个空的Container
            return Container();
          } else {
            // 如果单元水印已经绘制好，则渲染水印
            if(snapshot.hasError){
              debugPrint("${snapshot.error}");
              return Text("出错了：${snapshot.error}",textScaleFactor: 1.2,);
            }
            return DecoratedBox(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: snapshot.data!, // 背景图，即我们绘制的单元水印图片
                        repeat: widget.repeat, // 指定重复方式
                        alignment: Alignment.topLeft)));
          }
        },
        future: _memoryImageFuture,
      ),
    );
  }

// 离屏绘制单元水印并将绘制结果保存为图片缓存起来
  Future<MemoryImage> _getWaterMarkImage() async {
    // 创建一个 Canvas 进行离屏绘制
    final recorder = PictureRecorder();
    final canvas = Canvas(recorder);
    final picture = recorder.endRecording();
    // 绘制单元水印并获取其大小
    final Size size = widget.painter
        .paintUnit(canvas, MediaQuery.of(context).devicePixelRatio);
    //将单元水印导为图片并缓存起来
    final img = await picture.toImage(size.width.ceil(), size.height.ceil());
    final byteData = await img.toByteData(format: ImageByteFormat.png);
    final pngBytes = byteData!.buffer.asUint8List();
    return MemoryImage(pngBytes);
  }

  @override
  void didUpdateWidget(covariant WaterMarkWidget oldWidget) {
    // 如果画笔发生了变化（类型或者配置）则重新绘制水印
    if (widget.painter.runtimeType != oldWidget.painter.runtimeType ||
        widget.painter.shouldRepaint(oldWidget.painter)) {
      //先释放之前的缓存
      _memoryImageFuture.then((value) => value.evict());
      //重新绘制并缓存
      _memoryImageFuture = _getWaterMarkImage();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _memoryImageFuture.then((value) => value.evict());
    super.dispose();
  }
}

/// 定义水印画笔
abstract class WaterMarkPainter {
  /// 绘制"单元水印"，完整的水印是由单元水印重复平铺组成,返回值为"单元水印"占用空间的大小。
  /// [devicePixelRatio]: 因为最终要将绘制内容保存为图片，所以在绘制时需要根据屏幕的
  /// DPR来放大，以防止失真
  Size paintUnit(Canvas canvas, double devicePixelRatio);

  /// 是否需要重绘
  bool shouldRepaint(covariant WaterMarkPainter oldPainter) => true;
}

/// 文本水印画笔
class TextWaterMarkPainter extends WaterMarkPainter {
  TextWaterMarkPainter(
      {Key? key,
      double? rotate,
      EdgeInsets? padding,
      TextStyle? textStyle,
      TextDirection? textDirection,
      required this.text})
      : assert(rotate == null || rotate >= -90 && rotate <= 90),
        rotate = rotate ?? 0,
        padding = padding ?? const EdgeInsets.all(10),
        textStyle = textStyle ??
            const TextStyle(color: Color.fromARGB(20, 0, 0, 0), fontSize: 14),
        textDirection = textDirection ?? TextDirection.ltr;

  double rotate; // 文本旋转的度数，是角度不是弧度
  TextStyle textStyle; // 文本样式
  EdgeInsets padding; // 文本的 padding
  String text; // 文本
  TextDirection textDirection;

  @override
  Size paintUnit(Canvas canvas, double devicePixelRatio) {
    /// 1. 先绘制文本
    /// 创建一个 ParagraphBuilder，记为 builder。
    /// 调用 builder.add 添加要绘制的字符串。
    /// 构建文本并进行 layout，因为在 layout 后才能知道文本所占用的空间。
    /// 调用 canvas.drawParagraph 绘制。
    //根据屏幕 devicePixelRatio 对文本样式中长度相关的一些值乘以devicePixelRatio
    final actualTextStyle = _handleTextStyle(textStyle, devicePixelRatio);
    final actualPadding = padding * devicePixelRatio;

    //构建文本段落
    // final builder = ParagraphBuilder(actualTextStyle.getParagraphStyle(
    //     textDirection: TextDirection.ltr,
    //     textAlign: TextAlign.start,
    //     textScaleFactor: devicePixelRatio));
    //
    // //添加要绘制的文本及样式
    // builder
    //   ..pushStyle(actualTextStyle.getTextStyle())
    //   ..addText(text);
    //
    // //layout 后我们才能知道文本占用的空间
    // Paragraph paragraph = builder.build()
    //   ..layout(const ParagraphConstraints(width: double.infinity));
    //
    // //文本占用的真实宽度
    // final textWidth = paragraph.longestLine.ceilToDouble();
    // //文本占用的真实高度
    // final textHeight = paragraph.height;
    // //绘制文本
    // canvas.drawParagraph(paragraph, Offset.zero);


    // 绘制文本的过程还是比较复杂的，为此 Flutter 提供了一个专门用于绘制文本的画笔 TextPainter
    // 构建文本画笔
    TextPainter textPainter = TextPainter(
        textDirection: textDirection, textScaleFactor: devicePixelRatio);
    //添加文本和样式
    textPainter.text = TextSpan(text: text, style: actualTextStyle);
    //对文本进行布局
    textPainter.layout();
    //文本占用的真实宽度
    final textWidth = textPainter.width;
    //文本占用的真实高度
    final textHeight = textPainter.height;

    /// 2. 应用旋转和padding
    // 将弧度转化为度数
    final radians = math.pi * rotate / 180;

    //通过三角函数计算旋转后的位置和size
    final orgSin = math.sin(radians);
    final sin = orgSin.abs();
    final cos = math.cos(radians).abs();

    final width = textWidth * cos;
    final height = textWidth * sin;
    final adjustWidth = textHeight * sin;
    final adjustHeight = textHeight * cos;

    // 为什么要平移？如果不限平移，就会导致旋转之后一部分内容的位置跑到画布之外
    if (orgSin >= 0) {
      // 旋转角度为正
      canvas.translate(
        adjustWidth + padding.left,
        padding.top,
      );
    } else {
      // 旋转角度为负
      canvas.translate(
        padding.left,
        height + padding.top,
      );
    }
    canvas.rotate(radians);

    // 绘制文本
    textPainter.paint(canvas, Offset.zero);
    return Size(width + adjustWidth + padding.horizontal,
        height + adjustHeight + padding.vertical);
  }

  @override
  bool shouldRepaint(covariant TextWaterMarkPainter oldPainter) {
    return oldPainter.rotate != rotate ||
        oldPainter.text != text ||
        oldPainter.padding != padding ||
        oldPainter.textDirection != textDirection ||
        oldPainter.textStyle != textStyle;
  }

  TextStyle _handleTextStyle(TextStyle textStyle, double devicePixelRatio) {
    var style = textStyle;
    double scaleRatio(attr) => attr == null ? 1 : devicePixelRatio;
    return style.apply(
        decorationThicknessFactor: scaleRatio(style.decorationThickness),
        letterSpacingFactor: scaleRatio(style.letterSpacing),
        wordSpacingFactor: scaleRatio(style.wordSpacing),
        heightFactor: scaleRatio(style.height));
  }
}


/// 测试水印
class TestWaterMark extends StatelessWidget {
  const TestWaterMark({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _getWaterMark();
  }

  Widget _getWaterMark() {
    return Stack(
      children: [
        Center(
          child: ElevatedButton(onPressed: () {}, child: const Text("一个按钮而已")),
        ),
        IgnorePointer(
          child: WaterMarkWidget(
            painter: TextWaterMarkPainter(
                text: "试试水印效果",
                textStyle: const TextStyle(
                  fontSize: 6,
                  fontWeight: FontWeight.w200,
                  color: Colors.black38, //为了水印能更清晰一些，颜色深一点
                ),
                rotate: -20),
          ),
        )
      ],
    );
  }
}

