import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:flutter_sample/commontest/excel_like_table.dart';

import 'user.dart';

void main() => runApp(MaterialApp(home: SimpleTablePage(user: User())));

class SimpleTablePage extends StatefulWidget {
  const SimpleTablePage({
    Key? key,
    required this.user,
  }) : super(key: key);
  final User user;

  @override
  State<SimpleTablePage> createState() => _SimpleTablePageState();
}

class _SimpleTablePageState extends State<SimpleTablePage> {
  @override
  void initState() {
    widget.user.initData(30);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Simple Table')),
      body: NestedScrollView(
        body: ListView.builder(
          padding: EdgeInsets.all(8.0),
          itemCount: 50,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text('Item $index'),
            );
          },
        ),
        // body: HorizontalDataTable(
        //   leftHandSideColumnWidth: 100,
        //   rightHandSideColumnWidth: 600,
        //   isFixedHeader: true,
        //   headerWidgets: _getTitleWidget(),
        //   isFixedFooter: true,
        //   footerWidgets: _getTitleWidget(),
        //   leftSideItemBuilder: _generateFirstColumnRow,
        //   rightSideItemBuilder: _generateRightHandSideColumnRow,
        //   itemCount: widget.user.userInfo.length,
        //   rowSeparatorWidget: const Divider(
        //     color: Colors.black38,
        //     height: 1.0,
        //     thickness: 0.0,
        //   ),
        //   leftHandSideColBackgroundColor: const Color(0xFFFFFFFF),
        //   rightHandSideColBackgroundColor: const Color(0xFFFFFFFF),
        //   // itemExtent: 55,
        // ),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            // SliverOverlapAbsorber(
            //   handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            //   sliver: SliverAppBar(
            //     // expandedHeight: 200.0,
            //     title: const Text('Simple Table'),
            //     floating: true,
            //     snap: true,
            //     pinned: true,
            //     forceElevated: innerBoxIsScrolled,
            //   ),
            // ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return ListTile(
                    title: Text('Item #$index'),
                  );
                },
                childCount: 30,
              ),
            ),
            SliverLayoutBuilder(builder: (context, constraints) {
              return SliverAppBar(
                expandedHeight: constraints.precedingScrollExtent,
                floating: false,
                // snap: true,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  // title: Text('Simple Table'),
                  // title: ExcelLikeTable(),
                  background: ExcelLikeTable(),
                ),
                // flexibleSpace: FlexibleSpaceBar(
                //   title: Text('SliverAppBar'),
                //   background: Image.network(
                //     'https://via.placeholder.com/350x150',
                //     fit: BoxFit.cover,
                //   ),
                // ),
              );
            }),
          ];
        },
      ),
    );
  }

  List<Widget> _getTitleWidget() {
    return [
      _getTitleItemWidget('Name', 100),
      _getTitleItemWidget('Status', 100),
      _getTitleItemWidget('Phone', 200),
      _getTitleItemWidget('Register', 100),
      _getTitleItemWidget('Termination', 200),
    ];
  }

  Widget _getTitleItemWidget(String label, double width) {
    return Container(
      width: width,
      height: 56,
      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  Widget _generateFirstColumnRow(BuildContext context, int index) {
    return Container(
      width: 100,
      height: 52,
      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
      child: Text(widget.user.userInfo[index].name),
    );
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    return Row(
      children: <Widget>[
        Container(
          width: 100,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
          child: Row(
            children: <Widget>[
              Icon(
                  widget.user.userInfo[index].status
                      ? Icons.notifications_off
                      : Icons.notifications_active,
                  color: widget.user.userInfo[index].status
                      ? Colors.red
                      : Colors.green),
              Text(widget.user.userInfo[index].status ? 'Disabled' : 'Active')
            ],
          ),
        ),
        Container(
          width: 200,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
          child: Text(widget.user.userInfo[index].phone),
        ),
        Container(
          width: 100,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
          child: Text(widget.user.userInfo[index].registerDate),
        ),
        Container(
          width: 200,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
          child: Text(widget.user.userInfo[index].terminationDate),
        ),
      ],
    );
  }
}
