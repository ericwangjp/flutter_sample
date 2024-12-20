import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_sample/learn/dart_mixin.dart';
import 'package:flutter_sample/model/Animals.dart';
import 'package:flutter_sample/model/CollectionListModel.dart';
import 'package:flutter_sample/model/EatModel.dart';
import 'package:flutter_sample/model/ListModel.dart';
import 'package:flutter_sample/model/NewPerson.dart';
import 'package:flutter_sample/model/Persons.dart';

import '../model/FavoriteColors.dart';
import '../model/SeniorPerson.dart';
import '../model/Shop.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "状态共享",
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
  Animals animals = Animals("兔子", "白色");
  FavoriteColors favoriteColors = FavoriteColors("金色");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("flutter provider"),
      ),
      body: Column(
        children: [
          /// 最基础的 provider 组成，接收一个任意值并暴露它，但是并不会更新UI。
          // Provider<SeniorPerson>(
          //   create: (context) => SeniorPerson(),
          //   child: ProviderDemo(),
          // ),

          // Provider.value(value: animals,child: ProviderDemo(),),

          // ChangeNotifierProvider<FavoriteColors>.value(value: favoriteColors,child: ProviderDemo(),),

          /// 会更新 UI
          ChangeNotifierProvider<NewPerson>(
            create: (ctx) => NewPerson(name: "jack"),
            child: ChangeNotifierProviderDemo(),
          ),

          /// FutureProvider只会重建一次
          /// 默认显示初始值，Future进入 complete 状态时，会更新UI
          /// 延迟更新 UI
          // FutureProvider<NewPerson>(
          //   initialData: NewPerson(name: "初始值"),
          //   create: (ctx) {
          //     /// 延迟2s后更新
          //     return Future.delayed(const Duration(seconds: 2),
          //         () => NewPerson(name: "更新FutureProvider"));
          //   },
          //   child: FutureProviderDemo(),
          // ),

          /// 监听流，并暴露出当前的最新值，并多次触发重新构建UI。
          // StreamProvider<NewPerson>(
          //   initialData: NewPerson(name: "初始值"),
          //   create: (ctx) {
          //     /// 传入一个Stream，每间隔1s数据更新一次
          //     return Stream<NewPerson>.periodic(const Duration(seconds: 1),
          //         (value) {
          //       return NewPerson(name: "StreamProvider ---  $value");
          //     });
          //   },
          //   child: StreamProviderDemo(),
          // )

          /// MultiProvider
          // MultiProvider(
          //   providers: [
          //     ChangeNotifierProvider<Person1>(create: (context) {
          //       return Person1(name: "张三");
          //     }),
          //     ChangeNotifierProvider<Person2>(create: (context) {
          //       return Person2(name: "李四");
          //     }),
          //   ],
          //   child: MultiProviderDemo(),
          // )

          /// ProxyProvider
          // MultiProvider(providers: [
          //   ChangeNotifierProvider<Person1>(create: (context)=>Person1(name: "张三")),
          //   ProxyProvider<Person1,EatModel>(update: (context,person,eatModel)=>EatModel(person.name))
          // ],child: ProxyProviderDemo(),)

          /// ChangeNotifierProxyProvider
          /// 与 ProxyProvider 的相似，不同的是 ChangeNotifierProxyProvider 会将它的值传递给 ChangeNotifierProvider 而非 Provider
          // MultiProvider(providers: [
          //   Provider<ListModel>(create: (context) => ListModel()),
          //   ChangeNotifierProxyProvider<ListModel,CollectionListModel>(
          //       create: (context) => CollectionListModel(ListModel()),
          //       update: (context, listModel, collectionModel) =>
          //           CollectionListModel(listModel))
          // ],child: ChangeNotifierProxyProviderDemo(),),


          /// ListenableProvider
          /// ListenableProxyProvider
          /// ValueListenableProvider



        ],
      ),
    );
  }
}

/// 最基础的 provider 组成，接收一个任意值并暴露它，但是并不会更新UI。
class ProviderDemo extends StatelessWidget {
  const ProviderDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          // Consumer<SeniorPerson>(
          //   builder: (context, person, child) {
          //     return Text(person.name);
          //   },
          // ),
          // Consumer<SeniorPerson>(builder: (context, person, child) {
          //   return ElevatedButton(
          //       onPressed: () {
          //           person.name = "jack";
          //       },
          //       child: const Text("更新名字"));
          // }),
          //
          // Consumer<Animals>(
          //   builder: (context, animal, child) {
          //     return Text(animal.name);
          //   },
          // ),
          // Consumer<Animals>(builder: (context, animal, child) {
          //   return ElevatedButton(
          //       onPressed: () {
          //         animal.name = "猪";
          //       },
          //       child: const Text("更新动物"));
          // }),

          Consumer<FavoriteColors>(
            builder: (context, colors, child) {
              return Text(colors.color);
            },
          ),
          Consumer<FavoriteColors>(builder: (context, colors, child) {
            return ElevatedButton(
                onPressed: () {
                  colors.color = "红色";
                },
                child: const Text("更新颜色"));
          }),
        ],
      ),
    );
  }
}

/// ChangeNotifierProvider 会更新 UI
class ChangeNotifierProviderDemo extends StatelessWidget {
  const ChangeNotifierProviderDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          /// 拿到person对象，读取数据
          Consumer<NewPerson>(
            builder: (ctx, person, child){
              debugPrint("监听到数据更新:${person.name}");
              return Text(person.name);
            },
          ),

          /// 拿到person对象，调用方法
          Consumer<NewPerson>(
            builder: (ctx, person, child) {
              return ElevatedButton(
                /// 点击按钮，调用方法更新
                onPressed: () => person.changName(
                    // newName: "ChangeNotifierProvider更新了${Random.secure().nextDouble()}"),
                    newName: "ChangeNotifierProvider更新了"),
                child: const Text("点击更新"),
              );
            },
          ),
        ],
      ),
    );
  }
}

/// FutureProvider 延迟更新 UI
class FutureProviderDemo extends StatelessWidget {
  const FutureProviderDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Consumer<NewPerson>(
      builder: (ctx, person, child) => Text(person.name),
    ));
  }
}

/// StreamProvider 多次触发重新构建UI
class StreamProviderDemo extends StatelessWidget {
  const StreamProviderDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer<NewPerson>(
        builder: (ctx, person, child) => Text(person.name),
      ),
    );
  }
}

/// MultiProvider
class MultiProviderDemo extends StatelessWidget {
  const MultiProviderDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Consumer<Person1>(builder: (context, person, child) {
            return Text(person.name);
          }),
          Consumer<Person2>(builder: (context, person, child) {
            return Text(person.name);
          }),
          // 拿到person1对象，调用方法，也可以修改person2
          Consumer<Person1>(builder: (context, person, child) {
            return ElevatedButton(
                onPressed: () {
                  person.changName(newName: "王五");
                },
                child: const Text("点击修改"));
          }),
        ],
      ),
    );
  }
}

/// ProxyProvider
class ProxyProviderDemo extends StatelessWidget {
  const ProxyProviderDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Consumer<EatModel>(
              builder: (context, eatModel, child) => Text(eatModel.whoEat)),
          Consumer<Person1>(builder: (context, person, child) {
            return ElevatedButton(
                onPressed: () {
                  person.changName(
                      newName: "newName-${Random.secure().nextInt(100)}");
                },
                child: const Text("点击修改"));
          })
        ],
      ),
    );
  }
}

/// ChangeNotifierProxyProvider
class ChangeNotifierProxyProviderDemo extends StatefulWidget {
  const ChangeNotifierProxyProviderDemo({Key? key}) : super(key: key);

  @override
  State<ChangeNotifierProxyProviderDemo> createState() => _ChangeNotifierProxyProviderDemoState();
}

class _ChangeNotifierProxyProviderDemoState extends State<ChangeNotifierProxyProviderDemo> {

  @override
  Widget build(BuildContext context) {
    ListModel listModel = Provider.of<ListModel>(context);
    List<Shop> shops = listModel.shops;

    // CollectionListModel collectionModel = Provider.of<CollectionListModel>(context);
    // List<Shop> shops = collectionModel.shops;

    return Expanded(
      child: ListView.builder(
          itemCount: listModel.shops.length,
          itemBuilder: (ctx,index) => ListTile(title: Text(shops[index].name),),
      ),
    );

  }
}

// Provider.of<Person>(context, listen: false)..increaseAge()
// context.select((Person person) => person.age);
// final person = context.watch<Person>();
// context.read<Person>().name
// Selector<Person,int>(
//           selector: (ctx,person) => person.age,
//           builder: (ctx,age,child) {})
// Provider.of
// static T of<T>(BuildContext context, {bool listen = true})
// 其中 listen：默认true监听状态变化，false为不监听状态改变。