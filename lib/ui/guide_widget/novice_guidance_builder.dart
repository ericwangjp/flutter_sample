import 'package:flutter/material.dart';

class NoviceGuidanceBuilder {
  final BuildContext context;
  final List<Widget> guidanceWidgets;
  final Color maskColor;
  OverlayEntry? _lastOverlay;

  NoviceGuidanceBuilder(
      {required this.context,
      required this.guidanceWidgets,
      this.maskColor = Colors.black54});

  void showGuidanceWidgets() {
    if (guidanceWidgets.isEmpty) {
      return;
    }
    Widget guideWidget = guidanceWidgets.removeAt(0);
    _removeCurrentOverlay();
    _lastOverlay = OverlayEntry(builder: (ctx) {
      return GestureDetector(
        onTap: () {
          // 准备展示下一个overlay
          if (guidanceWidgets.isNotEmpty) {
            guideWidget = guidanceWidgets.removeAt(0);
            _lastOverlay?.markNeedsBuild();
          } else {
            _removeCurrentOverlay();
          }
        },
        child: Container(color: maskColor, child: guideWidget),
      );
    });
    Overlay.of(context)?.insert(_lastOverlay!);
  }

  void _removeCurrentOverlay() {
    if (_lastOverlay != null) {
      _lastOverlay!.remove();
      _lastOverlay = null;
    }
  }
}
