import 'package:flutter/material.dart';
import 'package:flutter_sample/wheelpicker/style/picker_style.dart';

/// 无标题样式
class NoTitleStyle extends PickerStyle {
  NoTitleStyle() {
    showTitleBar = false;
  }

  /// 夜间
  NoTitleStyle.dark() {
    showTitleBar = false;
    backgroundColor = Colors.grey[800]!;
    textColor = Colors.white;
  }
}

/// 默认样式
class DefaultPickerStyle extends PickerStyle {
  DefaultPickerStyle({String? title}) {
    if (borderRadius > 0) {
      headDecoration = BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(borderRadius),
              topRight: Radius.circular(borderRadius)));
    }
    if (title != null && title != '') {
      this.title = Center(
          child: Text(title,
              style: const TextStyle(color: Colors.grey, fontSize: 14)));
    }
  }

  /// 夜间
  DefaultPickerStyle.dark({String? title}) {
    commitButton = Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: 12, right: 22),
      child: const Text('确定',
          style: TextStyle(color: Colors.white, fontSize: 16.0)),
    );

    cancelButton = Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: 22, right: 12),
      child: const Text('取消',
          style: TextStyle(color: Colors.white, fontSize: 16.0)),
    );

    headDecoration = BoxDecoration(
        color: Colors.grey[800],
        borderRadius: borderRadius <= 0
            ? null
            : BorderRadius.only(
                topLeft: Radius.circular(borderRadius),
                topRight: Radius.circular(borderRadius)));

    if (title != null && title != '') {
      this.title = Center(
          child: Text(title,
              style: const TextStyle(color: Colors.white, fontSize: 14)));
    }

    backgroundColor = Colors.grey[800]!;
    textColor = Colors.white;
  }
}

/// 关闭按钮样式
class ClosePickerStyle extends PickerStyle {
  /// 日间
  ClosePickerStyle({String? title}) {
    headDecoration = BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius <= 0
            ? null
            : BorderRadius.only(
                topLeft: Radius.circular(borderRadius),
                topRight: Radius.circular(borderRadius)));

    cancelButton = const SizedBox();
    if (title != null && title != '') {
      this.title = Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Align(
            alignment: Alignment.centerLeft,
            child: Text(title,
                style: const TextStyle(color: Colors.grey, fontSize: 14))),
      );
    }
    commitButton = Container(
      // padding: const EdgeInsets.all(4),
      margin: const EdgeInsets.only(right: 12),
      child: const Icon(Icons.close, color: Colors.grey, size: 28),
    );
  }

  /// 夜间
  ClosePickerStyle.dark({String? title}) {
    headDecoration = BoxDecoration(
        color: Colors.grey[800],
        borderRadius: borderRadius <= 0
            ? null
            : BorderRadius.only(
                topLeft: Radius.circular(borderRadius),
                topRight: Radius.circular(borderRadius)));

    cancelButton = const SizedBox();
    commitButton = Container(
      margin: const EdgeInsets.only(right: 12),
      child: const Icon(Icons.close, color: Colors.white, size: 28),
    );
    if (title != null && title != '') {
      this.title = Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Align(
            alignment: Alignment.centerLeft,
            child: Text(title,
                style: const TextStyle(color: Colors.white, fontSize: 14))),
      );
    }
    backgroundColor = Colors.grey[800]!;
    textColor = Colors.white;
  }
}

/// 圆角按钮样式
class RaisedPickerStyle extends PickerStyle {
  RaisedPickerStyle({String? title, Color color = Colors.blue}) {
    headDecoration = BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius <= 0
            ? null
            : BorderRadius.only(
                topLeft: Radius.circular(borderRadius),
                topRight: Radius.circular(borderRadius)));
    commitButton = Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
      margin: const EdgeInsets.only(right: 22),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
      child: const Text('确定',
          style: TextStyle(color: Colors.white, fontSize: 15.0)),
    );

    cancelButton = Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
      margin: const EdgeInsets.only(left: 22),
      decoration: BoxDecoration(
          border: Border.all(color: color, width: 1),
          borderRadius: BorderRadius.circular(4)),
      child: Text('取消', style: TextStyle(color: color, fontSize: 15.0)),
    );

    if (title != null && title != '') {
      this.title = Center(
          child: Text(title,
              style: const TextStyle(color: Colors.grey, fontSize: 14)));
    }
  }

  /// 夜间
  RaisedPickerStyle.dark({String? title, Color? color}) {
    headDecoration = BoxDecoration(
        color: Colors.grey[800],
        borderRadius: borderRadius <= 0
            ? null
            : BorderRadius.only(
                topLeft: Radius.circular(borderRadius),
                topRight: Radius.circular(borderRadius)));

    commitButton = Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
      margin: const EdgeInsets.only(right: 22),
      decoration: BoxDecoration(
          color: color ?? Colors.blue, borderRadius: BorderRadius.circular(4)),
      child: const Text('确定',
          style: TextStyle(color: Colors.white, fontSize: 15.0)),
    );

    cancelButton = Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
      margin: const EdgeInsets.only(left: 22),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 1),
          borderRadius: BorderRadius.circular(4)),
      child: const Text('取消',
          style: TextStyle(color: Colors.white, fontSize: 15.0)),
    );

    if (title != null && title != '') {
      this.title = Center(
          child: Text(title,
              style: const TextStyle(color: Colors.white, fontSize: 14)));
    }

    backgroundColor = Colors.grey[800]!;
    textColor = Colors.white;
  }
}
