import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_sample/commontest/excel_like_table.dart';

class FlutterDataTableView extends StatelessWidget {
  const FlutterDataTableView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "flutter",
      theme: ThemeData(primarySwatch: Colors.blue),
      // localizationsDelegates: const [
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate
      // ],
      // supportedLocales: const [
      //   Locale('zh', 'CN'),
      //   Locale('en', 'US'),
      // ],
      home: const HomePage(),
      routes: {
        // '/': (context) => HomePage(),
        '/excel': (context) => const ExcelLikeTable(),
      },
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
          title: const Text("flutter组件"),
        ),
        body: _buildBody(context),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/excel');
          },
          child: const Icon(Icons.camera),
        ));
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const <DataColumn>[
          DataColumn(
            label: Text(
              'Name',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          DataColumn(
            label: Text(
              'Age',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
            numeric: true,
          ),
          DataColumn(
            label: Text(
              'Role',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ],
        rows: const <DataRow>[
          DataRow(
            cells: <DataCell>[
              DataCell(Text('John')),
              DataCell(Text('25')),
              DataCell(Text('Developer')),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text('Jane')),
              DataCell(Text('30')),
              DataCell(Text('Designer')),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text('Alex')),
              DataCell(Text('28')),
              DataCell(Text('Manager')),
            ],
          ),
        ],
      ),
    );
  }
}
