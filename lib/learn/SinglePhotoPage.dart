import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class SinglePhotoPage extends StatefulWidget {
  const SinglePhotoPage({Key? key}) : super(key: key);

  @override
  State<SinglePhotoPage> createState() => _SinglePhotoPageState();
}

class _SinglePhotoPageState extends State<SinglePhotoPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> animation;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));

    //匀速
    animation = Tween(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() => {});
      });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ExtendedImage.network(
        'https://p.qqan.com/up/2022-9/16642501281078519.jpg',
        // 缩放
        mode: ExtendedImageMode.gesture,
        initGestureConfigHandler: (state){
          return GestureConfig(
            minScale: 0.5,
            animationMinScale: 0.4,
            maxScale: 3.0,
            animationMaxScale: 3.5,
            speed: 1.0,
            inertialSpeed: 100.0,
            initialScale: 1.0,
            inPageView: false,
            initialAlignment: InitialAlignment.center,
          );
        },
        // 图片编辑
        // mode: ExtendedImageMode.editor,
        fit: BoxFit.contain,
        initEditorConfigHandler: (state){
          return EditorConfig(
              maxScale: 8.0,
              cropRectPadding: const EdgeInsets.all(20.0),
              cornerColor: Colors.green,
              hitTestSize: 20.0,
              cropAspectRatio: 0.7,
          );
        },
        onDoubleTap: (ExtendedImageGestureState state) {
          ///you can use define pointerDownPosition as you can,
          ///default value is double tap pointer down position.
          // var pointerDownPosition = state.pointerDownPosition;
          // double begin = state.gestureDetails?.totalScale;
          // double end;
          //
          // //remove old
          // _animation?.removeListener(animationListener);
          //
          // //stop pre
          // _animationController.stop();
          //
          // //reset to use
          // _animationController.reset();
          //
          // if (begin == doubleTapScales[0]) {
          //   end = doubleTapScales[1];
          // } else {
          //   end = doubleTapScales[0];
          // }
          //
          // animationListener = () {
          //   //print(_animation.value);
          //   state.handleDoubleTap(
          //       scale: _animation.value,
          //       doubleTapPosition: pointerDownPosition);
          // };
          // _animation = _animationController
          //     .drive(Tween<double>(begin: begin, end: end));
          //
          // _animation.addListener(animationListener);
          //
          // _animationController.forward();
        },
        // loadStateChanged: (loadState) {
        //   debugPrint('图片状态：${loadState.extendedImageLoadState.name}');
        //   debugPrint(
        //       '加载进度：${(loadState.loadingProgress?.cumulativeBytesLoaded ?? 1) / (loadState.loadingProgress?.expectedTotalBytes ?? 1)}');
        //
        //   switch (loadState.extendedImageLoadState) {
        //     case LoadState.loading:
        //       _controller.reset();
        //       return Image.asset(
        //         "assets/loading.gif",
        //         fit: BoxFit.fill,
        //       );
        //       break;
        //
        //     ///if you don't want override completed widget
        //     ///please return null or state.completedWidget
        //     //return null;
        //     //return state.completedWidget;
        //     case LoadState.completed:
        //       _controller.forward();
        //       return FadeTransition(
        //         opacity: _controller,
        //         child: ExtendedRawImage(
        //           image: loadState.extendedImageInfo?.image,
        //           width: 600,
        //           height: 400,
        //         ),
        //       );
        //       break;
        //     case LoadState.failed:
        //       _controller.reset();
        //       return GestureDetector(
        //         child: Stack(
        //           fit: StackFit.expand,
        //           children: <Widget>[
        //             Image.asset(
        //               "assets/failed.jpg",
        //               fit: BoxFit.fill,
        //             ),
        //             const Positioned(
        //               bottom: 0.0,
        //               left: 0.0,
        //               right: 0.0,
        //               child: Text(
        //                 "load image failed, click to reload",
        //                 textAlign: TextAlign.center,
        //               ),
        //             )
        //           ],
        //         ),
        //         onTap: () {
        //           loadState.reLoadImage();
        //         },
        //       );
        //       break;
        //   }
        // },
      ),
    );
  }
}
