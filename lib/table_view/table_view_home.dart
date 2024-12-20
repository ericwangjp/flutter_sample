// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter_sample/commontest/excel_like_table.dart';
// import 'package:flutter_sample/table_view/data_table_2_main.dart';
// import 'package:flutter_sample/table_view/table_view_demo.dart';
//
// import 'data_table_view_main.dart';
// import 'flutter_table_view.dart';
// import 'table_view_project.dart';
//
// void main() => runApp(const MyApp());
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: "flutter",
//       theme: ThemeData(primarySwatch: Colors.blue),
//       // localizationsDelegates: const [
//       //   GlobalMaterialLocalizations.delegate,
//       //   GlobalWidgetsLocalizations.delegate,
//       //   GlobalCupertinoLocalizations.delegate
//       // ],
//       // supportedLocales: const [
//       //   Locale('zh', 'CN'),
//       //   Locale('en', 'US'),
//       // ],
//       home: const HomePage(),
//       routes: {
//         // '/': (context) => HomePage(),
//         '/excel': (context) => const ExcelLikeTable(),
//       },
//     );
//   }
// }
//
// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text("flutter组件"),
//         ),
//         body: Column(
//           children: [
//             ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const ExcelLikeTable()));
//                 },
//                 child: const Text("自定义表格")),
//             ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const TableViewDemo()));
//                 },
//                 child: const Text("官方效果一")),
//             ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const CustomTableViewOne()));
//                 },
//                 child: const Text("修改官方效果一")),
//             ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => DataTable2()));
//                 },
//                 child: const Text("官方效果二")),
//             ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const DataTableMainView()));
//                 },
//                 child: const Text("官方效果二修改")),
//             ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const FlutterDataTableView()));
//                 },
//                 child: const Text("Flutter原生效果")),
//           ],
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             Navigator.pushNamed(context, '/excel');
//           },
//           child: const Icon(Icons.camera),
//         ));
//   }
// }
