import 'package:flutter/material.dart';
import 'package:flutter_slidable_for_tencent_im/flutter_slidable.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "侧滑删除组件",
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("列表侧滑删除"),
      ),
      body: ListView.separated(
        itemCount: 15,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Slidable(
              // Specify a key if the Slidable is dismissible.
              key: const ValueKey(0),
              groupTag: 'aaa',

              // The start action pane is the one at the left or the top side.
              // startActionPane: ActionPane(
              //   motion: const ScrollMotion(),
              //   children: [
              //     SlidableAction(
              //       // An action can be bigger than the others.
              //       // flex: 2,
              //       onPressed: (context) {
              //         debugPrint('点击了存档');
              //       },
              //       backgroundColor: const Color(0xFF7BC043),
              //       foregroundColor: Colors.white,
              //       icon: Icons.archive,
              //       label: 'Archive',
              //     ),
              //     SizedBox(width: 20,),
              //     SlidableAction(
              //       onPressed: (context) {
              //         debugPrint('点击了保存');
              //       },
              //       backgroundColor: const Color(0xFF0392CF),
              //       foregroundColor: Colors.white,
              //       icon: Icons.save,
              //       label: 'Save',
              //     ),
              //   ],
              // ),

              // The end action pane is the one at the right or the bottom side.
              endActionPane: ActionPane(
                // A motion is a widget used to control how the pane animates.
                motion: const ScrollMotion(),
                extentRatio: 0.2,

                // A pane can dismiss the Slidable.
                dismissible: DismissiblePane(onDismissed: () {
                  debugPrint('消失了');
                }),
                dragDismissible: false,

                // All actions are defined in the children parameter.
                children: [
                  SizedBox(
                    width: 14,
                  ),
                  // A SlidableAction can have an icon and/or a label.
                  SlidableAction(
                    onPressed: (context) {
                      debugPrint('点击了删除');
                      Slidable.of(context)?.close();
                    },
                    padding: EdgeInsets.zero,
                    backgroundColor: const Color(0xFFFE4A49),
                    foregroundColor: Colors.white,
                    // icon: Icons.delete,
                    borderRadius: BorderRadius.circular(15),
                    label: '删除',
                  ),
                  // SlidableAction(
                  //   onPressed: (context) {
                  //     debugPrint('点击了分享');
                  //   },
                  //   padding: EdgeInsets.zero,
                  //   backgroundColor: const Color(0xFF21B7CA),
                  //   foregroundColor: Colors.white,
                  //   icon: Icons.share,
                  //   label: 'Share',
                  // ),
                ],
              ),

              // The child of the Slidable is what the user sees when the
              // component is not dragged.
              // child: ListTile(
              //   title: Text('Slide me $index'),
              //   style: ListTileStyle.list,
              // ),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey[200]),
                width: MediaQuery.of(context).size.width,
                child: Text('Slide me $index'),
                padding: EdgeInsets.all(15),
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: 10,
          );
        },
      ),
    );
  }
}
