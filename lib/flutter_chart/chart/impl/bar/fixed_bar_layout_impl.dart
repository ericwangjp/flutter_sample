import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_sample/flutter_chart/chart/common/axis_delegate.dart';
import 'package:flutter_sample/flutter_chart/chart/common/base_layout_config.dart';
import 'package:flutter_sample/flutter_chart/chart/common/find.dart';
import 'package:flutter_sample/flutter_chart/chart/common/gesture_delegate.dart';
import 'package:flutter_sample/flutter_chart/chart/common/popup_spec.dart';
import 'package:flutter_sample/flutter_chart/chart/model/chart_data_bar.dart';
import 'package:intl/intl.dart';

/// bar charts配置
class FixedBarLayoutConfig extends BaseLayoutConfig<ChartDataBar> {
  FixedBarLayoutConfig({
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
  FixedBarLayoutConfig copyWith({
    List<ChartDataBar>? data,
    Size? size,
    int? axisCount,
    int? initializePosition,
    DateTime? startDate,
    AxisDelegate<ChartDataBar>? delegate,
    GestureDelegate? gestureDelegate,
    PopupSpec<ChartDataBar>? popupSpec,
    EdgeInsets? padding,
  }) {
    return FixedBarLayoutConfig(
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

  /// 开始时间的秒数
  int get startTime {
    var hour = startDate.hour;
    var minute = startDate.minute;
    var seconds = startDate.second + minute * 60 + hour * 3600;
    return seconds;
  }

  /// 获取x轴指定位置的值 07：00
  /// 优先级比[AxisDelegate.xAxisFormatter]高。
  @override
  String? xAxisValue(int index) {
    var hour = index;
    var date = DateTime(startDate.year, startDate.month, startDate.day, hour);
    date = date.add(Duration(seconds: startTime));
    var str = DateFormat('HH:mm').format(date);
    if ('00:00' == str && date.day != startDate.day) {
      return DateFormat('MM-dd').format(date);
    }
    return str;
  }

  /// 拖拽的最大宽度
  @override
  double? get draggableWidth => size.width - padding.horizontal;

  /// 初始选中点坐标
  @override
  Offset? getInitializeOffset() {
    if (delegate == null ||
        initializePosition == null ||
        initializePosition! < 0 ||
        data.isEmpty) {
      return null;
    }
    // 目标点位置
    var position = min(initializePosition!, data.length - 1);
    // 两点之间的距离
    var itemWidth = delegate!.domainPointSpacing;
    // 当前拖拽的偏移量
    var dragX = gestureDelegate?.offset.dx ?? 0;

    /// y轴方向每段高度。
    var itemHeight = bounds.height / delegate!.hintLineNum;

    /// 1s时长对应的宽度，全程24小时，两个点之间的跨度为1小时。
    var dw = itemWidth / 3600; // 3600s为1小时

    /// bar高度
    var barHeight = 9;

    /// bubble 距离bar 右侧的距离
    var bubblePadding = 5;

    var model = data[position];
    int seconds = model.time.difference(startDate).inSeconds + model.duration;
    return Offset(
      bounds.left + dragX + seconds * dw - bubblePadding,
      bounds.bottom - model.index * itemHeight - barHeight,
    );
  }

  /// 根据手势触摸坐标查找指定数据点位
  @override
  ChartTargetFind<ChartDataBar>? findTarget(Offset offset) {
    ChartTargetFind<ChartDataBar>? find;
    if (delegate == null) return null;
    // 两点之间的距离
    var itemWidth = delegate!.domainPointSpacing;
    // 选择点的最小匹配宽度
    var minSelectWidth = delegate!.minSelectWidth ?? itemWidth;
    // 当前拖拽的偏移量
    var dragX = (gestureDelegate!.offset).dx;

    /// y轴方向每段高度。
    var itemHeight = bounds.height / delegate!.hintLineNum;

    /// 1s时长对应的宽度，全程24小时，两个点之间的跨度为1小时。
    var dw = itemWidth / 3600; // 3600s为1小时

    /// bar高度
    var barHeight = 9;

    /// bubble 距离bar 右侧的距离
    var bubblePadding = 5;

    for (var index = 0; index < data.length; index++) {
      var model = data[index];
      if (!model.hasBubble) continue;

      int seconds = model.time.difference(startDate).inSeconds + model.duration;

      var curr = Offset(
        bounds.left + dragX + seconds * dw - bubblePadding,
        bounds.bottom - model.index * itemHeight - barHeight,
      );
      if ((curr - offset).dx.abs() <= minSelectWidth) {
        find = ChartTargetFind(model, curr);
        break;
      }
    }
    return find;
  }
}
