import 'package:flutter/material.dart';

class DefaultPage extends StatelessWidget {
  const DefaultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'images/cat.jpg',
          width: 200,
          height: 200,
        ),
        Container(
          height: 10,
        ),
        const Text(
          '默认提示页面',
          textScaleFactor: 2.0,
        )
      ],
    );
  }
}
