import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

import 'option_grid_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "html widget",
      // theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("html组件"),
        ),
        body: HtmlWidget(
          // the first parameter (`html`) is required
          '''
          <div style="text-align: center; background-color: #f0f0f0; padding: 20px;">
  <h2 style="color: #333;">Welcome to My Website</h2>
  <img src="https://img2.baidu.com/it/u=2105446738,2493267053&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=800" alt="Example Image" style="width: 300px; height: auto; border: 2px solid #ccc;">
  <p style="color: #666; font-size: 14px;">
    This is a paragraph with an image above and some inline styles.
  </p>

  <h3>Heading</h3>
  <p style="color: blue; font-size: 16px;">
  This is a paragraph with <a href="https://www.baidu.com" style="text-decoration: none; color: red;">a link</a> and some inline styles.
</p>
  <p>
    A paragraph with <strong>strong</strong>, <em>emphasized</em>
    and <span style="color: red">colored</span> text.
  </p>
  </div>
  ''',

          // all other parameters are optional, a few notable params:

          // specify custom styling for an element
          // see supported inline styling below
          customStylesBuilder: (element) {
            if (element.classes.contains('foo')) {
              return {'color': 'red'};
            }

            return null;
          },

          customWidgetBuilder: (element) {
            if (element.attributes['foo'] == 'bar') {
              // render a custom widget that takes the full width
              return Container(
                color: Colors.yellow,
                child: Text('这里是自定义的页脚'),
              );
            }

            if (element.attributes['fizz'] == 'buzz') {
              // render a custom widget that inlines with surrounding text
              return Container(
                color: Colors.green,
                padding: const EdgeInsets.all(4),
                margin: const EdgeInsets.symmetric(horizontal: 2),
                child: Text('inline 组件'),
              );
            }

            return null;
          },

          // this callback will be triggered when user taps a link
          onTapUrl: (url) {
            debugPrint('tapped $url');
            return false;
          },

          // select the render mode for HTML body
          // by default, a simple `Column` is rendered
          // consider using `ListView` or `SliverList` for better performance
          renderMode: RenderMode.column,

          // set the default styling for text
          textStyle: TextStyle(fontSize: 14),
        ),
      ),
    );
  }
}
