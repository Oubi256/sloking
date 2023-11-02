import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sloking/bloc/game_progress_bloc/game_progress_bloc.dart';
import 'package:sloking/constants.dart';
import 'package:sloking/enums/game_card_state_enum.dart';

import 'package:sloking/models/game_level_progress.dart';
import 'package:sloking/widgets/gems/gem_counter.dart';
import 'package:sloking/widgets/general/page_wrapper.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late List<FlipCardController?> cardControllers;

  @override
  void initState() {
    final GameLevelProgress gameLevelProgress = context.read<GameProgressBloc>().state.gameLevelProgress;
    _generateCardControllers(gameLevelProgress);
    WidgetsBinding.instance.addPostFrameCallback((_) => _continueGame(gameLevelProgress));
    super.initState();
  }

  void _onTapCard(int cardIndex) async {
    //print("TAP: $cardIndex | $isFront | ${gameLevelProgress.gameField[cardIndex]}");
    bool isFront = !(cardControllers[cardIndex]!.state!.isFront);
    context.read<GameProgressBloc>().add(FlipCardProgressEvent(cardIndex: cardIndex));
    await cardControllers[cardIndex]?.flipcard();
  }

  void _generateCardControllers(GameLevelProgress gameLevelProgress) {
    cardControllers = List.generate(gameLevelProgress.gameField.length, (index) => FlipCardController());
  }

  void _continueGame(GameLevelProgress gameLevelProgress) {
    for (int i = 0; i < gameLevelProgress.gameField.length; i++) {
      if (gameLevelProgress.gameField[i].state == GameCardState.open) {
        cardControllers[i]?.flipcard();
      }
    }
  }

  @override
  void didUpdateWidget(covariant GamePage oldWidget) {
    print("UPDATE");
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
                        crossAxisCount: state.gameLevelProgress.gameLevel.column,
                        childAspectRatio: 2 / 2.5,
                        mainAxisSpacing: Constants.smallPadding,
                        crossAxisSpacing: Constants.smallPadding,
                      ),
                      itemCount: state.gameLevelProgress.gameLevel.itemsCount,
                      itemBuilder: (_, index) {
                        return Center(
                          child: state.gameLevelProgress.gameField[index].state != GameCardState.hidden
                              ? GestureDetector(
                                  onTap: () => _onTapCard(index),
                                  child: FlipCard(
                                    axis: FlipAxis.vertical,
                                    backWidget: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Image.asset(state.gameLevelProgress.gameField[index].type.faceAssetName),
                                        Padding(
                                          padding: EdgeInsets.all(10.r),
                                          child: Image.asset(state.gameLevelProgress.gameField[index].type.iconAssetName),
                                        ),
                                      ],
                                    ),
                                    frontWidget: Image.asset(state.gameLevelProgress.gameField[index].type.backAssetName),
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
