import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ImageUtils {
  static Future<ui.Image> loadImageFromAsset(String url) async {
    AssetBundle assetBundle = rootBundle;
    ImageStream stream = AssetImage(url, bundle: assetBundle).resolve(ImageConfiguration.empty);
    Completer<ui.Image> completer = Completer<ui.Image>();
    late ImageStreamListener listener;
    listener = ImageStreamListener(
            (ImageInfo frame, bool synchronousCall) {
          final ui.Image image = frame.image;
          completer.complete(image);
          stream.removeListener(listener);
        });
    stream.addListener(listener);
    return completer.future;
  }

  static Future<ui.Image> loadImageFromFile(String url) async {
    ImageStream stream = FileImage(File.fromUri(Uri.parse(url)),).resolve(ImageConfiguration.empty);
    Completer<ui.Image> completer = Completer<ui.Image>();
    late ImageStreamListener listener;
    listener = ImageStreamListener(
            (ImageInfo frame, bool synchronousCall) {
          final ui.Image image = frame.image;
          completer.complete(image);
          stream.removeListener(listener);
        });
    stream.addListener(listener);
    return completer.future;
  }

  static Future<ui.Image> loadImageFromNetwork(String url) async {
    ImageStream stream = NetworkImage(url).resolve(ImageConfiguration.empty);
    Completer<ui.Image> completer = Completer<ui.Image>();
    late ImageStreamListener listener;
    listener = ImageStreamListener(
            (ImageInfo frame, bool synchronousCall) {
          final ui.Image image = frame.image;
          completer.complete(image);
          stream.removeListener(listener);
        });
    stream.addListener(listener);
    return completer.future;
  }



}