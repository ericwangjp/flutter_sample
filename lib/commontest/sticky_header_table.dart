import 'package:flutter/material.dart';

class StickyHeaderTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sticky Header Table'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: false,
            flexibleSpace: FlexibleSpaceBar(
              title: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(10, (index) {
                    return Container(
                      width: 100,
                      height: 50,
                      child: Center(child: Text('Col $index')),
                    );
                  }),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(10, (colIndex) {
                      return Container(
                        width: 100,
                        height: 50,
                        color: Colors.white,
                        child: Center(child: Text('Cell $index-$colIndex')),
                      );
                    }),
                  ),
                );
              },
              childCount: 20,
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: StickyHeaderTable(),
  ));
}