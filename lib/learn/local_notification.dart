// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// import 'notification_jump_page.dart';
//
// /// 在 iOS/macOS 上,通知类别将定义哪些操作可用
// /// 此函数需要是一个顶级或静态方法
// /// 此函数在单独的隔离区中运行（Linux 除外）
// /// 此函数还需要@pragma('vm:entry-point')注释以确保 tree-shaking 不会删除代码
// @pragma('vm:entry-point')
// void notificationTapBackground(NotificationResponse details) {}
//
// void main() => runApp(const MyApp());
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: "本地通知",
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: const NotificationHomePage(),
//     );
//   }
// }
//
// class NotificationHomePage extends StatefulWidget {
//   const NotificationHomePage({Key? key}) : super(key: key);
//
//   @override
//   State<NotificationHomePage> createState() => _NotificationHomePageState();
// }
//
// class _NotificationHomePageState extends State<NotificationHomePage> {
//   late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
//   final String channelId = 'orderNotificationId';
//   final String channelName = 'order_notification';
//   final String channelDesc = '订单消息通知';
//
//   @override
//   void initState() {
//     _initNotificationPlugin();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("flutter 本地通知"),
//       ),
//       body: Column(
//         children: [
//           ElevatedButton(
//               onPressed: () {
//                 _requestAndroidPermission();
//               },
//               child: const Text('请求Android权限')),
//           ElevatedButton(
//               onPressed: () {
//                 _requestIOSPermission();
//               },
//               child: const Text('请求iOS权限')),
//           ElevatedButton(
//               onPressed: () {
//                 _requestMacOSPermission();
//               },
//               child: const Text('请求MacOS权限')),
//           Divider(),
//           ElevatedButton(
//               onPressed: () {
//                 _sendNotification();
//               },
//               child: const Text('发送通知'))
//         ],
//       ),
//     );
//   }
//
//   Future<void> _initNotificationPlugin() async {
//     flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
// // initialise the plugin. ic_app_notification needs to be a added as a drawable resource to the Android head project
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('ic_app_notification');
//     final DarwinInitializationSettings initializationSettingsDarwin =
//         DarwinInitializationSettings(
//             requestSoundPermission: false,
//             requestBadgePermission: false,
//             requestAlertPermission: false,
//             // 指定iOS/macOS对通知的操作, 还需要在项目中做相应的配置
//             notificationCategories: [
//               DarwinNotificationCategory(
//                 'demoCategory',
//                 actions: <DarwinNotificationAction>[
//                   DarwinNotificationAction.plain('id_1', 'Action 1'),
//                   DarwinNotificationAction.plain(
//                     'id_2',
//                     'Action 2',
//                     options: <DarwinNotificationActionOption>{
//                       DarwinNotificationActionOption.destructive,
//                     },
//                   ),
//                   DarwinNotificationAction.plain(
//                     'id_3',
//                     'Action 3',
//                     options: <DarwinNotificationActionOption>{
//                       DarwinNotificationActionOption.foreground,
//                     },
//                   ),
//                 ],
//                 options: <DarwinNotificationCategoryOption>{
//                   DarwinNotificationCategoryOption.hiddenPreviewShowTitle,
//                 },
//               )
//             ],
//             onDidReceiveLocalNotification: onDidReceiveLocalNotification);
//     const LinuxInitializationSettings initializationSettingsLinux =
//         LinuxInitializationSettings(defaultActionName: 'Open notification');
//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//             android: initializationSettingsAndroid,
//             iOS: initializationSettingsDarwin,
//             macOS: initializationSettingsDarwin,
//             linux: initializationSettingsLinux);
//     await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//         onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
//         onDidReceiveBackgroundNotificationResponse: notificationTapBackground);
//   }
//
//   /// ios 前台通知显示处理，同时兼容旧版本
//   void onDidReceiveLocalNotification(
//       int id, String? title, String? body, String? payload) async {
//     // display a dialog with the notification details, tap ok to go to another page
//     showDialog(
//       context: context,
//       builder: (BuildContext context) => CupertinoAlertDialog(
//         title: Text(title ?? ''),
//         content: Text(body ?? ''),
//         actions: [
//           CupertinoDialogAction(
//             isDefaultAction: true,
//             child: Text('Ok'),
//             onPressed: () async {
//               Navigator.of(context, rootNavigator: true).pop();
//               await Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => NotificationJumpPage(payload: payload),
//                 ),
//               );
//             },
//           )
//         ],
//       ),
//     );
//   }
//
//   /// 收到通知点击处理
//   void onDidReceiveNotificationResponse(
//       NotificationResponse notificationResponse) async {
//     final String? payload = notificationResponse.payload;
//     if (notificationResponse.payload != null) {
//       debugPrint('notification payload: $payload');
//     }
//     await Navigator.push(
//       context,
//       MaterialPageRoute<void>(
//           builder: (context) => NotificationJumpPage(payload: payload)),
//     );
//   }
//
//   void _requestAndroidPermission() {
//     flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()
//         ?.requestPermission()
//         .then((value) => debugPrint('是否有权限：$value'));
//   }
//
//   void _requestIOSPermission() {
//     flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             IOSFlutterLocalNotificationsPlugin>()
//         ?.requestPermissions(
//           alert: true,
//           badge: true,
//           sound: true,
//         )
//         .then((value) => debugPrint('是否有权限：$value'));
//   }
//
//   void _requestMacOSPermission() {
//     flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             MacOSFlutterLocalNotificationsPlugin>()
//         ?.requestPermissions(
//           alert: true,
//           badge: true,
//           sound: true,
//         )
//         .then((value) => debugPrint('是否有权限：$value'));
//   }
//
//   Future<void> _sendNotification() async {
//     AndroidNotificationDetails androidNotificationDetails =
//         AndroidNotificationDetails(channelId, channelName,
//             channelDescription: channelDesc,
//             importance: Importance.max,
//             priority: Priority.high,
//             ticker: '通知信息',
//             // 指定对通知的操作,iOS/macOS 需要在项目中配置
//             actions: <AndroidNotificationAction>[
//           const AndroidNotificationAction('id_1', 'Action 1'),
//           const AndroidNotificationAction('id_2', 'Action 2'),
//           const AndroidNotificationAction('id_3', 'Action 3'),
//         ]);
//     NotificationDetails notificationDetails =
//         NotificationDetails(android: androidNotificationDetails);
//     await flutterLocalNotificationsPlugin.show(
//         0, '通知标题', '通知内容说明，很多很多很多', notificationDetails,
//         payload: 'orderNo');
//     // 移除通知
//     // Future.delayed(const Duration(seconds: 2))
//     //     .then((value) => flutterLocalNotificationsPlugin.cancel(0));
//   }
// }
