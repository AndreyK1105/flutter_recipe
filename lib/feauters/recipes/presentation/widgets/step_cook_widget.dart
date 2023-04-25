import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_recipe/feauters/recipes/presentation/bloc/steps_widget_cubit/steps_widget_cubit.dart';
import 'package:flutter_recipe/feauters/recipes/presentation/bloc/steps_widget_cubit/steps_widget_state.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/recipe.dart';

class StepCookWidget extends StatefulWidget {
  final Recipe recipe;

  const StepCookWidget({required this.recipe, super.key});
  @override
  State<StatefulWidget> createState() => _StepCookWidgetState();
}

class _StepCookWidgetState extends State<StepCookWidget> {
  List<bool> listCheckboxOn = [];
  Duration myDuration = const Duration(seconds: 0);
  int timeCookingSec = 0;
  int curentStep = 0;
  List<int> timeStepList = [];

  bool cookingProcess = false;

  Timer? countdownTimer;

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < widget.recipe.cook.length; i++) {
      timeCookingSec = timeCookingSec + widget.recipe.cook[i].timeStepSec;
    }
    myDuration = Duration(seconds: timeCookingSec);
  }

  @override
  void deactivate() {
    context.read<StepsWidgetCobit>().stopSteps();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    // if (context.watch<StepsWidgetCobit>().state is StepsWidgetStateCooking) {
    //   cookingProcess = true;
    // } else {
    //   cookingProcess = false;
    // }

    return Column(children: [
      const Align(
          alignment: Alignment.bottomLeft,
          child: Text('Шаги приготовления',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF165932)))),
      const SizedBox(
        height: 20,
      ),
      Column(
          children: List<Widget>.generate(widget.recipe.cook.length, (index) {
        var state = context.read<StepsWidgetCobit>().state;
        bool checkboxOn = false;

        if (state is StepsWidgetStateCooking) {
          timeCookingSec = state.timeStepList[index];
          checkboxOn = state.checkboxOn[index];
          curentStep = state.curentStep;
          timeStepList = state.timeStepList;
          listCheckboxOn = state.checkboxOn;
        }
        return Column(
          children: [
            Container(
                constraints: const BoxConstraints(
                  minHeight: 120,
                ),
                width: 398, //height: 120,
                decoration: BoxDecoration(
                    color: cookingProcess
                        ? const Color.fromRGBO(46, 204, 113, 0.15)
                        : const Color.fromRGBO(236, 236, 236, 1),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 24,
                      ),
                      Text(
                        (index + 1).toString(),
                        style: TextStyle(
                            color: cookingProcess
                                ? const Color.fromRGBO(46, 204, 113, 1)
                                : const Color(0xFFC2C2C2),
                            fontSize: 40,
                            fontWeight: FontWeight.w900),
                      ),
                      const SizedBox(
                        width: 29,
                      ),
                      Expanded(
                          child: Text(
                        widget.recipe.cook[index].step.toString(),
                        style: const TextStyle(
                            color: Color(0xFF797676),
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      )),
                      const SizedBox(
                        width: 22,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          cookingProcess
                              ? MyCheckBox(
                                  index: index,
                                  curentStep: curentStep,
                                  checkboxOn: checkboxOn,
                                  listCheckboxOn: listCheckboxOn,
                                  timeStepList: timeStepList,
                                  cook: widget.recipe.cook,
                                )
                              //  Checkbox(
                              //     value: checkboxOn,
                              //     onChanged: curentStep == index
                              //         ? (bool? newValue) {
                              //             context
                              //                 .read<StepsWidgetCobit>()
                              //                 .stepEnd(
                              //                     curentStep,
                              //                     listCheckboxOn,
                              //                     timeStepList,
                              //                     recipe.cook);
                              //           }
                              //         : null,
                              //   )
                              : const SizedBox(
                                  height: 20,
                                ),
                          TimeStepWidget(
                            index: index,
                            recipe: widget.recipe,
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 22,
                      ),
                    ],
                  ),
                )),
            const SizedBox(
              height: 14,
            ),
          ],
        );
      })),
      const SizedBox(
        height: 20,
      ),
      InkWell(
        splashColor: Colors.amber,
        onTap: () {
          if (!cookingProcess) {
            cookingProcess = true;
            context.read<StepsWidgetCobit>().startCoocking(widget.recipe.cook);
            setState(() {});
            //context.o
          } else {
            cookingProcess = false;
            context.read<StepsWidgetCobit>().stopSteps();
            setState(() {});
          }
        },
        child: Container(
          width: 232,
          height: 48,
          decoration: BoxDecoration(
              color: const Color(0xFF165932),
              borderRadius: BorderRadius.circular(24)),
          child: Center(
              child: context.read<StepsWidgetCobit>().state
                      is StepsWidgetStateCooking
                  ? const Text('Закончить готовить',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ))
                  : const Text('Начать готовить',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ))),
        ),
      ),
    ]);
  }
}

class MyCheckBox extends StatefulWidget {
  const MyCheckBox(
      {required this.index,
      required this.curentStep,
      required this.checkboxOn,
      required this.listCheckboxOn,
      required this.timeStepList,
      required this.cook,
      super.key});
  final int index;
  final int curentStep;
  final bool checkboxOn;
  final List<bool> listCheckboxOn;
  final List<int> timeStepList;
  final List<Cook> cook;
  @override
  State<MyCheckBox> createState() => _MyCheckBoxState();
}

class _MyCheckBoxState extends State<MyCheckBox>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  late bool checkboxOn;
  late int curentStep;
  @override
  void initState() {
    super.initState();
    curentStep = widget.curentStep;
    checkboxOn = widget.checkboxOn;
    bool controllerForward = true;
    controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    animation = Tween<double>(begin: 1, end: 1.5).animate(controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed && controllerForward == true) {
          controllerForward = false;
          controller.reverse();
        }
        // else if (status == AnimationStatus.forward) {
        //   controller.stop();
        // }
      });
    // controller.isCompleted ? controller.reverse() : null;
    // controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  // double _size = 1.0;
  // bool _large = false;

  // void _updateSize() {
  //   _size = _large ? 1.0 : 1.5;
  //   _large = !_large;
  // }

  @override
  Widget build(BuildContext context) {
    return BlocListener<StepsWidgetCobit, StepsWidgetState>(
      listener: (context, state) {
        if (state is StepsWidgetStateCooking) {
          if (curentStep != state.curentStep) {
            curentStep = state.curentStep;
          }

          if (state.checkboxOn[widget.index]) {
            checkboxOn = true;
            setState(() {
              //controller.forward();
            });
          }
        }
      },
      child: Transform.scale(
          scale: animation.value,
          child: Checkbox(
              value: checkboxOn,
              onChanged: (bool? newValue) {
                if (curentStep == widget.index) {
                  // print('curentStep $curentStep === index ${widget.index}');
                  checkboxOn = true;
                  setState(() {
                    controller.forward();
                    context.read<StepsWidgetCobit>().stepEnd(
                        curentStep,
                        widget.listCheckboxOn,
                        widget.timeStepList,
                        widget.cook);
                  });
                }
              })),
    );
  }
}

class TimeStepWidget extends StatelessWidget {
  final int index;
  final Recipe recipe;

  const TimeStepWidget({required this.index, required this.recipe, super.key});

  @override
  Widget build(BuildContext context) {
    var state = context.watch<StepsWidgetCobit>().state;
    return Text(
      DateFormat.ms().format(DateTime(
          0,
          0,
          0,
          0,
          0,
          state is StepsWidgetStateCooking
              ? state.timeStepList[index]
              : recipe.cook[index].timeStepSec)),
      style: const TextStyle(
          color: Color(0xFF797676), fontSize: 13, fontWeight: FontWeight.w700),
    );
  }
}
