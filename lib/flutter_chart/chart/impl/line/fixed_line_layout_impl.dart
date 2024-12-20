import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_sample/flutter_chart/chart/common/axis_delegate.dart';
import 'package:flutter_sample/flutter_chart/chart/common/base_layout_config.dart';
import 'package:flutter_sample/flutter_chart/chart/common/find.dart';
import 'package:flutter_sample/flutter_chart/chart/common/gesture_delegate.dart';
import 'package:flutter_sample/flutter_chart/chart/common/popup_spec.dart';
import 'package:flutter_sample/flutter_chart/chart/model/chart_data_model.dart';
import 'package:intl/intl.dart';

/// line charts配置
class FixedLayoutConfig extends BaseLayoutConfig<ChartDataModel> {
  FixedLayoutConfig({
    required super.data,
    required super.size,
    DateTime? startDateTime,
    super.axisCount,
    super.delegate,
    super.gestureDelegate,
    super.popupSpec,
    super.padding,
    super.initializePosition,
  }) :
        // 默认从当日的零时开始
        startDate = startDateTime ??
            DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
            );

  @override
  FixedLayoutConfig copyWith({
    List<ChartDataModel>? data,
    int? axisCount,
    Size? size,
    int? initializePosition,
    DateTime? startDate,
    AxisDelegate<ChartDataModel>? delegate,
    GestureDelegate? gestureDelegate,
    PopupSpec<ChartDataModel>? popupSpec,
    EdgeInsets? padding,
  }) {
    return FixedLayoutConfig(
      data: data ?? this.data,
      size: size ?? this.size,
      startDateTime: startDate ?? this.startDate,
      axisCount: axisCount ?? this.axisCount,
      initializePosition: initializePosition ?? this.initializePosition,
      delegate: delegate ?? this.delegate,
      gestureDelegate: gestureDelegate ?? this.gestureDelegate,
      popupSpec: popupSpec ?? this.popupSpec,
      padding: padding ?? this.padding,
    );
  }

  /// x轴的开始时间，默认为当日的凌晨
  final DateTime startDate;

  /// 本组数据的最大值
  double? _maxValue;

  @override
  double get maxValue {
    _maxValue ??= getMaxValue(data);
    return _maxValue!;
  }

  @override
  double getMaxValue(List<ChartDataModel> data) {
    var value = 0.0;
    for (var model in data) {
      value = max(value, model.yAxis);
    }
    return value;
  }

  /// 获取y轴的数据值
  @override
  num yAxisValue(ChartDataModel data) => data.yAxis;

  /// 拖拽的最大宽度
  @override
  double? get draggableWidth => size.width - padding.horizontal;

  /// 开始时间的秒数
  int get startTime => startDate.millisecondsSinceEpoch ~/ 1000;

  /// 获取x轴指定位置的值 07：00
  /// 优先级比[AxisDelegate.xAxisFormatter]高。
  @override
  String? xAxisValue(int index) {
    var milliseconds = (startTime + 3600 * index) * 1000;
    var date = DateTime.fromMillisecondsSinceEpoch(milliseconds);
    var str = DateFormat('HH:mm').format(date);
    if ('00:00' == str && date.day != startDate.day) {
      return DateFormat('MM-dd').format(date);
    }
    return str;
  }

  /// 初始选中点坐标
  @override
  Offset? getInitializeOffset() {
    if (initializePosition == null || data.isEmpty) {
      return null;
    }
    // 目标点位置
    var position = min(initializePosition!, data.length - 1);
    // 两点之间的距离
    var itemWidth = delegate!.domainPointSpacing;
    // 当前拖拽的偏移量
    var dragX = (gestureDelegate?.offset ?? Offset.zero).dx;
    // 1s时长对应的宽度，全程24小时，两个点之间的跨度为1小时。
    var dw = itemWidth / 3600; // 3600s为1小时

    var model = data[position];
    var seconds = model.xAxis.difference(startDate).inSeconds;
    return Offset(
      bounds.left + dragX + dw * seconds,
      bounds.bottom - yAxisValue(model) / maxValue * bounds.height,
    );
  }

  /// 根据手势触摸坐标查找指定数据点位
  @override
  ChartTargetFind<ChartDataModel>? findTarget(Offset offset) {
    ChartTargetFind<ChartDataModel>? find;
    // 两点之间的距离
    var itemWidth = delegate!.domainPointSpacing;
    // 选择点的最小匹配宽度
    var minSelectWidth = delegate!.minSelectWidth ?? itemWidth;
    // 当前拖拽的偏移量
    var dragX = (gestureDelegate?.offset ?? Offset.zero).dx;
    // 1s时长对应的宽度，全程24小时，两个点之间的跨度为1小时。
    var dw = itemWidth / 3600; // 3600s为1小时

    for (var index = 0; index < data.length; index++) {
      var model = data[index];
      var seconds = model.xAxis.difference(startDate).inSeconds;
      var curr = Offset(
        bounds.left + dragX + dw * seconds,
        bounds.bottom - yAxisValue(model) / maxValue * bounds.height,
      );
      if ((curr - offset).dx.abs() <= minSelectWidth) {
        find = ChartTargetFind(model, curr);
        break;
      }
    }
    return find;
  }
}
