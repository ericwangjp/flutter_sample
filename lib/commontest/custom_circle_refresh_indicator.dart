import 'dart:math' as math;

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';

/// Pull icon widget builder.
typedef RefreshPullIconBuilder = Widget Function(
    BuildContext context, IndicatorState state, Animation<double> animation);

/// Default progress indicator size.
const _kDefaultProgressIndicatorSize = 20.0;

/// Default progress indicator stroke width.
const _kDefaultProgressIndicatorStrokeWidth = 2.0;

/// CircleIndicator indicator.
/// Base widget for [ClassicHeader] and [ClassicFooter].
class CircleIndicator extends StatefulWidget {
  /// Indicator properties and state.
  final IndicatorState state;

  /// The location of the widget.
  /// Only supports [MainAxisAlignment.center],
  /// [MainAxisAlignment.start] and [MainAxisAlignment.end].
  final MainAxisAlignment mainAxisAlignment;

  /// Background color.
  final Color? backgroundColor;

  /// The dimension of the icon area.
  final double iconDimension;

  /// True for up and left.
  /// False for down and right.
  final bool reverse;

  /// Icon when [IndicatorResult.success].
  final Widget? succeededIcon;

  /// Icon when [IndicatorResult.refresh].
  final Widget? refreshIcon;

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

  const CircleIndicator({
    Key? key,
    required this.state,
    required this.mainAxisAlignment,
    this.backgroundColor,
    required this.reverse,
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
  })  : assert(
            mainAxisAlignment == MainAxisAlignment.start ||
                mainAxisAlignment == MainAxisAlignment.center ||
                mainAxisAlignment == MainAxisAlignment.end,
            'Only supports [MainAxisAlignment.center], [MainAxisAlignment.start] and [MainAxisAlignment.end].'),
        super(key: key);

  @override
  State<CircleIndicator> createState() => _CircleIndicatorState();
}

class _CircleIndicatorState extends State<CircleIndicator>
    with TickerProviderStateMixin<CircleIndicator> {
  /// Icon [AnimatedSwitcher] switch key.
  late GlobalKey _iconAnimatedSwitcherKey;

  /// Update time.
  late DateTime _updateTime;

  /// Icon animation controller.
  late AnimationController _iconAnimationController;
  late AnimationController _iconRefreshAnimationController;

  MainAxisAlignment get _mainAxisAlignment => widget.mainAxisAlignment;

  Axis get _axis => widget.state.axis;

  double get _offset => widget.state.offset;

  double get _actualTriggerOffset => widget.state.actualTriggerOffset;

  double get _triggerOffset => widget.state.triggerOffset;

  double get _safeOffset => widget.state.safeOffset;

  IndicatorMode get _mode => widget.state.mode;

  IndicatorResult get _result => widget.state.result;

  @override
  void initState() {
    super.initState();
    _iconAnimatedSwitcherKey = GlobalKey();
    _updateTime = DateTime.now();
    _iconAnimationController = AnimationController(
      value: 0,
      vsync: this,
      duration: const Duration(microseconds: 1000),
    );
    // _iconAnimationController.addListener(() => setState(() {}));
    _iconRefreshAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
  }

  @override
  void didUpdateWidget(CircleIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    debugPrint('当前刷新状态：${widget.state.mode}');
    // Update time.
    if (widget.state.mode == IndicatorMode.processed &&
        oldWidget.state.mode != IndicatorMode.processed) {
      _updateTime = DateTime.now();
      debugPrint('刷新完成');
      // _iconRefreshAnimationController.reset();
    }

    if(widget.state.mode == IndicatorMode.inactive &&
        oldWidget.state.mode == IndicatorMode.done){
      _iconAnimationController.reset();
      // 此时停止刷新动画
      _iconRefreshAnimationController.reset();
    }
    if (widget.state.mode == IndicatorMode.armed &&
        oldWidget.state.mode == IndicatorMode.drag) {
      // Armed animation.
      debugPrint('拖拽中');
      _iconAnimationController.animateTo(1,
          duration: const Duration(milliseconds: 200));
    } else if (widget.state.mode == IndicatorMode.drag &&
        oldWidget.state.mode == IndicatorMode.armed) {
      // Recovery animation.
      debugPrint('拖拽放手');
      _iconAnimationController.animateBack(0,
          duration: const Duration(milliseconds: 200));
    } else if (widget.state.mode == IndicatorMode.ready &&
        oldWidget.state.mode == IndicatorMode.ready) {
      // Recovery animation.
      debugPrint('刷新中');
      _iconRefreshAnimationController.repeat();
    } else if (widget.state.mode == IndicatorMode.processing &&
        oldWidget.state.mode != IndicatorMode.processing) {
      // Reset animation.
      debugPrint('加载中');
      _iconAnimationController.reset();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _iconAnimationController.dispose();
    _iconRefreshAnimationController.dispose();
  }

  /// Build icon.
  Widget _buildIcon() {
    Widget icon;
    final iconTheme = widget.iconTheme ?? Theme.of(context).iconTheme;
    ValueKey iconKey;
    if (_result == IndicatorResult.noMore) {
      iconKey = const ValueKey(IndicatorResult.noMore);
      icon = SizedBox(
        child: widget.noMoreIcon ??
            const Icon(
              Icons.inbox_outlined,
            ),
      );
    } else if (_mode == IndicatorMode.processing ||
        _mode == IndicatorMode.ready) {
      iconKey = const ValueKey(IndicatorMode.processing);
      final progressIndicatorSize =
          widget.progressIndicatorSize ?? _kDefaultProgressIndicatorSize;
      debugPrint('刷新动画值：${_iconRefreshAnimationController.value}');
      icon = SizedBox(
        width: progressIndicatorSize,
        height: progressIndicatorSize,
        child: widget.refreshIcon != null
            ? RotationTransition(
                turns: _iconRefreshAnimationController,
                child: widget.refreshIcon,
              )
            : CircularProgressIndicator(
                strokeWidth: widget.progressIndicatorStrokeWidth ??
                    _kDefaultProgressIndicatorStrokeWidth,
                color: iconTheme.color,
              ),
      );
    } else if (_mode == IndicatorMode.processed ||
        _mode == IndicatorMode.done) {
      if (_result == IndicatorResult.fail) {
        iconKey = const ValueKey(IndicatorResult.fail);
        icon = SizedBox(
          child: widget.failedIcon ??
              const Icon(
                Icons.error_outline,
              ),
        );
      } else {
        iconKey = const ValueKey(IndicatorResult.success);
        icon = widget.succeededIcon != null
            ? RotationTransition(
                turns: _iconRefreshAnimationController,
                child: widget.succeededIcon,
              )
            : SizedBox(
                child: widget.succeededIcon ??
                    Transform.rotate(
                      angle: _axis == Axis.vertical ? 0 : -math.pi / 2,
                      child: const Icon(
                        Icons.done,
                      ),
                    ),
              );
      }
    } else {
      iconKey = const ValueKey(IndicatorMode.drag);
      icon = SizedBox(
        child: widget.pullIconBuilder
                ?.call(context, widget.state, _iconAnimationController) ??
            Transform.rotate(
              angle: -math.pi * _iconAnimationController.value,
              child: Icon(widget.reverse
                  ? (_axis == Axis.vertical
                      ? Icons.arrow_upward
                      : Icons.arrow_back)
                  : (_axis == Axis.vertical
                      ? Icons.arrow_downward
                      : Icons.arrow_forward)),
            ),
      );
    }
    return IconTheme(
      key: iconKey,
      data: iconTheme,
      child: icon,
    );
    // return AnimatedSwitcher(
    //   key: _iconAnimatedSwitcherKey,
    //   duration: const Duration(milliseconds: 300),
    //   reverseDuration: const Duration(milliseconds: 200),
    //   transitionBuilder: (child, animation) {
    //     return FadeTransition(
    //       opacity: animation,
    //       child: ScaleTransition(
    //         scale: animation,
    //         child: child,
    //       ),
    //     );
    //   },
    //   child: IconTheme(
    //     key: iconKey,
    //     data: iconTheme,
    //     child: icon,
    //   ),
    // );
  }

  /// When the list direction is vertically.
  Widget _buildVerticalWidget() {
    return Stack(
      clipBehavior: widget.clipBehavior,
      children: [
        if (_mainAxisAlignment == MainAxisAlignment.center)
          Positioned(
            left: 0,
            right: 0,
            top: _offset < _actualTriggerOffset
                ? -(_actualTriggerOffset -
                        _offset +
                        (widget.reverse ? _safeOffset : -_safeOffset)) /
                    2
                : (!widget.reverse ? _safeOffset : 0),
            bottom: _offset < _actualTriggerOffset
                ? null
                : (widget.reverse ? _safeOffset : 0),
            height:
                _offset < _actualTriggerOffset ? _actualTriggerOffset : null,
            child: Center(
              child: _buildVerticalBody(),
            ),
          ),
        if (_mainAxisAlignment != MainAxisAlignment.center)
          Positioned(
            left: 0,
            right: 0,
            top: _mainAxisAlignment == MainAxisAlignment.start
                ? (!widget.reverse ? _safeOffset : 0)
                : null,
            bottom: _mainAxisAlignment == MainAxisAlignment.end
                ? (widget.reverse ? _safeOffset : 0)
                : null,
            child: _buildVerticalBody(),
          ),
      ],
    );
  }

  /// The body when the list is vertically direction.
  Widget _buildVerticalBody() {
    return Container(
      alignment: Alignment.center,
      height: _triggerOffset,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            width: widget.iconDimension,
            child: _buildIcon(),
          ),
        ],
      ),
    );
  }

  /// When the list direction is horizontally.
  Widget _buildHorizontalWidget() {
    return Stack(
      clipBehavior: widget.clipBehavior,
      children: [
        if (_mainAxisAlignment == MainAxisAlignment.center)
          Positioned(
            left: _offset < _actualTriggerOffset
                ? -(_actualTriggerOffset -
                        _offset +
                        (widget.reverse ? _safeOffset : -_safeOffset)) /
                    2
                : (!widget.reverse ? _safeOffset : 0),
            right: _offset < _actualTriggerOffset
                ? null
                : (widget.reverse ? _safeOffset : 0),
            top: 0,
            bottom: 0,
            width: _offset < _actualTriggerOffset ? _actualTriggerOffset : null,
            child: Center(
              child: _buildHorizontalBody(),
            ),
          ),
        if (_mainAxisAlignment != MainAxisAlignment.center)
          Positioned(
            left: _mainAxisAlignment == MainAxisAlignment.start
                ? (!widget.reverse ? _safeOffset : 0)
                : null,
            right: _mainAxisAlignment == MainAxisAlignment.end
                ? (widget.reverse ? _safeOffset : 0)
                : null,
            top: 0,
            bottom: 0,
            child: _buildHorizontalBody(),
          ),
      ],
    );
  }

  /// The body when the list is horizontal direction.
  Widget _buildHorizontalBody() {
    return Container(
      alignment: Alignment.center,
      width: _triggerOffset,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            height: widget.iconDimension,
            child: _buildIcon(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double offset = _offset;
    if (widget.state.indicator.infiniteOffset != null &&
        widget.state.indicator.position == IndicatorPosition.locator &&
        (_mode != IndicatorMode.inactive ||
            _result == IndicatorResult.noMore)) {
      offset = _actualTriggerOffset;
    }
    return Container(
      color: widget.backgroundColor,
      width: _axis == Axis.vertical ? double.infinity : offset,
      height: _axis == Axis.horizontal ? double.infinity : offset,
      child: _axis == Axis.vertical
          ? _buildVerticalWidget()
          : _buildHorizontalWidget(),
    );
  }
}
