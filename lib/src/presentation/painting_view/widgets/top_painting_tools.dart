import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:vs_story_designer/src/domain/providers/notifiers/control_provider.dart';
import 'package:vs_story_designer/src/domain/providers/notifiers/painting_notifier.dart';
import 'package:vs_story_designer/src/presentation/utils/constants/app_enums.dart';
import 'package:vs_story_designer/src/presentation/widgets/tool_button.dart';

class TopPaintingTools extends StatefulWidget {
  const TopPaintingTools({Key? key}) : super(key: key);

  @override
  _TopPaintingToolsState createState() => _TopPaintingToolsState();
}

class _TopPaintingToolsState extends State<TopPaintingTools> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<ControlNotifier, PaintingNotifier>(
      builder: (context, controlNotifier, paintingNotifier, child) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
          child: Container(
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /// remove last line
                    if (paintingNotifier.lines.isNotEmpty)
                      ToolButton(
                        onTap: paintingNotifier.removeLast,
                        onLongPress: paintingNotifier.clearAll,
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        backGroundColor: Colors.black12,
                        child: Transform.scale(
                            scale: 0.6,
                            child: const ImageIcon(
                              AssetImage('assets/icons/return.png',
                                  package: 'vs_story_designer'),
                              color: Colors.white,
                            )),
                      ),

                    /// select pen
                    ToolButton(
                      onTap: () {
                        paintingNotifier.paintingType = PaintingType.pen;
                      },
                      colorBorder:
                          paintingNotifier.paintingType == PaintingType.pen
                              ? Colors.black
                              : Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      backGroundColor:
                          paintingNotifier.paintingType == PaintingType.pen
                              ? Colors.white.withOpacity(0.9)
                              : Colors.black12,
                      child: Transform.scale(
                          scale: 1.2,
                          child: ImageIcon(
                            const AssetImage('assets/icons/pen.png',
                                package: 'vs_story_designer'),
                            color: paintingNotifier.paintingType ==
                                    PaintingType.pen
                                ? Colors.black
                                : Colors.white,
                          )),
                    ),

                    /// select marker
                    ToolButton(
                      onTap: () {
                        paintingNotifier.paintingType = PaintingType.marker;
                      },
                      colorBorder:
                          paintingNotifier.paintingType == PaintingType.marker
                              ? Colors.black
                              : Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      backGroundColor:
                          paintingNotifier.paintingType == PaintingType.marker
                              ? Colors.white.withOpacity(0.9)
                              : Colors.black12,
                      child: Transform.scale(
                          scale: 1.2,
                          child: ImageIcon(
                            const AssetImage('assets/icons/marker.png',
                                package: 'vs_story_designer'),
                            color: paintingNotifier.paintingType ==
                                    PaintingType.marker
                                ? Colors.black
                                : Colors.white,
                          )),
                    ),

                    /// select neon marker
                    ToolButton(
                      onTap: () {
                        paintingNotifier.paintingType = PaintingType.neon;
                      },
                      colorBorder:
                          paintingNotifier.paintingType == PaintingType.neon
                              ? Colors.black
                              : Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      backGroundColor:
                          paintingNotifier.paintingType == PaintingType.neon
                              ? Colors.white.withOpacity(0.9)
                              : Colors.black12,
                      child: Transform.scale(
                          scale: 1.1,
                          child: ImageIcon(
                            const AssetImage('assets/icons/neon.png',
                                package: 'vs_story_designer'),
                            color: paintingNotifier.paintingType ==
                                    PaintingType.neon
                                ? Colors.black
                                : Colors.white,
                          )),
                    ),

                    /// done button
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    controlNotifier.isPainting = !controlNotifier.isPainting;
                    paintingNotifier.resetDefaults();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10, top: 10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 12),
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(color: Colors.white, width: 1.5),
                          borderRadius: BorderRadius.circular(15)),
                      child: const Text(
                        'Done',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                // ToolButton(
                //   onTap: () {
                //     controlNotifier.isPainting = !controlNotifier.isPainting;
                //     paintingNotifier.resetDefaults();
                //   },
                //   padding: const EdgeInsets.symmetric(horizontal: 5),
                //   backGroundColor: Colors.black12,
                //   child: Transform.scale(
                //       scale: 0.7,
                //       child: const ImageIcon(
                //         AssetImage('assets/icons/check.png',
                //             package: 'vs_story_designer'),
                //         color: Colors.white,
                //       )),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}
