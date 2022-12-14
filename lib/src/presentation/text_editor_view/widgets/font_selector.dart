import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:vs_story_designer/src/domain/providers/notifiers/control_provider.dart';
import 'package:vs_story_designer/src/domain/providers/notifiers/text_editing_notifier.dart';
import 'package:vs_story_designer/src/presentation/utils/constants/font_family.dart';
import 'package:vs_story_designer/src/presentation/widgets/animated_onTap_button.dart';

class FontSelector extends StatelessWidget {
  const FontSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScreenUtil screenUtil = ScreenUtil();
    return Consumer2<TextEditingNotifier, ControlNotifier>(
      builder: (context, editorNotifier, controlNotifier, child) {
        return Container(
          height: screenUtil.screenWidth * 0.22,
          width: screenUtil.screenWidth,
          alignment: Alignment.center,
          child: PageView.builder(
            controller: editorNotifier.fontFamilyController,
            itemCount: controlNotifier.fontList!.length,
            onPageChanged: (index) {
              editorNotifier.fontFamilyIndex = index;
              HapticFeedback.heavyImpact();
            },
            physics: const BouncingScrollPhysics(),
            allowImplicitScrolling: true,
            pageSnapping: false,
            itemBuilder: (context, index) {
              return AnimatedOnTapButton(
                onTap: () {
                  editorNotifier.fontFamilyIndex = index;
                  editorNotifier.fontFamilyController.jumpToPage(index);
                },
                child: Container(
                  height: screenUtil.screenWidth * 0.1,
                  width: screenUtil.screenWidth * 0.1,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: index == editorNotifier.fontFamilyIndex
                          ? Colors.white
                          : Colors.black.withOpacity(0.4),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white)),
                  child: Center(
                    child: Text(
                      'Aa',
                      style: AppFonts.getTextTheme(
                              controlNotifier.fontList![index])
                          .bodyText1!
                          .merge(TextStyle(
                              // fontFamily: controlNotifier.fontList![index],
                              // package: controlNotifier.isCustomFontList
                              //     ? null
                              //     : 'vs_story_designer'
                              ))
                          .copyWith(
                              color: index == editorNotifier.fontFamilyIndex
                                  ? Colors.red
                                  : Colors.white,
                              fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
