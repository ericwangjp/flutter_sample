import 'package:flutter/material.dart';

class ExcelLikeTable extends StatefulWidget {
  const ExcelLikeTable({super.key});

  @override
  State<ExcelLikeTable> createState() => _ExcelLikeTableState();
}

class _ExcelLikeTableState extends State<ExcelLikeTable> {
  final ScrollController _horizontalController1 = ScrollController();
  final ScrollController _horizontalController2 = ScrollController();
  bool _isHorizontalController1Scrolling = false;
  bool _isHorizontalController2Scrolling = false;

  @override
  void initState() {
    super.initState();
    _horizontalController1.addListener(() {
      if (_isHorizontalController2Scrolling) return;
      _isHorizontalController1Scrolling = true;
      if (_horizontalController2.hasClients) {
        _horizontalController2.jumpTo(_horizontalController1.offset);
      }
      _isHorizontalController1Scrolling = false;
    });

    _horizontalController2.addListener(() {
      if (_isHorizontalController1Scrolling) return;
      _isHorizontalController2Scrolling = true;
      if (_horizontalController1.hasClients) {
        _horizontalController1.jumpTo(_horizontalController2.offset);
      }
      _isHorizontalController2Scrolling = false;
    });
  }

  @override
  void dispose() {
    _horizontalController1.dispose();
    _horizontalController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Excel-like Table'),
      ),
      body: Stack(
        children: [
          // Main scrollable area
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Row(
                  children: [
                    // Frozen first column
                    Column(
                      children: List.generate(30, (index) {
                        return Container(
                          width: 100,
                          height: 50,
                          color: Colors.grey[300],
                          child: Center(child: Text('Row $index')),
                        );
                      }),
                    ),
                    // Scrollable content
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        controller: _horizontalController1,
                        child: Column(
                          children: List.generate(30, (index) {
                            return Row(
                              children: List.generate(10, (colIndex) {
                                return Container(
                                  width: 100,
                                  height: 50,
                                  color: Colors.white,
                                  child: Center(
                                      child: Text(
                                          'Cell $index-$colIndex')),
                                );
                              }),
                            );
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Top-left corner cell
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: 100,
              height: 50,
              color: Colors.grey[300],
              child: Center(child: Text('Header')),
            ),
          ),
          Positioned(
              top: 0,
              left: 100,
              right: 0,
              child: SingleChildScrollView(
                controller: _horizontalController2,
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(10, (index) {
                    return Container(
                      width: 100,
                      height: 50,
                      color: Colors.grey[300],
                      child: Center(child: Text('Col $index')),
                    );
                  }),
                ),
              ))
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ExcelLikeTable(),
  ));
}