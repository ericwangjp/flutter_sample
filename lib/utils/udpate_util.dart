import 'dart:ui';

import 'package:flutter/scheduler.dart';

// 安全更新 UI
// void update(VoidCallback callback){
//   final schedulerPhase = SchedulerBinding.instance.schedulerPhase;
//   if(schedulerPhase == SchedulerPhase.persistentCallbacks){
//     SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
//       setState(callback);
//     });
//   } else {
//     setState(callback);
//   }
// }