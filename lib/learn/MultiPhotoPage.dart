import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class MultiPhotoPage extends StatefulWidget {
  MultiPhotoPage({Key? key}) : super(key: key);

  final List<String> pics = [
    'https://p.qqan.com/up/2022-9/16644331618490721.jpg',
    'https://p.qqan.com/up/2022-9/16644331614978803.jpg',
    'https://p.qqan.com/up/2022-9/16644331615953703.jpg',
    'https://p.qqan.com/up/2022-9/16644331614271146.jpg',
    'https://p.qqan.com/up/2022-9/16644331612803098.jpg',
    'https://p.qqan.com/up/2022-9/16644331611094175.jpg'
  ];

  @override
  State<MultiPhotoPage> createState() => _MultiPhotoPageState();
}

class _MultiPhotoPageState extends State<MultiPhotoPage> {
  int currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.withOpacity(0.2),
      child: ExtendedImageGesturePageView.builder(
        itemBuilder: (BuildContext context, int index) {
          var item = widget.pics[index];
          Widget image = ExtendedImage.network(item,
              fit: BoxFit.contain, mode: ExtendedImageMode.gesture,
              initGestureConfigHandler: (state) {
            return GestureConfig(
              inPageView: true,
              initialScale: 1.0,
              //you can cache gesture state even though page view page change.
              //remember call clearGestureDetailsCache() method at the right time.(for example,this page dispose)
              cacheGesture: false,
              minScale: 0.5,
              animationMinScale: 0.4,
              maxScale: 3.0,
              animationMaxScale: 3.5,
              speed: 1.0,
              inertialSpeed: 100.0,
              initialAlignment: InitialAlignment.center,
            );
          });
          image = Container(
            padding: EdgeInsets.all(5.0),
            child: image,
          );
          if (index == currentIndex) {
            return Hero(
              tag: item + index.toString(),
              child: image,
            );
          } else {
            return image;
          }
        },
        itemCount: widget.pics.length,
        onPageChanged: (int index) {
          currentIndex = index;
          // rebuild.add(index);
        },
        controller: ExtendedPageController(
          initialPage: currentIndex,
        ),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        canScrollPage: (GestureDetails? gestureDetails) {
          return true;
          //return (gestureDetails?.totalScale ?? 1.0) <= 1.0;
        },
      ),
    );
  }

  @override
  void dispose() {
    clearGestureDetailsCache();
    super.dispose();
  }
}
