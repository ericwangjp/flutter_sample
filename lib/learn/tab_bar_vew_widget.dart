import 'package:flutter/material.dart';

class TabBarViewWidget extends StatefulWidget {
  const TabBarViewWidget({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<TabBarViewWidget> createState() => _TabBarViewWidgetState();
}

class _TabBarViewWidgetState extends State<TabBarViewWidget> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    debugPrint('fqy--TabBarViewWidget initState:${widget.title}');
    debugPrint('fqy--是否挂载 initState:$mounted');
  }

  @override
  void dispose() {
    debugPrint('fqy--TabBarViewWidget dispose:${widget.title}');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Text(
      widget.title,
      textScaleFactor: 2,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
