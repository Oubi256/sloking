import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sloking/constants.dart';

class FakeProgressBar extends StatelessWidget {
  final Animation<double> animation;
  const FakeProgressBar({super.key, required this.animation});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constrains) {
      return Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: Constants.wheelWinTextColor, strokeAlign: BorderSide.strokeAlignOutside),
          borderRadius: BorderRadius.circular(8),
        ),
        child: AnimatedBuilder(
          animation: animation,
          builder: (_, __) {
            return Stack(
              alignment: Alignment.center,
              children: [
                LinearProgressIndicator(
                  minHeight: constrains.maxHeight,
                  borderRadius: BorderRadius.circular(8),
                  color: Color(0xFFc90054),
                  value: animation.value,
                  backgroundColor: Color(0xFF680026),
                ),
                Text(
                  "${(animation.value * 100).ceil()}%",
                  style: Constants.buttonTextStyle.copyWith(color: Colors.white),
                ),
              ],
            );
          },
        ),
      );
    });
  }
}
