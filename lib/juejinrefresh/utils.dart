import 'package:flutter/cupertino.dart';

class Utils {
  static Widget buildJuejinSvg(Color color) {
    return Center(
      child: Image.asset(
        'images/little_girl.jpeg',
        color: color,
      ),
    );
  }
}
