import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

typedef AsyncImageWidgetBuilder<T> = Widget Function(
    BuildContext context, AsyncSnapshot<T> snapshot, String url);

typedef AsyncImageFileWidgetBuilder<T> = Widget Function(
    BuildContext context, AsyncSnapshot<T> snapshot, File file);

typedef AsyncImageMemoryWidgetBuilder<T> = Widget Function(
    BuildContext context, AsyncSnapshot<T> snapshot, Uint8List bytes);

enum AspectRatioImageType { NETWORK, FILE, ASSET, MEMORY }

/// 可以获取宽高信息的 Image
class AspectRatioImage extends StatelessWidget {
  late String url;
  late File file;
  late Uint8List bytes;
  final ImageProvider provider;
  final AspectRatioImageType type;
  late AsyncImageWidgetBuilder<ui.Image> builder;
  late AsyncImageFileWidgetBuilder<ui.Image> fileBuilder;
  late AsyncImageMemoryWidgetBuilder<ui.Image> memoryBuilder;

  AspectRatioImage.network(this.url, {super.key, required this.builder})
      : provider = NetworkImage(url),
        type = AspectRatioImageType.NETWORK;

  AspectRatioImage.file(
    this.file, {
    super.key,
    required this.fileBuilder,
  })  : provider = FileImage(file),
        type = AspectRatioImageType.FILE;

  AspectRatioImage.asset(this.url, {super.key, required this.builder})
      : provider = AssetImage(url),
        type = AspectRatioImageType.ASSET;

  AspectRatioImage.memory(this.bytes, {super.key, required this.memoryBuilder})
      : provider = MemoryImage(bytes),
        type = AspectRatioImageType.MEMORY;

  @override
  Widget build(BuildContext context) {
    final ImageConfiguration config = createLocalImageConfiguration(context);
    final Completer<ui.Image> completer = Completer<ui.Image>();
    final ImageStream stream = provider.resolve(config);
    late ImageStreamListener listener;
    listener = ImageStreamListener(
      (ImageInfo image, bool sync) {
        completer.complete(image.image);
        stream.removeListener(listener);
      },
      onError: (dynamic exception, StackTrace? stackTrace) {
        completer.complete(null);
        stream.removeListener(listener);
        FlutterError.reportError(FlutterErrorDetails(
          context: ErrorDescription('image failed to precache'),
          library: 'image resource service',
          exception: exception,
          stack: stackTrace,
          silent: true,
        ));
      },
    );
    stream.addListener(listener);

    return FutureBuilder(
        future: completer.future,
        builder: (BuildContext context, AsyncSnapshot<ui.Image> snapshot) {
          if (snapshot.hasData) {
            if (type == AspectRatioImageType.FILE) {
              return fileBuilder(context, snapshot, file);
            } else if (type == AspectRatioImageType.MEMORY) {
              return memoryBuilder(context, snapshot, bytes);
            } else {
              return builder(context, snapshot, url);
            }
          } else {
            return Container();
          }
        });
  }
}
