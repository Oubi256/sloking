import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flip_card/flipcard/gesture_flip_card.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sloking/bloc/game_progress_bloc/game_progress_bloc.dart';
import 'package:sloking/constants.dart';
import 'package:sloking/enums/game_card_state_enum.dart';

import 'package:sloking/models/game_level.dart';
import 'package:sloking/models/game_level_progress.dart';
import 'package:sloking/widgets/gems/gem_counter.dart';
import 'package:sloking/widgets/general/page_wrapper.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late GameLevelProgress gameLevelProgress;
  late List<FlipCardController?> cardControllers;

  @override
  void initState() {
    gameLevelProgress = GameLevelProgress.startGame(gameLevel: GameLevel(row: 2, column: 3, backgroundImage: Image.asset(""), combinationReward: 10, minUniqueCards: 5));

    print("gameLevelProgress: ${gameLevelProgress.gameField}");
    cardControllers = List.generate(gameLevelProgress.gameField.length, (index) => FlipCardController());
    print("cardControllers: ${cardControllers.map((e) => e?.state?.isFront)}");

    super.initState();
  }

  void _onTapCard(int cardIndex) async {
    bool isFront = !(cardControllers[cardIndex]!.state!.isFront);
    print("TAP: $cardIndex | $isFront | ${gameLevelProgress.gameField[cardIndex]}");
    await cardControllers[cardIndex]?.flipcard();
  }

  @override
  void didUpdateWidget(covariant GamePage oldWidget) {
    /*
    for (int i = 0; i < cardControllers.length; i++) {
      if (cardControllers[i] == null) continue;
      cardControllers[i]?.state?.filpCard();
    }
     */

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameProgressBloc, GameProgressState>(
      builder: (context, state) {
        return PageWrapper(
          backgroundImage: Image.asset(
            "assets/images/backgrounds/background_01.png",
            fit: BoxFit.cover,
            alignment: Alignment(0.4, 0),
          ),
          child: Column(
            children: [
              GemCounter(),
              Flexible(
                child: Padding(
                  padding: EdgeInsets.all(Constants.smallPadding),
                  child: Center(
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: gameLevelProgress.gameLevel.column,
                        childAspectRatio: 2 / 2.5,
                        mainAxisSpacing: Constants.smallPadding,
                        crossAxisSpacing: Constants.smallPadding,
                      ),
                      itemCount: gameLevelProgress.gameLevel.itemsCount,
                      itemBuilder: (_, index) {
                        return Center(
                          child: gameLevelProgress.gameField[index].state != GameCardState.hidden
                              ? GestureDetector(
                                  onTap: () => _onTapCard(index),
                                  child: FlipCard(
                                    axis: FlipAxis.vertical,
                                    backWidget: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Image.asset(gameLevelProgress.gameField[index].faceAssetName),
                                        Padding(
                                          padding: EdgeInsets.all(10.r),
                                          child: Image.asset(gameLevelProgress.gameField[index].iconAssetName),
                                        ),
                                      ],
                                    ),
                                    frontWidget: Image.asset(gameLevelProgress.gameField[index].backAssetName),
                                    controller: cardControllers[index]!,
                                    rotateSide: RotateSide.left,
                                  ),
                                )
                              : SizedBox(),
                        );
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
