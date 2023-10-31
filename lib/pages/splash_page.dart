import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.black,
          child: Image.asset(
            "assets/images/card/icons/slots_01.png",
            width: 300,
            height: 300,
            fit: BoxFit.fill,
            filterQuality: FilterQuality.low,
          ),
        ),
      ),
    );
  }
}
