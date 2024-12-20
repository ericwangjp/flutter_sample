import 'package:flutter/material.dart';

/// 基础样式
/// [showTitleBar] 是否显示头部（选择器以上的控件） 默认：true
/// [menu] 头部和选择器之间的菜单widget,默认null 不显示
/// [title] 头部 中间的标题  默认SizedBox() 不显示
/// [pickerHeight] 选择器下面 picker 的整体高度  固定高度：220.0
/// [pickerTitleHeight]  选择器上面 title 确认、取消的整体高度  固定高度：44.0
/// [pickerItemHeight]  选择器每个被选中item的高度：40.0
/// [menuHeight]  头部和选择器之间的菜单高度  固定高度：36.0
/// [cancelButton]  头部的取消按钮
/// [commitButton]  头部的确认按钮
/// [textColor]  选择器的文字颜色 默认黑色
/// [backgroundColor]  选择器的背景颜色 默认白色
/// [headDecoration] 头部Container 的Decoration   默认：BoxDecoration(color: Colors.white)
///
class PickerStyle {
  BuildContext? _context;

  bool? _showTitleBar;
  bool? _showHeadLine;
  Widget? _header;
  Widget? _footer;
  double? _pickerHeight;
  double? _pickerTitleHeight;
  double? _pickerItemHeight;
  double? _headerHeight;
  double? _footerHeight;
  double? _headerLineHeight;
  double? _borderRadius;
  double? _dividerSpacing;

  Widget? _cancelButton;
  Widget? _commitButton;
  Widget? _title;
  Decoration? _headDecoration;
  Color? _backgroundColor;
  Color? _textColor;
  Color? _dividerColor;
  Widget? _itemOverlay;

  PickerStyle({
    BuildContext? context,
    bool? showTitleBar,
    bool? showHeadLine,
    Widget? header,
    Widget? footer,
    double? pickerHeight,
    double? pickerTitleHeight,
    double? pickerItemHeight,
    double? headerHeight,
    double? footerHeight,
    double? headerLineHeight,
    double? borderRadius,
    double? dividerSpacing,
    Widget? cancelButton,
    Widget? commitButton,
    Widget? title,
    Decoration? headDecoration,
    Color? backgroundColor,
    Color? textColor,
    Color? dividerColor,
    Widget? itemOverlay,
  }) {
    _context = context;
    _showTitleBar = showTitleBar;
    _showHeadLine = showHeadLine;
    _header = header;
    _footer = footer;

    _pickerHeight = pickerHeight;
    _pickerTitleHeight = pickerTitleHeight;
    _pickerItemHeight = pickerItemHeight;
    _headerHeight = headerHeight;
    _footerHeight = footerHeight;
    _headerLineHeight = headerLineHeight;
    _borderRadius = borderRadius;
    _dividerSpacing = dividerSpacing;

    _cancelButton = cancelButton;
    _commitButton = commitButton;
    _title = title;
    _headDecoration = headDecoration;
    _backgroundColor = backgroundColor;
    _textColor = textColor;
    _dividerColor = dividerColor;
    _itemOverlay = itemOverlay;
  }

  set context(BuildContext? value) {
    _context = value;
  }

  set headerLineHeight(double value) {
    _headerLineHeight = value;
  }

  set dividerSpacing(double value) {
    _dividerSpacing = value;
  }

  set headerHeight(double value) {
    _headerHeight = value;
  }

  set header(Widget? value) {
    _header = value;
  }

  set footerHeight(double value) {
    _footerHeight = value;
  }

  set footer(Widget? value) {
    _footer = value;
  }

  set borderRadius(double value) {
    _borderRadius = value;
  }

  set pickerHeight(double value) {
    _pickerHeight = value;
  }

  set pickerTitleHeight(double value) {
    _pickerTitleHeight = value;
  }

  set pickerItemHeight(double value) {
    _pickerItemHeight = value;
  }

  set cancelButton(Widget value) {
    _cancelButton = value;
  }

  set commitButton(Widget value) {
    _commitButton = value;
  }

  set itemOverlay(Widget? value) {
    _itemOverlay = value;
  }

  set title(Widget value) {
    _title = value;
  }

  set headDecoration(Decoration value) {
    _headDecoration = value;
  }

  set backgroundColor(Color value) {
    _backgroundColor = value;
  }

  set textColor(Color value) {
    _textColor = value;
  }

  set dividerColor(Color value) {
    _dividerColor = value;
  }

  set showTitleBar(bool value) {
    _showTitleBar = value;
  }

  set showHeadLine(bool value) {
    _showHeadLine = value;
  }

  BuildContext? get context => _context;

  /// 选择器背景色 默认白色
  Color get backgroundColor => _backgroundColor ?? Colors.white;

  Decoration get headDecoration =>
      _headDecoration ?? const BoxDecoration(color: Colors.white);

  Widget? get header => _header;

  Widget? get footer => _footer;

  double get headerHeight => _headerHeight ?? 36.0;

  double get footerHeight => _footerHeight ?? 0.0;

  double get headerLineHeight => _headerLineHeight ?? 0.0;

  double get borderRadius => _borderRadius ?? 0.0;

  double get dividerSpacing => _dividerSpacing ?? 0.0;

  double get pickerHeight => _pickerHeight ?? 220.0;

  double get pickerItemHeight => _pickerItemHeight ?? 40.0;

  double get pickerTitleHeight => _pickerTitleHeight ?? 44.0;

  bool get showTitleBar => _showTitleBar ?? true;

  bool get showHeaderLine => _showHeadLine ?? true;

  Color get textColor => _textColor ?? Colors.black87;

  Color get dividerColor => _dividerColor ?? Colors.grey;

  Widget get title => _title ?? const SizedBox();

  Widget get commitButton => getCommitButton();

  Widget get cancelButton => getCancelButton();

  Widget? get itemOverlay => _itemOverlay;

  Widget getCommitButton() {
    return _commitButton ??
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(left: 12, right: 22),
          child: Text('确定',
              style: TextStyle(
                  color: Theme.of(context!).primaryColor, fontSize: 16.0)),
        );
  }

  Widget getCancelButton() {
    return _cancelButton ??
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(left: 22, right: 12),
          child: Text('取消',
              style: TextStyle(
                  color: Theme.of(context!).unselectedWidgetColor,
                  fontSize: 16.0)),
        );
  }
}
