// ignore_for_file: library_private_types_in_public_api, no_leading_underscores_for_local_identifiers

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:vs_story_designer/src/presentation/utils/color_detection.dart';

class FileImageBG extends StatefulWidget {
  const FileImageBG(
      {required this.filePath, required this.generatedGradient, super.key,});
  final File? filePath;
  final void Function(Color color1, Color color2) generatedGradient;
  @override
  _FileImageBGState createState() => _FileImageBGState();
}

class _FileImageBGState extends State<FileImageBG> {
  GlobalKey imageKey = GlobalKey();
  GlobalKey paintKey = GlobalKey();

  GlobalKey? currentKey;

  final StreamController<Color> stateController = StreamController<Color>();
  Color color1 = const Color(0xFFFFFFFF);
  Color color2 = const Color(0xFFFFFFFF);

  @override
  void initState() {
    currentKey = paintKey;
    Timer.periodic(const Duration(milliseconds: 500), (callback) async {
      if (imageKey.currentState!.context.size!.height == 0.0) {
      } else {
        final cd1 = await ColorDetection(
          currentKey: currentKey,
          paintKey: paintKey,
          stateController: stateController,
        ).searchPixel(
            Offset(imageKey.currentState!.context.size!.width / 2, 480),);
        final cd12 = await ColorDetection(
          currentKey: currentKey,
          paintKey: paintKey,
          stateController: stateController,
        ).searchPixel(
            Offset(imageKey.currentState!.context.size!.width / 2.03, 530),);
        color1 = cd1;
        color2 = cd12;
        setState(() {});
        widget.generatedGradient(color1, color2);
        callback.cancel();
        await stateController.close();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return SizedBox(
        height: _size.height,
        width: _size.width,
        child: RepaintBoundary(
            key: paintKey,
            child: Center(
                child: Image.file(
              File(widget.filePath!.path),
              key: imageKey,
              filterQuality: FilterQuality.high,
            ),),),);
  }
}
