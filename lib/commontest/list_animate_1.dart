import 'package:animation_list/animation_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/widgets/attention_seekers/rubber_band.dart';
import 'package:flutter_animator/widgets/attention_seekers/shake.dart';
import 'package:flutter_animator/widgets/attention_seekers/wobble.dart';
import 'package:flutter_animator/widgets/bouncing_entrances/bounce_in_up.dart';

class AnimateListOnePage extends StatelessWidget {
  const AnimateListOnePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "列表动画",
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
        title: const Text("flutter 列表动画"),
      ),
      body: AnimationList(
        duration: 3000,
        reBounceDepth: 0,
        children: List.generate(
            20,
            (index) => Container(
                  color: Colors.grey,
                  padding: const EdgeInsets.all(20),
                  child: Text('这是第 $index 个'),
                )),
        // itemBuilder: (context, index) {
        //   return ListTile(title: Text('这是第 $index 个'),);
        // },
        // separatorBuilder: (context, index) {
        //   return const Divider(
        //     height: 10,
        //     color: Colors.orange,
        //   );
        // },
        // itemCount: 20
      ),
    );
  }
}
