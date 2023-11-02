import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flip_card/flipcard/flip_card.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import 'package:flutter_flip_card/modal/flip_side.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sloking/game_cards.dart';
import 'package:sloking/models/game_card.dart';
import 'package:sloking/widgets/gems/gem_counter.dart';
import 'package:sloking/widgets/general/page_wrapper.dart';

import '../constants.dart';
import '../generated/l10n.dart';
import '../widgets/general/convex_text_button.dart';

class RulesPage extends StatelessWidget {
  const RulesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final gameCard = GameCard.plum();
    final FlipCardController controller = FlipCardController();
    return PageWrapper(
      children: [
        Positioned(top: 83.h, child: Text(S.of(context).menuRules.toUpperCase(), style: Constants.headerTextStyle)),
        Positioned(
            top: 164.h,
            bottom: 507.h,
            left: 27.w,
            right: 27.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.of(context).rulesCards,
                  style: Constants.descriptionTextStyle,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 70.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FlipCard(
                        axis: FlipAxis.vertical,
                        frontWidget: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset(gameCard.type.faceAssetName),
                            Padding(
                              padding: EdgeInsets.all(10.r),
                              child: Image.asset(gameCard.type.iconAssetName),
                            ),
                          ],
                        ),
                        backWidget: Image.asset(gameCard.type.backAssetName),
                        controller: controller,
                        rotateSide: RotateSide.left,
                      ),
                      FlipCard(
                        axis: FlipAxis.vertical,
                        frontWidget: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset(gameCard.type.faceAssetName),
                            Padding(
                              padding: EdgeInsets.all(10.r),
                              child: Image.asset(gameCard.type.iconAssetName),
                            ),
                          ],
                        ),
                        backWidget: Image.asset(gameCard.type.backAssetName),
                        controller: controller,
                        rotateSide: RotateSide.left,
                      )
                    ],
                  ),
                ),
              ],
            )),

        Positioned(
            top: 356.h,
            bottom: 385.h,
            left: 27.w,
            right: 27.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.of(context).rulesGems,
                  style: Constants.descriptionTextStyle,
                  textAlign: TextAlign.center,
                ),
                GemCounter(initialNumber: 25,),
              ],
            )),
        Positioned(
            top: 500.h,
            bottom: 182.h,
            left: 27.w,
            right: 27.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.of(context).rulesHealth,
                  style: Constants.descriptionTextStyle,
                  textAlign: TextAlign.center,
                ),
                Container(
                  height: 43.r,
                  width: 116.r,
                  decoration: BoxDecoration(color: Colors.black38, borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset("assets/images/icons/heart.png", fit: BoxFit.contain, height: 26.r,),
                      Image.asset("assets/images/icons/heart.png", fit: BoxFit.contain, height: 26.r,),
                      Image.asset("assets/images/icons/heart.png", fit: BoxFit.contain, height: 26.r,),
                    ],
                  ),
                ),
              ],
            )),
        Positioned(
          bottom: 64.h,
          left: 75.w,
          right: 75.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: Constants.defaultPadding),
              ConvexTextButton(label: S.of(context).backToMenu, onPressed: () => context.go("/home")),
            ],
          ),
        ),
      ],
    );
  }
}
