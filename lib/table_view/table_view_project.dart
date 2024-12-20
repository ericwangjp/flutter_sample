// import 'dart:math';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter_sticky_header/flutter_sticky_header.dart';
// import 'package:material_table_view/default_animated_switcher_transition_builder.dart';
// import 'package:material_table_view/material_table_view.dart';
// import 'package:material_table_view/sliver_table_view.dart';
// import 'package:material_table_view/src/table_typedefs.dart';
// import 'package:material_table_view/table_column_control_handles_popup_route.dart';
// import 'package:flutter_sample/table_view/table_view_demo.dart';
//
// void main() => runApp(const CustomTableViewOne());
//
// class CustomTableViewOne extends StatelessWidget {
//   const CustomTableViewOne({Key? key}) : super(key: key);
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
//   final GlobalKey _globalKey = GlobalKey();
//   final selection = <int>{};
//   final tableTitleList = [
//     '伙伴',
//     '绩效系数',
//     '照片满意',
//     '服务满意',
//     '岗位满意',
//     '工时系数',
//     '业绩',
//     '评分'
//   ];
//   var columns = <_MyTableColumn>[];
//   bool _isPinned = false;
//
//   @override
//   void initState() {
//     super.initState();
//     columns = <_MyTableColumn>[
//       // _MyTableColumn(
//       //   index: 0,
//       //   width: 56.0,
//       //   freezePriority: 300,
//       //   sticky: false,
//       // ),
//       for (var i = 1; i <= tableTitleList.length; i++)
//         _MyTableColumn(
//           index: i,
//           title: tableTitleList[i - 1],
//           width: 100,
//           minResizeWidth: 50.0,
//           // flex: 1,
//           // this will make the column expand to fill remaining width
//           // freezePriority: i == 1 ? 500 : tableTitleList.length - i,
//           freezePriority: _getPriority(i, tableTitleList.length),
//         ),
//       // _MyTableColumn(
//       //   index: -1,
//       //   width: 48.0,
//       //   freezePriority: 300,
//       // ),
//     ];
//   }
//
//   int _getPriority(int index, int length) {
//     if (index == 1) {
//       return 500;
//     } else if (index == 2) {
//       return 490;
//     }
//     return 0;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text("flutter组件"),
//         ),
//         body: _tableWidget(),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             Navigator.push(context, MaterialPageRoute(builder: (context) {
//               return const TableViewDemo();
//             }));
//           },
//           child: const Icon(Icons.camera),
//         ));
//   }
//
//   Widget _tableWidget() {
//     return RefreshIndicator(
//       onRefresh: () => Future.delayed(const Duration(seconds: 2)),
//       child: CustomScrollView(
//         // controller: verticalSliverExampleScrollController,
//         slivers: [
//           SliverList(
//             delegate: SliverChildBuilderDelegate(
//               (BuildContext context, int index) {
//                 return ListTile(
//                   title: Text('Item #$index'),
//                 );
//               },
//               childCount: 20,
//             ),
//           ),
//           // const SliverAppBar(
//           //   pinned: true,
//           //   expandedHeight: 150.0,
//           //   flexibleSpace: FlexibleSpaceBar(
//           //     title: Text('Demo'),
//           //   ),
//           // ),
//           // SliverPersistentHeader(
//           //   pinned: true,
//           //   delegate: _SliverAppBarDelegate(
//           //     minHeight: 60.0,
//           //     maxHeight: 200.0,
//           //     child: Container(
//           //       color: Colors.green,
//           //       child: const Center(
//           //         child: Text(
//           //           'Header 2',
//           //           style: TextStyle(color: Colors.white, fontSize: 24),
//           //         ),
//           //       ),
//           //     ),
//           //   ),
//           // ),
//           SliverStickyHeader(
//             header: Container(
//               height: 60.0,
//               color: Colors.lightBlue,
//               padding: EdgeInsets.symmetric(horizontal: 16.0),
//               alignment: Alignment.centerLeft,
//               child: Text(
//                 '伙伴岗位选择',
//                 style: const TextStyle(color: Colors.white),
//               ),
//             ),
//             sliver: SliverList(
//               delegate: SliverChildBuilderDelegate(
//                 (context, i) => ListTile(
//                   leading: CircleAvatar(
//                     child: Text('0'),
//                   ),
//                   title: Text('List tile #$i'),
//                 ),
//                 childCount: 4,
//               ),
//             ),
//           ),
//
//           // SliverStickyHeader.builder(
//           //   builder: (context, state) {
//           //     _isPinned = state.isPinned;
//           //     debugPrint('是否吸顶：$_isPinned');
//           //     return Container(
//           //       height: 60.0,
//           //       color: (state.isPinned ? Colors.pink : Colors.lightBlue)
//           //           .withOpacity(1.0 - state.scrollPercentage),
//           //       padding: EdgeInsets.symmetric(horizontal: 16.0),
//           //       alignment: Alignment.centerLeft,
//           //       child: Text(
//           //         '伙伴岗位',
//           //         style: const TextStyle(color: Colors.white),
//           //       ),
//           //     );
//           //   },
//           //   sliver: _getTableView(),
//           //   // sliver: SliverList(
//           //   //   delegate: SliverChildBuilderDelegate(
//           //   //         (context, i) => ListTile(
//           //   //       leading: CircleAvatar(
//           //   //         child: Text('0'),
//           //   //       ),
//           //   //       title: Text('List tile #$i'),
//           //   //     ),
//           //   //     childCount: 4,
//           //   //   ),
//           //   // ),
//           // ),
//
//           _getTableView(),
//           // for (var i = 0; i < 2; i++) ...[
//           SliverFixedExtentList(
//             delegate: SliverChildBuilderDelegate(
//               childCount: 8,
//               (context, index) => Padding(
//                 padding: const EdgeInsets.only(left: 18.0),
//                 child: Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     'boring old sliver list element inbetween tables #${index + 10}',
//                   ),
//                 ),
//               ),
//             ),
//             itemExtent: 50,
//           ),
//           SliverGrid(
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               mainAxisSpacing: 10.0,
//               crossAxisSpacing: 10.0,
//               childAspectRatio: 4.0,
//             ),
//             delegate: SliverChildBuilderDelegate(
//               (BuildContext context, int index) {
//                 return Container(
//                   alignment: Alignment.center,
//                   color: Colors.teal[100 * (index % 9)],
//                   child: Text('Grid Item #$index'),
//                 );
//               },
//               childCount: 30,
//             ),
//           ),
//           // ],
//         ],
//       ),
//     );
//   }
//
//   Widget _getTableView() {
//     return SliverTableView.builder(
//         style: TableViewStyle(
//           // If we want the content to scroll out from underneath
//           // the vertical scrollbar
//           // we need to specify scroll padding here since we are
//           // managing that scrollbar.
//           // scrollPadding: const EdgeInsets.only(right: 10, left: 10),
//           dividers: const TableViewDividersStyle(
//             vertical: TableViewVerticalDividersStyle.symmetric(
//               TableViewVerticalDividerStyle(wigglesPerRow: 0, wiggleOffset: 0),
//             ),
//           ),
//           scrollbars: TableViewScrollbarsStyle.symmetric(
//             TableViewScrollbarStyle(
//               interactive: true,
//               enabled: TableViewScrollbarEnabled.auto,
//               thumbVisibility: MaterialStateProperty.all(false),
//               trackVisibility: MaterialStateProperty.all(false),
//             ),
//           ),
//           // minScrollableWidthRatio: 0.5
//         ),
//         columns: columns,
//         rowHeight: 50,
//         rowCount: 10,
//         rowBuilder: _rowBuilder,
//         rowReorder: TableRowReorder(
//           onReorder: (oldIndex, newIndex) {
//             // for the purposes of the demo we do not handle actual
//             // row reordering
//             debugPrint('$oldIndex -> $newIndex');
//           },
//         ),
//         // placeholderRowBuilder: _placeholderBuilder,
//         // placeholderShade: placeholderShade,
//         headerBuilder: _headerBuilder,
//         // footerBuilder: _footerBuilder,
//         // minScrollableWidthRatio: 0.5,
//         minScrollableWidth: 10);
//   }
//
//   Widget? _rowBuilder(
//     BuildContext context,
//     int row,
//     TableRowContentBuilder contentBuilder,
//   ) {
//     final selected = selection.contains(row);
//
//     var textStyle = Theme.of(context).textTheme.bodyMedium;
//     if (selected) {
//       textStyle = textStyle?.copyWith(
//           color: Theme.of(context).colorScheme.onPrimaryContainer);
//     }
//     var placeholderOffsetIndex = 0;
//     // return (row + placeholderOffsetIndex) % 99 < 33
//     //     ? null
//     return _wrapRow(
//       row,
//       AnimatedContainer(
//         duration: const Duration(milliseconds: 200),
//         color: Theme.of(context)
//             .colorScheme
//             .primaryContainer
//             .withAlpha(selected ? 0xFF : 0),
//         child: Material(
//           type: MaterialType.transparency,
//           child: InkWell(
//             onTap: () => setState(() {
//               selection.clear();
//               selection.add(row);
//             }),
//             child: contentBuilder(context, (context, column) {
//               switch (columns[column].index) {
//                 case 0:
//                   return Checkbox(
//                       value: selection.contains(row),
//                       onChanged: (value) => setState(() => (value ?? false)
//                           ? selection.add(row)
//                           : selection.remove(row)));
//                 case -1:
//                   return ReorderableDragStartListener(
//                     // key: ValueKey(row),
//                     index: row,
//                     child: const SizedBox(
//                       width: double.infinity,
//                       height: double.infinity,
//                       child: Icon(Icons.drag_indicator),
//                     ),
//                   );
//                 default:
//                   return Container(
//                     decoration: BoxDecoration(
//                       border: Border(
//                         left: Divider.createBorderSide(context),
//                       ),
//                     ),
//                     padding: const EdgeInsets.only(left: 8.0),
//                     child: Align(
//                       alignment: Alignment.centerLeft,
//                       child: Text(
//                         // '${(row + 2) * columns[column].index}',
//                         '$row - $column',
//                         style: textStyle,
//                         overflow: TextOverflow.fade,
//                         maxLines: 1,
//                         softWrap: false,
//                       ),
//                     ),
//                   );
//               }
//             }),
//           ),
//         ),
//       ),
//     );
//   }
//
//   /// This is used to wrap both regular and placeholder rows to achieve fade
//   /// transition between them and to insert optional row divider.
//   Widget _wrapRow(int index, Widget child) => KeyedSubtree(
//         key: ValueKey(index),
//         child: DecoratedBox(
//           position: DecorationPosition.foreground,
//           decoration: BoxDecoration(
//             // border: stylingController.lineDividerEnabled.value
//             border: Border(bottom: Divider.createBorderSide(context)),
//           ),
//           child: AnimatedSwitcher(
//             duration: const Duration(milliseconds: 200),
//             transitionBuilder: tableRowDefaultAnimatedSwitcherTransitionBuilder,
//             child: child,
//           ),
//         ),
//       );
//
//   Widget _headerBuilder(
//     BuildContext context,
//     TableRowContentBuilder contentBuilder,
//   ) =>
//       contentBuilder(
//         context,
//         (context, column) {
//           switch (columns[column].index) {
//             case 0:
//               return Checkbox(
//                 value: selection.isEmpty ? false : null,
//                 tristate: true,
//                 onChanged: (value) {
//                   if (!(value ?? true)) {
//                     setState(() => selection.clear());
//                   }
//                 },
//               );
//             case -1:
//               return const SizedBox();
//             default:
//               return Material(
//                 type: MaterialType.transparency,
//                 child: InkWell(
//                   onTap: () => Navigator.of(context)
//                       .push(_createColumnControlsRoute(context, column)),
//                   child: Container(
//                     padding: const EdgeInsets.only(left: 8.0),
//                     decoration: BoxDecoration(
//                       border: Border(
//                         top: Divider.createBorderSide(context, width: 0.5),
//                         left: Divider.createBorderSide(context),
//                       ),
//                     ),
//                     child: Row(
//                       children: [
//                         Text(columns[column].title),
//                         const Icon(Icons.arrow_drop_down),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//           }
//         },
//       );
//
//   Widget _footerBuilder(
//     BuildContext context,
//     TableRowContentBuilder contentBuilder,
//   ) =>
//       contentBuilder(
//         context,
//         (context, column) {
//           final index = columns[column].index;
//           if (index == -1) {
//             return const SizedBox();
//           }
//
//           return Padding(
//             padding: const EdgeInsets.only(left: 8.0),
//             child: Align(
//               alignment: Alignment.centerLeft,
//               child: Text(index == 0 ? '${selection.length}' : '$index'),
//             ),
//           );
//         },
//       );
//
//   ModalRoute<void> _createColumnControlsRoute(
//     BuildContext cellBuildContext,
//     int columnIndex,
//   ) =>
//       TableColumnControlHandlesPopupRoute.realtime(
//         controlCellBuildContext: cellBuildContext,
//         columnIndex: columnIndex,
//         tableViewChanged: null,
//         onColumnTranslate: (index, newTranslation) => setState(
//           () => columns[index] =
//               columns[index].copyWith(translation: newTranslation),
//         ),
//         onColumnResize: (index, newWidth) => setState(
//           () => columns[index] = columns[index].copyWith(width: newWidth),
//         ),
//         onColumnMove: (oldIndex, newIndex) => setState(
//           () => columns.insert(newIndex, columns.removeAt(oldIndex)),
//         ),
//         leadingImmovableColumnCount: 1,
//         trailingImmovableColumnCount: 1,
//         popupBuilder: (context, animation, secondaryAnimation, columnWidth) =>
//             PreferredSize(
//           preferredSize: Size(min(256, max(192, columnWidth)), 256),
//           child: FadeTransition(
//             opacity: animation,
//             child: Material(
//               type: MaterialType.card,
//               clipBehavior: Clip.antiAlias,
//               shape: RoundedRectangleBorder(
//                 side: Divider.createBorderSide(context),
//                 borderRadius: const BorderRadius.all(
//                   Radius.circular(16.0),
//                 ),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   const Expanded(
//                     child: Padding(
//                       padding: EdgeInsets.all(16.0),
//                       child: Text(
//                         'Custom widget to control sorting, stickiness and whatever',
//                       ),
//                     ),
//                   ),
//                   InkWell(
//                     onTap: () => Navigator.of(context).pop(),
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Text(
//                         'Button to cancel the controls',
//                         textAlign: TextAlign.center,
//                         style: Theme.of(context).textTheme.labelLarge?.copyWith(
//                               color: Theme.of(context).colorScheme.primary,
//                             ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       );
// }
//
// /// Extends [TableColumn] to keep track of its original index regardless of where it happened to move to.
// class _MyTableColumn extends TableColumn {
//   _MyTableColumn({
//     required int index,
//     required this.title,
//     required super.width,
//     super.freezePriority = 0,
//     super.sticky = false,
//     super.flex = 0,
//     super.translation = 0,
//     super.minResizeWidth,
//     super.maxResizeWidth,
//   })  : key = ValueKey<int>(index),
//         // ignore: prefer_initializing_formals
//         index = index;
//
//   final int index;
//   final String title;
//
//   @override
//   final ValueKey<int> key;
//
//   @override
//   _MyTableColumn copyWith({
//     double? width,
//     int? freezePriority,
//     bool? sticky,
//     int? flex,
//     double? translation,
//     double? minResizeWidth,
//     double? maxResizeWidth,
//   }) =>
//       _MyTableColumn(
//         index: index,
//         title: title,
//         width: width ?? this.width,
//         freezePriority: freezePriority ?? this.freezePriority,
//         sticky: sticky ?? this.sticky,
//         flex: flex ?? this.flex,
//         translation: translation ?? this.translation,
//         minResizeWidth: minResizeWidth ?? this.minResizeWidth,
//         maxResizeWidth: maxResizeWidth ?? this.maxResizeWidth,
//       );
// }
//
// class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
//   _SliverAppBarDelegate({
//     required this.minHeight,
//     required this.maxHeight,
//     required this.child,
//   });
//
//   final double minHeight;
//   final double maxHeight;
//   final Widget child;
//
//   @override
//   double get minExtent => minHeight;
//
//   @override
//   double get maxExtent => maxHeight;
//
//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return SizedBox.expand(child: child);
//   }
//
//   @override
//   bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
//     return maxHeight != oldDelegate.maxHeight ||
//         minHeight != oldDelegate.minHeight ||
//         child != oldDelegate.child;
//   }
// }
