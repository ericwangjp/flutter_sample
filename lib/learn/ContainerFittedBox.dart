import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "fitted box",
      theme: ThemeData(primarySwatch: Colors.cyan),
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
        title: Text("flutter fitted box"),
      ),
      body: Column(
        children: const [MyFittedBox(), WidthFittedWidget()],
      ),
    );
  }
}

class MyFittedBox extends StatelessWidget {
  const MyFittedBox({Key? key}) : super(key: key);

  Widget fContainer(BoxFit boxFit) {
    return Container(
      width: 50,
      height: 50,
      color: Colors.red,
      child: FittedBox(
        fit: boxFit,
        child: Container(
          width: 60,
          height: 70,
          color: Colors.blue,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          fContainer(BoxFit.none),
          Text("空间适配"),
          fContainer(BoxFit.contain),
          Text("fitted box")
        ],
      ),
    );
  }
}

class WidthFittedWidget extends StatelessWidget {
  const WidthFittedWidget({Key? key}) : super(key: key);

  Widget fitRow(String text) {
    Widget child = Text(text);
    child = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [child, child, child],
    );
    return child;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          fitRow("text-------------11111--------------"),
          SingleLineFittedBox(
            child: fitRow("text-------------11111--------------"),
          ),
          fitRow("text--222222--"),
          SingleLineFittedBox(
            child: fitRow("text--222222--"),
          )
        ]
            .map((e) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: e,
                ))
            .toList(),
      ),
    );
  }
}

class SingleLineFittedBox extends StatelessWidget {
  const SingleLineFittedBox({Key? key, this.child}) : super(key: key);
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context,constrains){
      return FittedBox(
        child: ConstrainedBox(
          constraints: constrains.copyWith(
            minWidth: constrains.maxWidth,
            maxWidth: double.infinity
          ),
          child: child,
        ),
      );
    });
  }
}

