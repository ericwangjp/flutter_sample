// import 'package:data_table_2/data_table_2.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter_sticky_header/flutter_sticky_header.dart';
// import 'package:intl/intl.dart';
// import 'package:flutter_sample/commontest/excel_like_table.dart';
//
// import 'data_sources.dart';
// import 'nav_helper.dart';
//
// class DataTableMainView extends StatelessWidget {
//   const DataTableMainView({Key? key}) : super(key: key);
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
//   final List<Dessert> _desserts = <Dessert>[
//     Dessert(
//       'Frozen Yogurt',
//       159,
//       6.0,
//       24,
//       4.0,
//       87,
//       14,
//       1,
//     ),
//     Dessert(
//       'Ice Cream Sandwich',
//       237,
//       9.0,
//       37,
//       4.3,
//       129,
//       8,
//       1,
//     ),
//     Dessert(
//       'Eclair',
//       262,
//       16.0,
//       24,
//       6.0,
//       337,
//       6,
//       7,
//     ),
//     Dessert(
//       'Cupcake',
//       305,
//       3.7,
//       67,
//       4.3,
//       413,
//       3,
//       8,
//     ),
//     Dessert(
//       'Gingerbread',
//       356,
//       16.0,
//       49,
//       3.9,
//       327,
//       7,
//       16,
//     ),
//     Dessert(
//       'Jelly Bean',
//       375,
//       0.0,
//       94,
//       0.0,
//       50,
//       0,
//       0,
//     ),
//     Dessert(
//       'Lollipop',
//       392,
//       0.2,
//       98,
//       0.0,
//       38,
//       0,
//       2,
//     ),
//     Dessert(
//       'Honeycomb',
//       408,
//       3.2,
//       87,
//       6.5,
//       562,
//       0,
//       45,
//     ),
//     Dessert(
//       'Donut',
//       452,
//       25.0,
//       51,
//       4.9,
//       326,
//       2,
//       22,
//     ),
//     Dessert(
//       'Apple Pie',
//       518,
//       26.0,
//       65,
//       7.0,
//       54,
//       12,
//       6,
//     ),
//     Dessert(
//       'Frozen Yougurt with sugar',
//       168,
//       6.0,
//       26,
//       4.0,
//       87,
//       14,
//       1,
//     ),
//     Dessert(
//       'Ice Cream Sandwich with sugar',
//       246,
//       9.0,
//       39,
//       4.3,
//       129,
//       8,
//       1,
//     ),
//     Dessert(
//       'Eclair with sugar',
//       271,
//       16.0,
//       26,
//       6.0,
//       337,
//       6,
//       7,
//     ),
//     Dessert(
//       'Cupcake with sugar',
//       314,
//       3.7,
//       69,
//       4.3,
//       413,
//       3,
//       8,
//     ),
//     Dessert(
//       'Gingerbread with sugar',
//       345,
//       16.0,
//       51,
//       3.9,
//       327,
//       7,
//       16,
//     ),
//     Dessert(
//       'Jelly Bean with sugar',
//       364,
//       0.0,
//       96,
//       0.0,
//       50,
//       0,
//       0,
//     ),
//     Dessert(
//       'Lollipop with sugar',
//       401,
//       0.2,
//       100,
//       0.0,
//       38,
//       0,
//       2,
//     ),
//     Dessert(
//       'Honeycomd with sugar',
//       417,
//       3.2,
//       89,
//       6.5,
//       562,
//       0,
//       45,
//     ),
//     Dessert(
//       'Donut with sugar',
//       461,
//       25.0,
//       53,
//       4.9,
//       326,
//       2,
//       22,
//     ),
//     Dessert(
//       'Apple pie with sugar',
//       527,
//       26.0,
//       67,
//       7.0,
//       54,
//       12,
//       6,
//     ),
//     Dessert(
//       'Forzen yougurt with honey',
//       223,
//       6.0,
//       36,
//       4.0,
//       87,
//       14,
//       1,
//     ),
//     Dessert(
//       'Ice Cream Sandwich with honey',
//       301,
//       9.0,
//       49,
//       4.3,
//       129,
//       8,
//       1,
//     ),
//     Dessert(
//       'Eclair with honey',
//       326,
//       16.0,
//       36,
//       6.0,
//       337,
//       6,
//       7,
//     ),
//     Dessert(
//       'Cupcake with honey',
//       369,
//       3.7,
//       79,
//       4.3,
//       413,
//       3,
//       8,
//     ),
//     Dessert(
//       'Gignerbread with hone',
//       420,
//       16.0,
//       61,
//       3.9,
//       327,
//       7,
//       16,
//     ),
//     Dessert(
//       'Jelly Bean with honey',
//       439,
//       0.0,
//       106,
//       0.0,
//       50,
//       0,
//       0,
//     ),
//     Dessert(
//       'Lollipop with honey',
//       456,
//       0.2,
//       110,
//       0.0,
//       38,
//       0,
//       2,
//     ),
//     Dessert(
//       'Honeycomd with honey',
//       472,
//       3.2,
//       99,
//       6.5,
//       562,
//       0,
//       45,
//     ),
//     Dessert(
//       'Donut with honey',
//       516,
//       25.0,
//       63,
//       4.9,
//       326,
//       2,
//       22,
//     ),
//     Dessert(
//       'Apple pie with honey',
//       582,
//       26.0,
//       77,
//       7.0,
//       54,
//       12,
//       6,
//     ),
//   ];
//   bool _sortAscending = true;
//   int? _sortColumnIndex;
//   late DessertDataSource _dessertsDataSource;
//   late DessertDataSourceAsync _asyncDessertsDataSource;
//   bool _initialized = false;
//   final ScrollController _outerController = ScrollController();
//   final ScrollController _innerController = ScrollController();
//   String selectedTableType = 'Default';
//   double _previousScrollOffset = 0;
//
//   int _fixedRows = 1;
//   int _fixedCols = 1;
//   int _dataItems = 30;
//
//   @override
//   void initState() {
//     super.initState();
//     _innerController.addListener(() {
//       double currentScrollOffset = _innerController.position.pixels;
//       if (_innerController.position.atEdge) {
//         if (_innerController.position.pixels == 0) {
//           // At the top
//           debugPrint('Scrolled to the top');
//         } else {
//           // At the bottom
//           debugPrint('Scrolled to the bottom');
//         }
//       } else {
//         if (currentScrollOffset > _previousScrollOffset) {
//           // Scrolling down
//           debugPrint('Scrolling down');
//         } else if (currentScrollOffset < _previousScrollOffset) {
//           // Scrolling up
//           debugPrint('Scrolling up');
//         }
//       }
//       _previousScrollOffset = currentScrollOffset;
//     });
//   }
//
//   @override
//   void dispose() {
//     _dessertsDataSource.dispose();
//     _outerController.dispose();
//     _innerController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text("flutter组件"),
//         ),
//         body: _buildBody(context),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             Navigator.pushNamed(context, '/excel');
//           },
//           child: const Icon(Icons.camera),
//         ));
//   }
//
//   Widget _buildBody(BuildContext context) {
//     return CustomScrollView(
//       controller: _outerController,
//       slivers: [
//         SliverList(
//           delegate: SliverChildBuilderDelegate(
//             (BuildContext context, int index) {
//               return ListTile(
//                 title: Text('Item #$index'),
//               );
//             },
//             childCount: 1,
//           ),
//         ),
//         // SliverPersistentHeader(
//         //   pinned: true,
//         //   floating: true,
//         //   delegate: _SliverAppBarDelegate(
//         //     minHeight: 60.0,
//         //     maxHeight: 200.0,
//         //     child: Container(
//         //       color: Colors.blue,
//         //       child: const Center(
//         //         child: Text(
//         //           'Sticky Header',
//         //           style: TextStyle(color: Colors.white, fontSize: 20),
//         //         ),
//         //       ),
//         //     ),
//         //   ),
//         // ),
//         SliverList(
//           delegate: SliverChildBuilderDelegate(
//                 (BuildContext context, int index) {
//               return ListTile(
//                 title: Text('Item #$index'),
//               );
//             },
//             childCount: 1,
//           ),
//         ),
//         SliverToBoxAdapter(child: _buildTableView(context)),
//         // SliverStickyHeader(
//         //   header: Container(
//         //     height: 60.0,
//         //     color: Colors.lightBlue,
//         //     padding: EdgeInsets.symmetric(horizontal: 16.0),
//         //     alignment: Alignment.centerLeft,
//         //     child: Text(
//         //       'Header #0',
//         //       style: const TextStyle(color: Colors.white),
//         //     ),
//         //   ),
//         //   sliver: SliverToBoxAdapter(child: _buildTableView(context)),
//         // ),
//         // SliverStickyHeader(
//         //   header: _buildTableView(context),
//         //   sliver: SliverList(
//         //     delegate: SliverChildBuilderDelegate(
//         //       (context, i) => ListTile(
//         //         leading: CircleAvatar(
//         //           child: Text('0'),
//         //         ),
//         //         title: Text('List tile #$i'),
//         //       ),
//         //       childCount: 4,
//         //     ),
//         //   ),
//         // ),
//
//         // SliverList(
//         //   delegate: SliverChildBuilderDelegate(
//         //         (BuildContext context, int index) {
//         //       return _buildTableView(context);
//         //     },
//         //     childCount: 1,
//         //   ),
//         // ),
//         SliverFixedExtentList(
//           delegate: SliverChildBuilderDelegate(
//             childCount: 8,
//             (context, index) => Padding(
//               padding: const EdgeInsets.only(left: 18.0),
//               child: Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   'tables #$index',
//                 ),
//               ),
//             ),
//           ),
//           itemExtent: 100,
//         ),
//         SliverGrid(
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             mainAxisSpacing: 10.0,
//             crossAxisSpacing: 10.0,
//             childAspectRatio: 4.0,
//           ),
//           delegate: SliverChildBuilderDelegate(
//             (BuildContext context, int index) {
//               return Container(
//                 alignment: Alignment.center,
//                 color: Colors.teal[100 * (index % 9)],
//                 child: Text('Grid Item #$index'),
//               );
//             },
//             childCount: 30,
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildTableView(BuildContext context) {
//     // return AspectRatio(aspectRatio: 0.8, child: getDataTable());
//     return SizedBox(height: 1000, child: getDataTable());
//     // return Container(
//     //     constraints: const BoxConstraints(maxWidth: 1000, maxHeight: 600),
//     //     padding: const EdgeInsets.all(16),
//     //     child: Flexible(
//     //         fit: FlexFit.tight,
//     //         child: Theme(
//     //             data: ThemeData(dividerColor: Colors.grey[400]),
//     //             child: getTableFromSelectedType())));
//   }
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     if (!_initialized) {
//       _dessertsDataSource = DessertDataSource(context);
//       _asyncDessertsDataSource = DessertDataSourceAsync();
//       _initialized = true;
//       _dessertsDataSource.addListener(() {
//         setState(() {});
//       });
//     }
//   }
//
//   Widget getTableFromSelectedType() {
//     switch (getCurrentRouteOption(context)) {
//       case paginatedFixedRowsCols:
//         {
//           return getPaginatedDataTable();
//         }
//       case asyncPaginatedFixedRowsCols:
//         {
//           return getAsyncPaginatedDataTable();
//         }
//       default:
//         {
//           return getDataTable();
//         }
//     }
//   }
//
//   DataTable2 getDataTable() {
//     return DataTable2(
//         showCheckboxColumn: false,
//         dividerThickness: 0,
//         scrollController: _innerController,
//         columnSpacing: 10,
//         horizontalMargin: 12,
//         bottomMargin: 20,
//         border: TableBorder.all(width: 1.0, color: Colors.grey),
//         headingRowColor: MaterialStateProperty.resolveWith(
//             (states) => _fixedRows > 0 ? Colors.grey[200] : Colors.transparent),
//         headingRowDecoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Colors.grey[400]!,
//               Colors.grey[200]!,
//             ],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         fixedColumnsColor: Colors.grey[300],
//         fixedCornerColor: Colors.grey[400],
//         // minWidth: MediaQuery.of(context).size.width,
//         minWidth: 1000,
//         fixedTopRows: _fixedRows,
//         fixedLeftColumns: _fixedCols,
//         sortColumnIndex: _sortColumnIndex,
//         sortAscending: _sortAscending,
//         onSelectAll: (val) => setState(() => selectAll(val)),
//         columns: [
//           DataColumn2(
//             label: const Text('Desert'),
//             size: ColumnSize.S,
//             onSort: (columnIndex, ascending) =>
//                 _sort<String>((d) => d.name, columnIndex, ascending),
//           ),
//           DataColumn2(
//             label: const Text('Calories'),
//             size: ColumnSize.S,
//             numeric: true,
//             onSort: (columnIndex, ascending) =>
//                 _sort<num>((d) => d.calories, columnIndex, ascending),
//           ),
//           DataColumn2(
//             label: const Text('Fat (gm)'),
//             size: ColumnSize.S,
//             numeric: true,
//             onSort: (columnIndex, ascending) =>
//                 _sort<num>((d) => d.fat, columnIndex, ascending),
//           ),
//           DataColumn2(
//             label: const Text('Carbs (gm)'),
//             size: ColumnSize.S,
//             numeric: true,
//             onSort: (columnIndex, ascending) =>
//                 _sort<num>((d) => d.carbs, columnIndex, ascending),
//           ),
//           DataColumn2(
//             label: const Text('Protein (gm)'),
//             size: ColumnSize.S,
//             numeric: true,
//             onSort: (columnIndex, ascending) =>
//                 _sort<num>((d) => d.protein, columnIndex, ascending),
//           ),
//           DataColumn2(
//             label: const Text('Sodium (mg)'),
//             size: ColumnSize.S,
//             numeric: true,
//             onSort: (columnIndex, ascending) =>
//                 _sort<num>((d) => d.sodium, columnIndex, ascending),
//           ),
//           DataColumn2(
//             label: const Text('Calcium (%)'),
//             size: ColumnSize.S,
//             numeric: true,
//             onSort: (columnIndex, ascending) =>
//                 _sort<num>((d) => d.calcium, columnIndex, ascending),
//           ),
//           DataColumn2(
//             label: const Text('Iron (%)'),
//             size: ColumnSize.S,
//             numeric: true,
//             onSort: (columnIndex, ascending) =>
//                 _sort<num>((d) => d.iron, columnIndex, ascending),
//           ),
//         ],
//         rows: List<DataRow>.generate(
//             _dataItems, (index) => _getRow(index, Colors.transparent)));
//   }
//
//   Widget getPaginatedDataTable() {
//     return PaginatedDataTable2(
//         scrollController: _innerController,
//         columnSpacing: 0,
//         horizontalMargin: 12,
//         border: TableBorder.all(width: 1.0, color: Colors.grey),
//         headingRowColor: MaterialStateProperty.resolveWith(
//             (states) => _fixedRows > 0 ? Colors.grey[200] : Colors.transparent),
//         fixedColumnsColor: Colors.grey[300],
//         fixedCornerColor: Colors.grey[400],
//         minWidth: 1000,
//         fixedTopRows: _fixedRows,
//         fixedLeftColumns: _fixedCols,
//         sortColumnIndex: _sortColumnIndex,
//         sortAscending: _sortAscending,
//         onSelectAll: (val) => setState(() => selectAll(val)),
//         columns: [
//           DataColumn2(
//             label: const Text('Desert'),
//             size: ColumnSize.S,
//             onSort: (columnIndex, ascending) =>
//                 _sort<String>((d) => d.name, columnIndex, ascending),
//           ),
//           DataColumn2(
//             label: const Text('Calories'),
//             size: ColumnSize.S,
//             numeric: true,
//             onSort: (columnIndex, ascending) =>
//                 _sort<num>((d) => d.calories, columnIndex, ascending),
//           ),
//           DataColumn2(
//             label: const Text('Fat (gm)'),
//             size: ColumnSize.S,
//             numeric: true,
//             onSort: (columnIndex, ascending) =>
//                 _sort<num>((d) => d.fat, columnIndex, ascending),
//           ),
//           DataColumn2(
//             label: const Text('Carbs (gm)'),
//             size: ColumnSize.S,
//             numeric: true,
//             onSort: (columnIndex, ascending) =>
//                 _sort<num>((d) => d.carbs, columnIndex, ascending),
//           ),
//           DataColumn2(
//             label: const Text('Protein (gm)'),
//             size: ColumnSize.S,
//             numeric: true,
//             onSort: (columnIndex, ascending) =>
//                 _sort<num>((d) => d.protein, columnIndex, ascending),
//           ),
//           DataColumn2(
//             label: const Text('Sodium (mg)'),
//             size: ColumnSize.S,
//             numeric: true,
//             onSort: (columnIndex, ascending) =>
//                 _sort<num>((d) => d.sodium, columnIndex, ascending),
//           ),
//           DataColumn2(
//             label: const Text('Calcium (%)'),
//             size: ColumnSize.S,
//             numeric: true,
//             onSort: (columnIndex, ascending) =>
//                 _sort<num>((d) => d.calcium, columnIndex, ascending),
//           ),
//           DataColumn2(
//             label: const Text('Iron (%)'),
//             size: ColumnSize.S,
//             numeric: true,
//             onSort: (columnIndex, ascending) =>
//                 _sort<num>((d) => d.iron, columnIndex, ascending),
//           ),
//         ],
//         source: _dessertsDataSource);
//   }
//
//   Widget getAsyncPaginatedDataTable() {
//     return AsyncPaginatedDataTable2(
//         scrollController: _innerController,
//         columnSpacing: 0,
//         horizontalMargin: 12,
//         border: TableBorder.all(width: 1.0, color: Colors.grey),
//         headingRowColor: MaterialStateProperty.resolveWith(
//             (states) => _fixedRows > 0 ? Colors.grey[200] : Colors.transparent),
//         fixedColumnsColor: Colors.grey[300],
//         fixedCornerColor: Colors.grey[400],
//         minWidth: 1000,
//         fixedTopRows: _fixedRows,
//         fixedLeftColumns: _fixedCols,
//         sortColumnIndex: _sortColumnIndex,
//         sortAscending: _sortAscending,
//         onSelectAll: (val) => setState(() => selectAll(val)),
//         columns: [
//           DataColumn2(
//             label: const Text('Desert'),
//             size: ColumnSize.S,
//             onSort: (columnIndex, ascending) =>
//                 _sort<String>((d) => d.name, columnIndex, ascending),
//           ),
//           DataColumn2(
//             label: const Text('Calories'),
//             size: ColumnSize.S,
//             numeric: true,
//             onSort: (columnIndex, ascending) =>
//                 _sort<num>((d) => d.calories, columnIndex, ascending),
//           ),
//           DataColumn2(
//             label: const Text('Fat (gm)'),
//             size: ColumnSize.S,
//             numeric: true,
//             onSort: (columnIndex, ascending) =>
//                 _sort<num>((d) => d.fat, columnIndex, ascending),
//           ),
//           DataColumn2(
//             label: const Text('Carbs (gm)'),
//             size: ColumnSize.S,
//             numeric: true,
//             onSort: (columnIndex, ascending) =>
//                 _sort<num>((d) => d.carbs, columnIndex, ascending),
//           ),
//           DataColumn2(
//             label: const Text('Protein (gm)'),
//             size: ColumnSize.S,
//             numeric: true,
//             onSort: (columnIndex, ascending) =>
//                 _sort<num>((d) => d.protein, columnIndex, ascending),
//           ),
//           DataColumn2(
//             label: const Text('Sodium (mg)'),
//             size: ColumnSize.S,
//             numeric: true,
//             onSort: (columnIndex, ascending) =>
//                 _sort<num>((d) => d.sodium, columnIndex, ascending),
//           ),
//           DataColumn2(
//             label: const Text('Calcium (%)'),
//             size: ColumnSize.S,
//             numeric: true,
//             onSort: (columnIndex, ascending) =>
//                 _sort<num>((d) => d.calcium, columnIndex, ascending),
//           ),
//           DataColumn2(
//             label: const Text('Iron (%)'),
//             size: ColumnSize.S,
//             numeric: true,
//             onSort: (columnIndex, ascending) =>
//                 _sort<num>((d) => d.iron, columnIndex, ascending),
//           ),
//         ],
//         source: _asyncDessertsDataSource);
//   }
//
//   DataRow _getRow(int index, [Color? color]) {
//     final format = NumberFormat.decimalPercentPattern(
//       locale: 'en',
//       decimalDigits: 0,
//     );
//     assert(index >= 0);
//     if (index >= _desserts.length) throw 'index > _desserts.length';
//     final dessert = _desserts[index];
//     return DataRow2.byIndex(
//       index: index,
//       selected: dessert.selected,
//       color: color != null ? MaterialStateProperty.all(color) : null,
//       onSelectChanged: (value) {
//         if (dessert.selected != value) {
//           dessert.selected = value!;
//           setState(() {});
//         }
//       },
//       cells: [
//         DataCell(Text(dessert.name)),
//         DataCell(Text('${dessert.calories}')),
//         DataCell(Text(dessert.fat.toStringAsFixed(1))),
//         DataCell(Text('${dessert.carbs}')),
//         DataCell(Text(dessert.protein.toStringAsFixed(1))),
//         DataCell(Text('${dessert.sodium}')),
//         DataCell(Text(format.format(dessert.calcium / 100))),
//         DataCell(Text(format.format(dessert.iron / 100))),
//       ],
//     );
//   }
//
//   void selectAll(bool? checked) {
//     for (final dessert in _desserts) {
//       dessert.selected = checked ?? false;
//     }
//   }
//
//   void _sort<T>(
//     Comparable<T> Function(Dessert d) getField,
//     int columnIndex,
//     bool ascending,
//   ) {
//     _dessertsDataSource.sort<T>(getField, ascending);
//     setState(() {
//       _sortColumnIndex = columnIndex;
//       _sortAscending = ascending;
//     });
//   }
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
