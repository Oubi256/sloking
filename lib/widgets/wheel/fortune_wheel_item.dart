import 'package:flutter/cupertino.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sloking/constants.dart';

class FortuneWheelItem extends FortuneItem {
  final int gemsReward;

  const FortuneWheelItem._(this.gemsReward, {required super.child});

  FortuneWheelItem.win({required this.gemsReward})
      : super(
          child: Container(
            alignment: Alignment.centerRight,
            width: double.infinity,
            padding: EdgeInsets.only(right: 40.r),
            child: Text(
              '+$gemsReward',
            ),
          ),
          style: FortuneItemStyle(
            borderColor: Color(0xFF76470D),
            borderWidth: 1,
            color: Color(0xFFFF004B),
            textStyle: Constants.buttonTextStyle.copyWith(fontSize: 13.r),
          ),
        );

  FortuneWheelItem.defeat({required String label})
      : gemsReward = 0,
        super(
          child: Container(
            alignment: Alignment.centerRight,
            width: double.infinity,
            padding: EdgeInsets.only(right: 40.r),
            child: Text(label.toUpperCase()),
          ),
          style: FortuneItemStyle(
            borderColor: Color(0xFF76470D),
            borderWidth: 1,
            color: Color(0xFFD20032),
            textStyle: Constants.buttonTextStyle.copyWith(fontSize: 9.r),
          ),
        );

  bool get isWin => gemsReward > 0;
}
