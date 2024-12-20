import 'package:flutter/material.dart';

class CommonBottomDialog {
  final ScrollController _scrollController = ScrollController();

  Future<String?> show({required BuildContext context}) {
    return showModalBottomSheet<String?>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        // constraints: BoxConstraints(
        //     maxHeight: (MediaQuery.of(context).size.height * 2) / 3,
        //     minWidth: MediaQuery.of(context).size.width),
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return _dialogBuilder(context, setState);
            },
          );
        },
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15))));
  }

  Widget _dialogBuilder(BuildContext context, StateSetter setState) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          ConstrainedBox(
              constraints: BoxConstraints(
                  maxHeight: (MediaQuery.of(context).size.height * 2) / 3,
                  minWidth: MediaQuery.of(context).size.width),
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                controller: _scrollController,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        '测试文本1',
                        style:
                            TextStyle(backgroundColor: Colors.green.shade200),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        '测试文本2',
                        style:
                            TextStyle(backgroundColor: Colors.green.shade200),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        '测试文本3',
                        style:
                            TextStyle(backgroundColor: Colors.green.shade200),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        '测试文本4',
                        style:
                            TextStyle(backgroundColor: Colors.green.shade200),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        '测试文本5',
                        style:
                            TextStyle(backgroundColor: Colors.green.shade200),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        '测试文本6',
                        style:
                            TextStyle(backgroundColor: Colors.green.shade200),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        '测试文本7',
                        style:
                            TextStyle(backgroundColor: Colors.green.shade200),
                      ),
                    ),
                    TextField(
                      onTap: () {
                        debugPrint(
                            '你点击我了,键盘高度：${MediaQuery.of(context).viewInsets.bottom}');
                        Future.delayed(const Duration(milliseconds: 300))
                            .then((value) {
                          debugPrint(
                              '你点击我了,键盘高度2：${MediaQuery.of(context).viewInsets.bottom}');
                          _scrollController.animateTo(
                              _scrollController.position.maxScrollExtent,
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.easeIn);
                          // .jumpTo(_scrollController.position.maxScrollExtent);
                        });
                      },
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(20),
                          hintText: '请输入文本'),
                      onChanged: (value){
                        debugPrint('变化了：$value');
                      },
                    ),
                    // SizedBox(
                    //   height: MediaQuery.of(context).viewInsets.bottom,
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        '测试文本8',
                        style:
                            TextStyle(backgroundColor: Colors.green.shade200),
                      ),
                    ),
                  ],
                ),
              )),
        ]));
  }
}
