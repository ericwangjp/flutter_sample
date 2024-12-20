import 'package:flutter/material.dart';
import 'package:flutter_sample/learn/MultiPhotoPage.dart';
import 'package:flutter_sample/learn/SinglePhotoPage.dart';

class ExtendedImagePage extends StatefulWidget {
  const ExtendedImagePage({Key? key}) : super(key: key);

  @override
  State<ExtendedImagePage> createState() => _ExtendedImagePageState();
}

class _ExtendedImagePageState extends State<ExtendedImagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('extended image'),
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const SinglePhotoPage();
                }));
              },
              child: const Text('单张照片')),
          ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return MultiPhotoPage();
                }));
              },
              child: const Text('多张照片')),
        ],
      ),
    );
  }
}
