import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PhotoViewPage extends StatefulWidget {
  PhotoViewPage({Key? key}) : super(key: key);

  final List<String> _photos = [
    'https://p.qqan.com/up/2022-9/16644331618490721.jpg',
    'https://p.qqan.com/up/2022-9/16644331614978803.jpg',
    'https://p.qqan.com/up/2022-9/16644331615953703.jpg',
    'https://p.qqan.com/up/2022-9/16644331614271146.jpg',
    'https://p.qqan.com/up/2022-9/16644331612803098.jpg',
    'https://p.qqan.com/up/2022-9/16644331611094175.jpg'
  ];
  final List<String> _tags = ['标签', '相册', '预览', '效果', '展示', '测试'];
  final PageController _pageController = PageController();

  @override
  State<PhotoViewPage> createState() => _PhotoViewPageState();
}

class _PhotoViewPageState extends State<PhotoViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("flutter photo_view"),
      ),
      body: Column(
        children: [
          const Text('单张图片'),
          Container(
            height: 200,
            child: PhotoView(
                imageProvider: const NetworkImage(
                    'https://p.qqan.com/up/2022-9/16644331618317549.jpg',
                    scale: 1)),
          ),
          const Text('多张图片'),
          Container(
            height: 300,
            child: PhotoViewGallery.builder(
              itemCount: widget._photos.length,
              builder: (context, index) {
                return PhotoViewGalleryPageOptions(
                    imageProvider: NetworkImage(widget._photos[index]),
                    initialScale: PhotoViewComputedScale.contained * 1,
                    heroAttributes:
                        PhotoViewHeroAttributes(tag: widget._tags[index]));
              },
              scrollPhysics: const BouncingScrollPhysics(),
              loadingBuilder: (context, event) => Center(
                child: Container(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    value: event == null
                        ? 0
                        : event.cumulativeBytesLoaded /
                            event.expectedTotalBytes!,
                  ),
                ),
              ),
              backgroundDecoration: const BoxDecoration(color: Colors.orange),
              pageController: widget._pageController,
              onPageChanged: onPageChanged,
            ),
          )
        ],
      ),
    );
  }

  void onPageChanged(int index) {
    debugPrint('页面变化了：$index');
  }
}
