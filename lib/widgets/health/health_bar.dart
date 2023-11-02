import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HealthBar extends StatefulWidget {
  final int value;

  const HealthBar({super.key, required this.value});

  @override
  State<HealthBar> createState() => _HealthBarState();
}

class _HealthBarState extends State<HealthBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 43.r,
      width: 116.r,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset("assets/images/icons/heart.png", fit: BoxFit.contain, height: 26.r,),
          Image.asset("assets/images/icons/heart.png", fit: BoxFit.contain, height: 26.r,),
          Image.asset("assets/images/icons/heart.png", fit: BoxFit.contain, height: 26.r,),
        ],
      ),
    );
  }
}
