import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gal/gal.dart';
import 'package:path_provider/path_provider.dart';

Future takePicture({
  required GlobalKey contentKey,
  required BuildContext context,
  required bool saveToGallery,
  required String fileName,
}) async {
  try {
    /// Convert widget to image
    final RenderRepaintBoundary boundary =
        contentKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    final ui.Image image = await boundary.toImage(pixelRatio: 3);
    final ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List pngBytes = byteData!.buffer.asUint8List();

    /// Create file in app's directory
    final String dir = (await getApplicationDocumentsDirectory()).path;
    final String imagePath =
        '$dir/${fileName}_${DateTime.now().millisecondsSinceEpoch}.png';
    final File capturedFile = File(imagePath);
    await capturedFile.writeAsBytes(pngBytes);

    if (saveToGallery) {
      try {
        await Gal.putImage(imagePath);
        return true;
      } on GalException catch (e) {
        log(e.toString());
        return false;
      }
    } else {
      return imagePath;
    }
  } catch (e) {
    debugPrint('Exception: $e');
    return false;
  }
}
