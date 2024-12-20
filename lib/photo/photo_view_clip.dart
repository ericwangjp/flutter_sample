import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:image_editor/image_editor.dart' as image_editor;
import 'package:image_picker/image_picker.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "图片处理",
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
  late final ImagePicker _imagePicker;
  late final image_editor.ImageEditorOption _editorOption;
  final GlobalKey<ExtendedImageEditorState> _editorKey =
      GlobalKey<ExtendedImageEditorState>();
  File? clipImage, resultClipImage;

  @override
  void initState() {
    _imagePicker = ImagePicker();
    _editorOption = image_editor.ImageEditorOption();
    // ..addOption(image_editor.ClipOption(width: 500, height: 500))
    // ..addOption(image_editor.ScaleOption(500, 500));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("flutter 图片处理"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () async {
                  final XFile? image =
                      await _imagePicker.pickImage(source: ImageSource.gallery);
                  debugPrint('选择图片地址：${image?.path}');
                  if (image?.path.isNotEmpty == true) {
                    clipImage = File((image?.path)!);
                    // clipImage =
                    //     await image_editor.ImageEditor.editFileImageAndGetFile(
                    //         file: File((image?.path)!),
                    //         imageEditorOption: _editorOption);
                    // debugPrint('图片裁剪完成：${clipImage?.path}');
                    setState(() {});
                  }
                },
                child: const Text('选择图片')),
            // Container(
            //   child: clipImage != null
            //       ? Image.file(
            //           clipImage!,
            //           width: 300,
            //           errorBuilder: (
            //             BuildContext context,
            //             Object error,
            //             StackTrace? stackTrace,
            //           ) {
            //             return Image.asset('images/cat.jpg');
            //           },
            //         )
            //       : const Text('未获取到图片数据'),
            // ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 600,
              child: clipImage != null
                  ? ExtendedImage.file(
                      clipImage!,
                      fit: BoxFit.contain,
                      extendedImageEditorKey: _editorKey,
                      mode: ExtendedImageMode.editor,
                      initEditorConfigHandler: (state) {
                        return EditorConfig(
                            maxScale: 8.0,
                            cropAspectRatio: CropAspectRatios.ratio1_1);
                      },
                    )
                  : const Text('未获取到图片数据'),
            ),
            ElevatedButton(
                onPressed: () async {
                  var state = _editorKey.currentState;
                  Rect? cropRect = state?.getCropRect();
                  // state.rawImageData
                  if (cropRect != null) {
                    image_editor.ImageEditorOption editorOption = image_editor.ImageEditorOption();
                    editorOption.addOption(image_editor.ClipOption.fromRect(cropRect));
                    resultClipImage =
                        await image_editor.ImageEditor.editFileImageAndGetFile(
                            file: clipImage!, imageEditorOption: editorOption);
                    setState(() {});
                  }
                },
                child: Text('裁剪完成')),
            Container(
              child: resultClipImage != null
                  ? Image.file(
                      resultClipImage!,
                      fit: BoxFit.cover,
                      errorBuilder: (
                        BuildContext context,
                        Object error,
                        StackTrace? stackTrace,
                      ) {
                        return Image.asset('images/cat.jpg');
                      },
                    )
                  : const Text('未获取到图片数据'),
            ),
          ],
        ),
      ),
    );
  }
}
