import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 多按钮布局，可用于单行及多行按钮布局
/// 平均分配每个按钮宽度，自适应每行最高高度
/// 可添加按钮之间的间距，可添加多行之间的间距
class OptionGridView extends StatelessWidget {
  final int itemCount;
  final int colCount;
  final int columnCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final EdgeInsetsGeometry? padding;
  final IndexedWidgetBuilder itemBuilder;
  final bool shrinkWrap;
  final ScrollController? controller;
  final ScrollPhysics? physics;
  final bool alignHeight;

  /// [itemCount] 按钮总个数
  /// [colCount] 每行item个数
  /// [mainAxisSpacing] 行间距
  /// [crossAxisSpacing] 按钮间距
  OptionGridView({
    Key? key,
    required this.itemCount,
    required this.colCount,
    this.mainAxisSpacing = 0.0,
    this.crossAxisSpacing = 0.0,
    this.padding = const EdgeInsets.all(0),
    this.shrinkWrap = false,
    this.physics,
    this.alignHeight = false,
    this.controller,
    required this.itemBuilder,
  })  : assert(itemCount >= 0),
        assert(colCount > 0),
        columnCount = (itemCount / colCount).ceil(),
        assert(mainAxisSpacing >= 0),
        assert(crossAxisSpacing >= 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: columnCount,
      padding: padding,
      physics: physics,
      shrinkWrap: shrinkWrap,
      controller: controller ?? ScrollController(keepScrollOffset: false),
      separatorBuilder: (context, index) => SizedBox(height: mainAxisSpacing),
      itemBuilder: (context, index) => buildRow(context, index),
    );
  }

  Widget buildRow(BuildContext context, int index) {
    if (index < columnCount - 1) {
      List<Widget> row = [];
      for (int i = 0; i < colCount; i++) {
        row.add(Expanded(
          flex: 1,
          child: itemBuilder(context, i + index * colCount),
        ));
        if (crossAxisSpacing > 0.0 && i < colCount - 1) {
          row.add(SizedBox(width: crossAxisSpacing));
        }
      }
      return alignHeight
          ? IntrinsicHeight(
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start, children: row))
          : Row(crossAxisAlignment: CrossAxisAlignment.start, children: row);
    } else {
      // 最后一行
      List<Widget> row = [];
      for (int i = 0; i < colCount; i++) {
        int currentIndex = i + index * colCount;
        if (currentIndex < itemCount) {
          row.add(Expanded(
            flex: 1,
            child: itemBuilder(context, i + index * colCount),
          ));
          if (crossAxisSpacing > 0.0 && i < colCount - 1) {
            row.add(SizedBox(width: crossAxisSpacing));
          }
        } else {
          row.add(const Expanded(flex: 1, child: SizedBox()));
        }
      }
      return alignHeight
          ? IntrinsicHeight(
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start, children: row))
          : Row(crossAxisAlignment: CrossAxisAlignment.start, children: row);
    }
  }
}
