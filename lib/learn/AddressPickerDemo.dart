import 'package:city_pickers/city_pickers.dart';
import 'package:city_pickers/modal/result.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:flutter_pickers/style/default_style.dart';
import 'package:flutter_pickers/style/picker_style.dart';

import 'AddressPickerFullDemo.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "country wheelpicker",
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
        title: const Text("flutter country wheelpicker"),
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                showCountryPicker(
                  context: context,
                  showPhoneCode: true,
                  // optional. Shows phone code before the country name.
                  onSelect: (Country country) {
                    print('Select country: ${country.displayName}');
                  },
                );
              },
              child: Text('country wheelpicker')),
          // 自带省市区三级联动数据，不支持空安全，不建议使用
          // flutter run lib/CountryPickerDemo.dart --no-sound-null-safety
          // ElevatedButton(onPressed: (){
          //   showModalBottomSheet(
          //       context: context,
          //       builder: (context) => BottomSheet(
          //           onClosing: () {},
          //           builder: (context) => Container(
          //             height: 250.0,
          //             child: AddressPicker(
          //               style: TextStyle(color: Colors.black, fontSize: 16),
          //               mode: AddressPickerMode.provinceCityAndDistrict,
          //               onSelectedAddressChanged: (address) {
          //                 print('${address.currentProvince.province}');
          //                 print('${address.currentCity.city}');
          //                 print('${address.currentDistrict.area}');
          //               },
          //             ),
          //           )));
          // }, child: Text('adress picker')),

          ElevatedButton(
              onPressed: () {
                print('result ${getResult().toString()}');
              },
              child: Text('city_pickers')),
          ElevatedButton(onPressed: () {}, child: _selectLocation()),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return AddressPickerWidget();
                }));
              },
              child: Text('flutter_picker')),
        ],
      ),
    );
  }

  // 通过钩子事件, 主动唤起浮层.
  // 自带省市区数据，过长城市名缩小展示，停止滚动时再刷新城市信息，性能更好
  // 支持三种形式展示 省市区选择
  Future<Result?> getResult() async {
    // type 1
    Result? result1 = await CityPickers.showCityPicker(
        context: context,
        borderRadius: 15,
        height: 300,
        cancelWidget: null,
        confirmWidget: null);
    // // type 2
    // Result? result2 = await CityPickers.showFullPageCityPicker(
    //   context: context,
    // );
    //
    // // type 3
    // Result? result3 = await CityPickers.showCitiesSelector(
    //   context: context,
    // );
    return result1;
  }

  // 自带省市区数据源，支持配置初始默认值
  String initProvince = '四川省', initCity = '成都市', initTown = '双流区';

  Widget _selectLocation() {
    return InkWell(
        onTap: () {
          Pickers.showAddressPicker(
            context,
            initProvince: initProvince,
            initCity: initCity,
            initTown: initTown,
            addAllItem: false,
            // 市、区是否添加 '全部' 选项
            pickerStyle: ClosePickerStyle(haveRadius: true),
            // pickerStyle: customizeStyle(),
            onConfirm: (p, c, t) {
              setState(() {
                initProvince = p;
                initCity = c;
                initTown = t ?? '';
              });
            },
          );
        },
        child: Text('flutter_pickers：$initProvince - $initCity - $initTown'));
  }

  PickerStyle customizeStyle() {
    double menuHeight = 46.0;
    Widget _headMenuView = Container(
        color: Colors.white54,
        height: menuHeight,
        child: const Center(
            child: Text(
          '净身高',
          style: TextStyle(color: Colors.white),
        )));

    Widget _cancelButton = Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      margin: const EdgeInsets.only(left: 22),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.orange, width: 1),
          borderRadius: BorderRadius.circular(4)),
      child: const Text(
        '取消',
        style: TextStyle(color: Colors.orange, fontSize: 14),
      ),
    );

    Widget _commitButton = Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      margin: const EdgeInsets.only(right: 22),
      decoration: BoxDecoration(
          color: Colors.green, borderRadius: BorderRadius.circular(4)),
      child: const Text(
        '确认',
        style: TextStyle(color: Colors.white, fontSize: 14),
      ),
    );

    // 头部样式
    Decoration headDecoration = const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8), topRight: Radius.circular(8)));

    Widget title = const Center(
        child: Text(
      '身高选择器',
      style: TextStyle(color: Colors.cyanAccent, fontSize: 14),
    ));

    /// item 覆盖样式
    Widget itemOverlay = Container(
      decoration: const BoxDecoration(
        border: Border.symmetric(
            horizontal: BorderSide(color: Colors.deepOrangeAccent, width: 1)),
      ),
    );

    return PickerStyle(
      menu: _headMenuView,
      menuHeight: menuHeight,
      pickerHeight: 320,
      pickerTitleHeight: 60,
      pickerItemHeight: 50,
      cancelButton: _cancelButton,
      commitButton: _commitButton,
      headDecoration: headDecoration,
      title: title,
      textColor: Colors.black,
      backgroundColor: Colors.white,
      itemOverlay: itemOverlay,
    );
  }
}
