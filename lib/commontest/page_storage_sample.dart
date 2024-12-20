import 'package:flutter/material.dart';

import '../model/item_select.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final PageStorageKey _pageStorageKey = const PageStorageKey('myListView');
  final PageStorageBucket _bucket = PageStorageBucket();
  final List<ItemSelect> _checkedList =
      List.generate(100, (index) => ItemSelect('$index', false));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PageStorage Example'),
      ),
      body: PageStorage(
        bucket: _bucket,
        child: ListView.builder(
          key: _pageStorageKey,
          itemCount: _checkedList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return Scaffold(
                      appBar: AppBar(
                        title: Text('Item ${_checkedList[index].title}'),
                      ),
                      body: Center(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Go back!'),
                        ),
                      ),
                    );
                  },
                ));
              },
              child: Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: Text('Item ${_checkedList[index].title}'),
                    ),
                  ),
                  Checkbox(
                      value: _checkedList[index].selected,
                      onChanged: (value) {
                        setState(() {
                          _checkedList[index].selected = value!;
                        });
                      })
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
