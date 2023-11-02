import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sloking/bloc/game_progress_bloc/game_progress_bloc.dart';
import 'package:sloking/constants.dart';
import 'package:sloking/enums/game_card_state.dart';
import 'package:sloking/extensions/game_field_extension.dart';
import 'package:sloking/generated/l10n.dart';

import 'package:sloking/models/game_level_progress.dart';
import 'package:sloking/widgets/dialogs/defeat_game_dialog.dart';
import 'package:sloking/widgets/dialogs/win_game_dialog.dart';
import 'package:sloking/widgets/gems/gem_counter.dart';
import 'package:sloking/widgets/general/page_wrapper.dart';
import 'package:stroke_text/stroke_text.dart';

import '../widgets/health/health_bar.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> with SingleTickerProviderStateMixin {
  late List<FlipCardController?> cardControllers;
  final Duration _animationDuration = Duration(milliseconds: 500);
  late final AnimationController hintAnimationController = AnimationController(vsync: this, duration: _animationDuration*2);

  final Tween<double> firstOpacityHalfTween = Tween(begin: 0, end: 1);
  final Tween<double> secondOpacityHalfTween = Tween(begin: 1, end: 1);
  final Tween<double> thirdOpacityHalfTween = Tween(begin: 1, end: 0);

  late final Animation<double> hintOpacityAnimation = TweenSequence<double>([
    TweenSequenceItem(tween: firstOpacityHalfTween, weight: 0.05),
    TweenSequenceItem(tween: secondOpacityHalfTween, weight: 0.4),
    TweenSequenceItem(tween: thirdOpacityHalfTween, weight: 0.3),
  ]).animate(hintAnimationController);

  late final Animation<Offset> hintOffsetAnimation = Tween<Offset>(
    begin: Offset(0, -10),
    end: Offset(0, 0),
  ).animate(CurvedAnimation(
    parent: hintAnimationController,
    curve: Curves.ease,
  ));

  @override
  void initState() {
    final GameLevelProgress gameLevelProgress = context.read<GameProgressBloc>().state.gameLevelProgress;
    _generateCardControllers(gameLevelProgress);
    WidgetsBinding.instance.addPostFrameCallback((_) => _continueGame(gameLevelProgress));
    super.initState();
  }

  @override
  void dispose() {
    hintAnimationController.dispose();
    super.dispose();
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
    context.read<GameProgressBloc>().add(AddGemsProgressEvent());
    hintAnimationController.forward(from: 0);
  }

  void _onComparedFailure() {
    context.read<GameProgressBloc>().add(HealthHitProgressEvent());
  }

  void _gameLoop(GameLevelProgress gameLevelProgress, int gemCount) async {
    _updateIndexes(gameLevelProgress);
    //print("o: ${openedCardIndexes.length} | c: ${closedCardIndexes.length} | h:${hidedCardIndexes.length}");

    if(gameLevelProgress.healthCount == 0) {
      _onDefeatGame(gemCount);
    }

    if(openedCardIndexes.isEmpty && closedCardIndexes.isEmpty) {
      Future.delayed(_animationDuration, () {
        _onWinGame(gemCount, gameLevelProgress.healthCount);
      });
    }

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
        Future.delayed(_animationDuration, () {
          context.read<GameProgressBloc>().add(ChangeCardStateProgressEvent(cardIndex: openedCardIndexes.first, newCardState: GameCardState.hidden));
          context.read<GameProgressBloc>().add(ChangeCardStateProgressEvent(cardIndex: openedCardIndexes.last, newCardState: GameCardState.hidden));
          _onComparedSuccessful();
          isAnimationInProgress.value = false;
        });
      } else {
        isAnimationInProgress.value = true;
        Future.delayed(_animationDuration, () {
          context.read<GameProgressBloc>().add(ChangeCardStateProgressEvent(cardIndex: openedCardIndexes.first, newCardState: GameCardState.closed));
          context.read<GameProgressBloc>().add(ChangeCardStateProgressEvent(cardIndex: openedCardIndexes.last, newCardState: GameCardState.closed));
          _onComparedFailure();
          isAnimationInProgress.value = false;
        });
      }
    }
  }

  void _onDefeatGame(int gemCount) {
    showDialog(
        barrierDismissible: false,
        barrierColor: Colors.transparent,
        context: context,
        builder: (context) {
          return DefeatGameDialog(gemCount: gemCount);
        });
  }

  void _onWinGame(int gemCount, int healthCount) {
    showDialog(
        barrierDismissible: false,
        barrierColor: Colors.transparent,
        context: context,
        builder: (context) {
          return WinGameDialog(gemCount: gemCount, healthCount: healthCount,);
        });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GameProgressBloc, GameProgressState>(
      listener: (context, state) {
        _gameLoop(state.gameLevelProgress, state.gemCount);
      },
      builder: (context, state) {
        return PageWrapper(
          backgroundImage: Image.asset(
            "assets/images/backgrounds/background_01.png",
            fit: BoxFit.cover,
            alignment: Alignment(0.4, 0),
          ),
          children: [
            Positioned(
              top: 110.h,
              left: Constants.smallPadding,
              right: Constants.smallPadding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GemCounter(
                    value: state.gemCount,
                  ),
                  HealthBar(value: state.gameLevelProgress.healthCount),
                ],
              ),
            ),
            Positioned(
                top: 183.h,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    AnimatedBuilder(
                        animation: hintAnimationController,
                        child: Text(
                          S.of(context).addGemsHint(state.gameLevelProgress.gameLevel.combinationReward),
                          style: Constants.addGemsHintOutlineTextStyle,
                        ),
                        builder: (_, child) {
                          return Transform.translate(
                            offset: hintOffsetAnimation.value,
                            child: Opacity(
                              opacity: hintOpacityAnimation.value,
                              child: child,
                            ),
                          );
                        })
                  ],
                )),
            Positioned(
                top: 265.h,
                left: Constants.smallPadding,
                right: Constants.smallPadding,
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
                ))
          ],
        );
      },
    );
  }
}
