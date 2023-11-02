import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sloking/bloc/game_progress_bloc/game_progress_bloc.dart';
import 'package:sloking/constants.dart';
import 'package:sloking/enums/game_card_state_enum.dart';
import 'package:sloking/extensions/game_field_extension.dart';

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
  final Duration _animationDuration = Duration(milliseconds: 500);

  @override
  void initState() {
    final GameLevelProgress gameLevelProgress = context.read<GameProgressBloc>().state.gameLevelProgress;
    _generateCardControllers(gameLevelProgress);
    WidgetsBinding.instance.addPostFrameCallback((_) => _continueGame(gameLevelProgress));
    super.initState();
  }

  bool _canFlipCard(int index) {
    return openedCardIndexes.contains(index);
  }

  void _onTapCard(int cardIndex) async {
    if (_canFlipCard(cardIndex)) return;
    if (openedCardIndexes.length >= 2) return;
    if (isAnimationInProgress.value) return;
    context.read<GameProgressBloc>().add(ChangeCardStateProgressEvent(cardIndex: cardIndex, newCardState: GameCardState.open));
  }

  void _generateCardControllers(GameLevelProgress gameLevelProgress) {
    cardControllers = List.generate(gameLevelProgress.gameField.length, (index) => FlipCardController());
  }

  void _continueGame(GameLevelProgress gameLevelProgress) {
    _updateIndexes(gameLevelProgress);
    for (int i = 0; i < gameLevelProgress.gameField.length; i++) {
      if (gameLevelProgress.gameField[i].state == GameCardState.open) {
        cardControllers[i]?.flipcard();
      }
    }
  }

  List<int> openedCardIndexes = [];
  List<int> closedCardIndexes = [];
  List<int> hidedCardIndexes = [];

  ValueNotifier<bool> isAnimationInProgress = ValueNotifier(false);

  void _updateIndexes(GameLevelProgress gameLevelProgress) {
    openedCardIndexes = gameLevelProgress.gameField.indexByState(GameCardState.open);
    closedCardIndexes = gameLevelProgress.gameField.indexByState(GameCardState.closed);
    hidedCardIndexes = gameLevelProgress.gameField.indexByState(GameCardState.hidden);
  }

  void _onComparedSuccessful() {
  }
  void _onComparedFailure() {}


  void _gameLoop(GameLevelProgress gameLevelProgress) async {
    _updateIndexes(gameLevelProgress);
    //print("o: ${openedCardIndexes.length} | c: ${closedCardIndexes.length} | h:${hidedCardIndexes.length}");

    // card opening handler
    for (int openedCardIndex in openedCardIndexes) {
      if (cardControllers[openedCardIndex]!.state!.isFront) {
        cardControllers[openedCardIndex]?.flipcard();
      }
    }

    // card closing handler
    isAnimationInProgress.value = true;
    Future.delayed(_animationDuration, () {
      for (int openedCardIndex in closedCardIndexes) {
        if (!cardControllers[openedCardIndex]!.state!.isFront) {
          cardControllers[openedCardIndex]?.flipcard();
        }
      }
      isAnimationInProgress.value = false;
    });

    // card comparing handler
    if (openedCardIndexes.length == 2) {
      if (gameLevelProgress.gameField[openedCardIndexes.first].type == gameLevelProgress.gameField[openedCardIndexes.last].type) {
        isAnimationInProgress.value = true;
        _onComparedSuccessful();
        Future.delayed(_animationDuration, () {
          context.read<GameProgressBloc>().add(ChangeCardStateProgressEvent(cardIndex: openedCardIndexes.first, newCardState: GameCardState.hidden));
          context.read<GameProgressBloc>().add(ChangeCardStateProgressEvent(cardIndex: openedCardIndexes.last, newCardState: GameCardState.hidden));
          isAnimationInProgress.value = false;
        });
      } else {
        isAnimationInProgress.value = true;
        _onComparedFailure();
        Future.delayed(_animationDuration, () {
          context.read<GameProgressBloc>().add(ChangeCardStateProgressEvent(cardIndex: openedCardIndexes.first, newCardState: GameCardState.closed));
          context.read<GameProgressBloc>().add(ChangeCardStateProgressEvent(cardIndex: openedCardIndexes.last, newCardState: GameCardState.closed));
          isAnimationInProgress.value = false;
        });

      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GameProgressBloc, GameProgressState>(
      listener: (context, state) {
        _gameLoop(state.gameLevelProgress);
      },
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
                        return AnimatedCrossFade(
                          firstChild: GestureDetector(
                            onTap: () => _onTapCard(index),
                            child: FlipCard(
                              animationDuration: _animationDuration,
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
                          ),
                          secondChild: SizedBox(),
                          crossFadeState: state.gameLevelProgress.gameField[index].state != GameCardState.hidden ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                          duration: _animationDuration,
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
