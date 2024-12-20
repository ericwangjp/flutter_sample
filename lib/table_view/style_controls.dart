// import 'package:flutter/material.dart';
// import 'package:material_table_view/material_table_view.dart';
//
// import 'global_target_platform.dart';
//
// class StylingController with ChangeNotifier {
//   final verticalDividerWigglesPerRow = ValueNotifier<int>(3);
//   final verticalDividerWiggleOffset = ValueNotifier<double>(6.0);
//   final lineDividerEnabled = ValueNotifier<bool>(false);
//   final useRTL = ValueNotifier<bool>(false);
//
//   StylingController() {
//     verticalDividerWigglesPerRow.addListener(notifyListeners);
//     verticalDividerWiggleOffset.addListener(notifyListeners);
//     lineDividerEnabled.addListener(notifyListeners);
//     useRTL.addListener(notifyListeners);
//   }
//
//   TableViewStyle get tableViewStyle => TableViewStyle(
//         dividers: TableViewDividersStyle(
//           vertical: TableViewVerticalDividersStyle.symmetric(
//             TableViewVerticalDividerStyle(
//               wiggleOffset: verticalDividerWiggleOffset.value,
//               wigglesPerRow: verticalDividerWigglesPerRow.value,
//             ),
//           ),
//         ),
//       );
//
//   @override
//   void dispose() {
//     verticalDividerWigglesPerRow.removeListener(notifyListeners);
//     verticalDividerWiggleOffset.removeListener(notifyListeners);
//     lineDividerEnabled.removeListener(notifyListeners);
//     super.dispose();
//   }
// }
//
// class StylingControlsPopup extends ModalRoute<void> {
//   final StylingController stylingController;
//
//   StylingControlsPopup({
//     required this.stylingController,
//   });
//
//   @override
//   Color? get barrierColor => null;
//
//   @override
//   bool get barrierDismissible => true;
//
//   @override
//   String? get barrierLabel => null;
//
//   @override
//   Widget buildPage(BuildContext context, Animation<double> animation,
//           Animation<double> secondaryAnimation) =>
//       SafeArea(
//         child: ValueListenableBuilder<bool>(
//           valueListenable: stylingController.useRTL,
//           builder: (context, useRTL, child) => Align(
//             alignment: useRTL ? Alignment.topLeft : Alignment.topRight,
//             child: Directionality(
//               textDirection: useRTL ? TextDirection.rtl : TextDirection.ltr,
//               child: child!,
//             ),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: FadeTransition(
//               opacity: animation,
//               child: SizedBox(
//                 width: 256,
//                 child: IntrinsicHeight(
//                   child: Material(
//                     type: MaterialType.card,
//                     clipBehavior: Clip.antiAlias,
//                     shape: RoundedRectangleBorder(
//                       side: Divider.createBorderSide(context),
//                       borderRadius: const BorderRadius.all(
//                         Radius.circular(16.0),
//                       ),
//                     ),
//                     child: StylingControls(
//                       controller: stylingController,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       );
//
//   @override
//   bool get maintainState => false;
//
//   @override
//   bool get opaque => false;
//
//   @override
//   Duration get transitionDuration => const Duration(milliseconds: 200);
// }
//
// class StylingControls extends StatelessWidget {
//   final StylingController controller;
//
//   const StylingControls({
//     super.key,
//     required this.controller,
//   });
//
//   @override
//   Widget build(BuildContext context) => SingleChildScrollView(
//         clipBehavior: Clip.none,
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               ValueListenableBuilder<TargetPlatform?>(
//                 valueListenable: globalTargetPlatform,
//                 builder: (context, currentPlatform, _) =>
//                     DropdownButton<TargetPlatform?>(
//                   items: <DropdownMenuItem<TargetPlatform?>>[
//                     const DropdownMenuItem(
//                       value: null,
//                       child: Text('Default target platform'),
//                     ),
//                   ]
//                       .followedBy(
//                         TargetPlatform.values.map(
//                           (e) => DropdownMenuItem(
//                             value: e,
//                             child: Text(e.toString()),
//                           ),
//                         ),
//                       )
//                       .toList(growable: false),
//                   value: currentPlatform,
//                   onChanged: (value) => globalTargetPlatform.value = value,
//                 ),
//               ),
//               SizedBox(
//                 height: 16.0 + 4.0 * Theme.of(context).visualDensity.vertical,
//               ),
//               Text(
//                 'Number of wiggles in vertical dividers per row',
//                 style: Theme.of(context).textTheme.labelLarge,
//               ),
//               ValueListenableBuilder<int>(
//                 valueListenable: controller.verticalDividerWigglesPerRow,
//                 builder: (context, value, _) => Slider(
//                   min: .0,
//                   max: 16.0,
//                   value: value.toDouble(),
//                   onChanged: (newValue) => controller
//                       .verticalDividerWigglesPerRow.value = newValue.round(),
//                 ),
//               ),
//               Text(
//                 'Vertical dividers wiggle offset',
//                 style: Theme.of(context).textTheme.labelLarge,
//               ),
//               ValueListenableBuilder<double>(
//                 valueListenable: controller.verticalDividerWiggleOffset,
//                 builder: (context, value, _) => Slider(
//                   min: .0,
//                   max: 64.0,
//                   value: value,
//                   onChanged: (newValue) =>
//                       controller.verticalDividerWiggleOffset.value = newValue,
//                 ),
//               ),
//               Text(
//                 'Enable horizontal row divider',
//                 style: Theme.of(context).textTheme.labelLarge,
//               ),
//               ValueListenableBuilder<bool>(
//                 valueListenable: controller.lineDividerEnabled,
//                 builder: (context, value, child) => Checkbox(
//                   value: value,
//                   onChanged: (newValue) =>
//                       controller.lineDividerEnabled.value = newValue ?? false,
//                 ),
//               ),
//               Text(
//                 'Use RTL layout',
//                 style: Theme.of(context).textTheme.labelLarge,
//               ),
//               ValueListenableBuilder<bool>(
//                 valueListenable: controller.useRTL,
//                 builder: (context, value, child) => Checkbox(
//                   value: value,
//                   onChanged: (newValue) =>
//                       controller.useRTL.value = newValue ?? false,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
// }
