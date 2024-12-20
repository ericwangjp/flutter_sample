import 'package:flutter/material.dart';

/// 完成化妆弹框
class FinishMakeUpDialog {
  late BuildContext _parentContext;

  Future<String?> show({required BuildContext context}) async {
    _parentContext = context;
    return _show(context: context).then((value) => Future.value(value));
  }

  Future<String?> _show({required BuildContext context}) {
    return showModalBottomSheet<String?>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.white,
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 16),
            child: Row(
              children: [
                const Text(
                  '完成化妆',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
                Expanded(child: Container()),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop("close");
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Image.asset(
                    'images/ic_close_black.png',
                    width: 28,
                    height: 28,
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 1,
            color: Colors.grey.shade200,
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
                maxHeight: (MediaQuery.of(context).size.height * 2) / 3,
                minWidth: MediaQuery.of(context).size.width),
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 30),
              // controller: _scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 确认化妆产品
                  Visibility(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Text(
                            '确认完成的化妆产品',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        ListView.separated(
                            padding: const EdgeInsets.only(bottom: 32),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return _listItemBuilder(context, index, setState);
                            },
                            separatorBuilder: (context, index) {
                              return const Divider(
                                color: Colors.white,
                                height: 8,
                              );
                            },
                            itemCount: 3),
                      ],
                    ),
                  ),
                  // 确认服务的人员
                  Visibility(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Text(
                              '确认本产品你服务的成员',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                            Expanded(child: Container()),
                            const Text(
                              '已选5人',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                        GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    childAspectRatio: 2.5,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 8),
                            padding: const EdgeInsets.only(top: 20, bottom: 12),
                            itemCount: 5,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return _gridItemBuilder(context, index, setState);
                            }),
                      ],
                    ),
                  ),
                  // 化妆备注
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      '本产品化妆备注',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  AnimatedPadding(
                    duration: const Duration(milliseconds: 100),
                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Container(
                      constraints: const BoxConstraints(minHeight: 140),
                      decoration: ShapeDecoration(
                          color: Colors.grey.shade400,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)))),
                      child: TextField(
                        keyboardType: TextInputType.text,
                        maxLines: null,
                        maxLength: 300,
                        style: const TextStyle(color: Colors.black, fontSize: 14),
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(15),
                            hintText: '本产品化妆备注',
                            counterText: '',
                            border: InputBorder.none,
                            hintStyle:
                                TextStyle(color: Colors.black, fontSize: 14)),
                        onChanged: (value) {
                          // _note = value;
                        },
                      ),
                    ),
                  ),
                  const Visibility(
                    child: Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Text(
                          '此产品需要引逗，摄影完成后可接单',
                          style: TextStyle(fontSize: 14, color: Colors.orange),
                        )),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  onPressed: () {
                    // 完成并挂起
                  },
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 10)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                      backgroundColor: MaterialStateProperty.all(Colors.white)),
                  child: const Text(
                    "完成并挂起",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('完成并接单'),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _listItemBuilder(
      BuildContext context, int index, StateSetter setState) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          color: Colors.grey.shade200),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () async {
          // 选择产品
        },
        child: Row(
          children: [
            const Text(
              '10人',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            ),
            Expanded(child: Container()),
            Image.asset(
              index == 0
                  ? 'images/cat.jpg'
                  : 'images/little_girl.jpeg',
              width: 16,
              height: 16,
            )
          ],
        ),
      ),
    );
  }

  Widget _gridItemBuilder(
      BuildContext context, int index, StateSetter setState) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        // 选择服务对象
      },
      child: Container(
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.green),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              '李磊',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
