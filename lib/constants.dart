
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class Constants {
  static const Color bgColor = Color(0xFFAE003F);
  static const Color wheelWinTextColor = Color(0xFFFFEC3F);

  static double buttonsHeight = 58.h;

  static double defaultPadding = 20.r;
  static double smallPadding = 16.r;

  static TextStyle buttonTextStyle = TextStyle(fontFamily: "Montserrat", fontWeight: FontWeight.w800, fontSize: 20.r);
  static TextStyle headerTextStyle = TextStyle(fontFamily: "Montserrat", fontWeight: FontWeight.w800, fontSize: 30.r, color: Colors.white);
  static TextStyle addGemsHintOutlineTextStyle = TextStyle(fontFamily: "Montserrat", fontWeight: FontWeight.w800, fontSize: 32.r, color: Colors.white, shadows: [
    Shadow(color: Colors.black, blurRadius: 2, offset: Offset(0, 3)),
    Shadow(color: Colors.black, blurRadius: 2, offset: Offset(0, -3)),
    Shadow(color: Colors.black, blurRadius: 2, offset: Offset(3, 0)),
    Shadow(color: Colors.black, blurRadius: 2, offset: Offset(-3, 0)),
  ]);
  static TextStyle descriptionTextStyle = TextStyle(fontFamily: "Montserrat", fontWeight: FontWeight.w600, fontSize: 18.r, color: Colors.white);
}