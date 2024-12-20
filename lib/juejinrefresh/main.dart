import 'package:english_words/english_words.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'juejin_animation.dart';
import 'utils.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Tutorial',
      home: _PullToRefreshExample(),
    );
  }
}

class _PullToRefreshExample extends StatefulWidget {
  @override
  _PullToRefreshExampleState createState() => _PullToRefreshExampleState();
}

class _PullToRefreshExampleState extends State<_PullToRefreshExample>
    with TickerProviderStateMixin {
  final _data = <WordPair>[];

  late AnimationController _juejinAnimationController;

  @override
  void initState() {
    super.initState();
    _data.addAll(generateWordPairs().take(20));

    _juejinAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Tutorial'),
      ),
      body: _buildList(),
    );
  }

  Widget _buildList() {
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        CupertinoSliverRefreshControl(
          onRefresh: _refreshData,
          builder: _buildRefreshBuilder,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              WordPair wordPair = _data[index];

              return _buildListItem(wordPair.asString, context);
            },
            childCount: _data.length,
          ),
        ),
      ],
    );
  }

  Widget _buildRefreshBuilder(
    BuildContext context,
    RefreshIndicatorMode refreshState,
    double pulledExtent,
    double refreshTriggerPullDistance,
    double refreshIndicatorExtent,
  ) {
    switch (refreshState) {
      case RefreshIndicatorMode.inactive:
      case RefreshIndicatorMode.drag:
      case RefreshIndicatorMode.done:
        return Utils.buildJuejinSvg(Colors.grey);
      case RefreshIndicatorMode.armed:
        return Utils.buildJuejinSvg(Colors.blue);
      case RefreshIndicatorMode.refresh:
        return JueJinAnimation(
          animationController: _juejinAnimationController,
          controller: _juejinAnimationController.view,
        );
      default:
        return Utils.buildJuejinSvg(Colors.grey);
    }
  }

  Widget _buildListItem(String word, BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(word),
      ),
    );
  }

  Future _refreshData() async {
    await Future.delayed(Duration(milliseconds: 2000));
    _data.clear();
    _data.addAll(generateWordPairs().take(20));

    setState(() {});
  }

  @override
  void dispose() {
    _juejinAnimationController.dispose();
    super.dispose();
  }
}
