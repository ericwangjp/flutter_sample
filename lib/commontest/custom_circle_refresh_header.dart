import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';

import 'custom_circle_refresh_indicator.dart';

class CustomCircleRefreshHeader extends Header {
  CustomCircleRefreshHeader({
    this.key,
    double triggerOffset = 70,
    bool clamping = false,
    IndicatorPosition position = IndicatorPosition.above,
    Duration processedDuration = const Duration(seconds: 1),
    SpringDescription? spring,
    SpringBuilder? readySpringBuilder,
    bool springRebound = true,
    FrictionFactor? frictionFactor,
    bool safeArea = true,
    double? infiniteOffset,
    bool? hitOver,
    bool? infiniteHitOver,
    bool hapticFeedback = false,
    bool triggerWhenReach = false,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.backgroundColor,
    this.iconDimension = 24,
    this.succeededIcon,
    this.refreshIcon,
    this.failedIcon,
    this.noMoreIcon,
    this.pullIconBuilder,
    this.clipBehavior = Clip.hardEdge,
    this.iconTheme,
    this.progressIndicatorSize,
    this.progressIndicatorStrokeWidth,
  }) : super(
          triggerOffset: triggerOffset,
          clamping: clamping,
          processedDuration: processedDuration,
          spring: spring,
          readySpringBuilder: readySpringBuilder,
          springRebound: springRebound,
          frictionFactor: frictionFactor,
          safeArea: safeArea,
          infiniteOffset: infiniteOffset,
          hitOver: hitOver,
          infiniteHitOver: infiniteHitOver,
          position: position,
          hapticFeedback: hapticFeedback,
          triggerWhenReach: triggerWhenReach,
        );

  final Key? key;

  /// The location of the widget.
  /// Only supports [MainAxisAlignment.center],
  /// [MainAxisAlignment.start] and [MainAxisAlignment.end].
  final MainAxisAlignment mainAxisAlignment;

  /// Background color.
  final Color? backgroundColor;

  /// The dimension of the icon area.
  final double iconDimension;

  /// Icon when [IndicatorResult.refreshing].
  final Widget? refreshIcon;

  /// Icon when [IndicatorResult.success].
  final Widget? succeededIcon;

  /// Icon when [IndicatorResult.fail].
  final Widget? failedIcon;

  /// Icon when [IndicatorResult.noMore].
  final Widget? noMoreIcon;

  /// Icon on pull.
  final RefreshPullIconBuilder? pullIconBuilder;

  /// Link [Stack.clipBehavior].
  final Clip clipBehavior;

  /// Icon style.
  final IconThemeData? iconTheme;

  /// Progress indicator size.
  final double? progressIndicatorSize;

  /// Progress indicator stroke width.
  /// See [CircularProgressIndicator.strokeWidth].
  final double? progressIndicatorStrokeWidth;

  @override
  Widget build(BuildContext context, IndicatorState state) {
    return CircleIndicator(
      key: key,
      state: state,
      backgroundColor: backgroundColor,
      mainAxisAlignment: mainAxisAlignment,
      iconDimension: iconDimension,
      reverse: state.reverse,
      succeededIcon: succeededIcon,
      refreshIcon:refreshIcon,
      failedIcon: failedIcon,
      noMoreIcon: noMoreIcon,
      pullIconBuilder: pullIconBuilder,
      clipBehavior: clipBehavior,
      iconTheme: iconTheme,
      progressIndicatorSize: progressIndicatorSize,
      progressIndicatorStrokeWidth: progressIndicatorStrokeWidth,
    );
  }
}
