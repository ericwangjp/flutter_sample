import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return ListTile(title: Text('这是第 $index 个'),);
        },
        separatorBuilder: (context, index) {
          return const Divider(
            height: 10,
            color: Colors.orange,
          );
        },
        itemCount: 20);
  }
}
