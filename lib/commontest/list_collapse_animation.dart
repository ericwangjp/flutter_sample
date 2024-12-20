import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "列表动画",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<MSExpansionPanelModel> _models = [];

  @override
  void initState() {
    for (var i = 0; i < 20; i++) {
      _models
          .add(MSExpansionPanelModel("EP${i + 1}", "Title EP${i + 1}", false));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("flutter 列表动画"),
      ),
      // body: SingleChildScrollView(
      //   child: _expansionPanelList(),
      // ),
      body: ListView.separated(
        itemCount: _models.length,
        itemBuilder: (BuildContext context, int index) {
          return _itemBuilder(context, index);
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider();
        },
      ),
    );
  }

  // 创建 ExpansionPanelList
  ExpansionPanelList _expansionPanelList() {
    return ExpansionPanelList(
      // 子控件数组 List<ExpansionPanel>
      children: _initChildrenForExpansionPanel(),
      // 分割线
      dividerColor: Colors.green,
      //动画时间，默认为 kThemeAnimationDuration
      animationDuration: Duration(milliseconds: 200),
      // 展开后 Header 的 padding，默认为 _kPanelHeaderExpandedDefaultPadding
      expandedHeaderPadding: EdgeInsets.all(8),
      // 展开收起回调函数，(index, isExpand){}，返回当前下标以及是否折叠
      expansionCallback: (index, isExpand) {
        _models[index].isExpanded = !isExpand;
        setState(() {});
      },
      // 阴影大小
      elevation: 2,
    );
  }

  List<ExpansionPanel> _initChildrenForExpansionPanel() {
    List<ExpansionPanel> _childrenForExpansionPanel = [];
    _models.forEach((element) {
      _childrenForExpansionPanel.add(_expansionPanelForModel(element));
    });
    return _childrenForExpansionPanel;
  }

  // 创建 ExpansionPanel
  ExpansionPanel _expansionPanelForModel(MSExpansionPanelModel model) {
    return ExpansionPanel(
      // header 构造函数
      headerBuilder: (context, isExpanded) {
        return Container(
          height: 56,
          alignment: Alignment.centerLeft,
          child: Text(model.title),
        );
      },
      // body 展开部分 Widget
      body: Container(
        height: 100,
        color: Colors.red,
      ),
      // 是否展开
      isExpanded: model.isExpanded,
      // 点击 header 是否可以展开收起，false
      canTapOnHeader: true,
      // 背景色
      backgroundColor: Colors.cyan[100],
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    return Column(
      children: [
        // ExpansionTile(
        //   title: Text('标题$index'),
        //   // tilePadding: EdgeInsets.zero,
        //   // leading: Image.asset('images/ic_close_black.png'),
        //   // trailing: Image.asset('images/ic_close_black.png'),
        //   expandedCrossAxisAlignment: CrossAxisAlignment.start,
        //   expandedAlignment: Alignment.centerLeft,
        //   onExpansionChanged: (value){
        //     debugPrint('展开收起状态：$value');
        //     _models[index].isExpanded = value;
        //   },
        //   initiallyExpanded: _models[index].isExpanded,
        //   // maintainState: true,
        //   children: const [
        //     Text('展开收起文本1', textScaleFactor: 2),
        //     Text('展开收起文本2', textScaleFactor: 2)
        //   ],
        // )
        Text('标题$index'),
         ExpandableText(
          '长文本，很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长',
          expandText: '展开',
          collapseText: '收起',
          animation: true,
          onExpandedChanged: (value){
            _models[index].isExpanded = value;
          },
          maxLines: 1,
          expanded: _models[index].isExpanded,
          linkColor: Colors.blue,
        )
      ],
    );
  }
}

class MSExpansionPanelModel {
  var value;
  String title;
  bool isExpanded;

  MSExpansionPanelModel(this.value, this.title, this.isExpanded);
}
