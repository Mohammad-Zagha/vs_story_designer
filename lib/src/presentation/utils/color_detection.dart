import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;

class ColorDetection {

  ColorDetection({
    required this.currentKey,
    required this.stateController,
    required this.paintKey,
  });
  final GlobalKey? currentKey;
  final StreamController<Color>? stateController;
  final GlobalKey? paintKey;

  img.Image? photo;

  Future<dynamic> searchPixel(Offset globalPosition) async {
    if (photo == null) {
      await loadSnapshotBytes();
    }
    return _calculatePixel(globalPosition);
  }

  ui.Color _calculatePixel(Offset globalPosition) {
    final RenderBox box = currentKey!.currentContext!.findRenderObject() as RenderBox;
    final Offset localPosition = box.globalToLocal(globalPosition);

    final double px = localPosition.dx;
    final double py = localPosition.dy;

    // int pixel32 = photo!.getPixelSafe(px.toInt(), py.toInt());
    // int hex = abgrToArgb(pixel32);
    // stateController!.add(Color(hex));
    // return Color(hex);

    final img.Pixel pixel32 = photo!.getPixelSafe(px.toInt(), py.toInt());
    final Color hex = Color.fromARGB(pixel32.a.toInt(), pixel32.r.toInt(),
        pixel32.g.toInt(), pixel32.b.toInt(),);
    stateController!.add(hex);

    return hex;
  }

  Future<void> loadSnapshotBytes() async {
    final RenderRepaintBoundary? boxPaint =
        paintKey!.currentContext!.findRenderObject() as RenderRepaintBoundary?;
    final ui.Image capture = await boxPaint!.toImage();
    final ByteData? imageBytes =
        await capture.toByteData(format: ui.ImageByteFormat.png);
    setImageBytes(imageBytes!);
    capture.dispose();
  }

  void setImageBytes(ByteData imageBytes) {
    final Uint8List values = imageBytes.buffer.asUint8List();
    photo = null;
    photo = img.decodeImage(values);
  }
}

// image lib uses uses KML color format, convert #AABBGGRR to regular #AARRGGBB
int abgrToArgb(int argbColor) {
  final int r = (argbColor >> 16) & 0xFF;
  final int b = argbColor & 0xFF;
  return (argbColor & 0xFF00FF00) | (b << 16) | r;
}
