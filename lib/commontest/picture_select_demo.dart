import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "flutter",
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
  late ImagePicker _imagePicker;
  String _takePhotoPath = '';
  int _selectPhotoLength = 0;
  List<String> _photoList = [];
  dynamic _errorInfo;

  @override
  void initState() {
    super.initState();
    _imagePicker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("flutter图片选择"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () async {
                final XFile? image =
                    await _imagePicker.pickImage(source: ImageSource.camera);
                setState(() {
                  _takePhotoPath = image?.path ?? '';
                });
              },
              child: const Text('拍照')),
          if (_takePhotoPath.isNotEmpty)
            Image.file(File(_takePhotoPath), width: 200),
          ElevatedButton(
              onPressed: () {
                _errorInfo = null;
                _imagePicker
                    .pickMultiImage(imageQuality: 90)
                    .catchError((e) {
                      debugPrint('fqy-出错了：$e');
                      setState(() {
                        _errorInfo = e ;
                      });
                })
                    .then((value) => setState(() {
                          _photoList = value.map((e) => e.path).toList();
                          _selectPhotoLength = value.length;
                        }));
                // final List<XFile> images = await _imagePicker.pickMultiImage(imageQuality: 90);
                // setState(() {
                //   _photoList = images.map((e) => e.path).toList();
                //   _selectPhotoLength = images.length;
                // });
              },
              child: const Text('相册选择图片')),
          Text('选择图片数量：$_selectPhotoLength \n图片地址：${_photoList.join('\n')}'),
          Text('图片选择出错：$_errorInfo\n${_errorInfo?.code}')
        ],
      ),
    );
  }
}
