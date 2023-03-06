import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_recipe/feauters/recipes/presentation/bloc/steps_widget_cubit/steps_widget_cubit.dart';
import 'package:flutter_recipe/feauters/recipes/presentation/bloc/steps_widget_cubit/steps_widget_state.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/recipe.dart';

class StepCookWidget extends StatefulWidget {
  final Recipe recipe;
  List<bool> listCheckboxOn = [];
  Duration myDuration = const Duration(seconds: 0);
  int timeCookingSec = 0;
  int curentStep = 0;
  List<int> timeStepList = [];

  bool cookingProcess = false;

  StepCookWidget({required this.recipe, super.key}) {
    for (int i = 0; i < recipe.cook.length; i++) {
      timeCookingSec = timeCookingSec + recipe.cook[i].timeStepSec;
    }
    myDuration = Duration(seconds: timeCookingSec);
  }
  @override
  State<StepCookWidget> createState() => _StepCookWidgetState();
}

class _StepCookWidgetState extends State<StepCookWidget> {
  //final Recipe recipe;

  _StepCookWidgetState() {
    /// listValue = List.generate(recipe.cook.length, (index) => false);
  }

  Timer? countdownTimer;

  @override
  void initState() {
    //context.read<StepsWidgetCobit>().setTimeDown(stepDetails, steps)
    super.initState();
  }

  @override
  void deactivate() {
    context.read<StepsWidgetCobit>().stopSteps();

    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
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
        var state = context.watch<StepsWidgetCobit>().state;
        bool checkboxOn = false;

        if (state is StepsWidgetStateCooking) {
          widget.timeCookingSec = state.timeStepList[index];
          checkboxOn = state.checkboxOn[index];
          widget.curentStep = state.curentStep;
          widget.timeStepList = state.timeStepList;
          widget.listCheckboxOn = state.checkboxOn;
        }
        return Column(
          children: [
            Container(
                constraints: const BoxConstraints(
                  minHeight: 120,
                ),
                width: 398, //height: 120,
                decoration: BoxDecoration(
                    color: widget.cookingProcess
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
                            color: widget.cookingProcess
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
                          widget.cookingProcess
                              ? Checkbox(
                                  value: checkboxOn,
                                  onChanged: widget.curentStep == index
                                      ? (bool? newValue) {
                                          context
                                              .read<StepsWidgetCobit>()
                                              .stepEnd(
                                                  widget.curentStep,
                                                  widget.listCheckboxOn,
                                                  widget.timeStepList,
                                                  widget.recipe.cook);
                                        }
                                      : null,
                                )
                              : const SizedBox(
                                  height: 20,
                                ),
                          Text(
                            DateFormat.ms().format(DateTime(
                                0,
                                0,
                                0,
                                0,
                                0,
                                state is StepsWidgetStateCooking
                                    ? widget.timeCookingSec
                                    : widget.recipe.cook[index].timeStepSec
                                // widget.recipe.cook[index].timeStepSec

                                )),
                            style: const TextStyle(
                                color: Color(0xFF797676),
                                fontSize: 13,
                                fontWeight: FontWeight.w700),
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
        onTap: () => setState(() {
          {
            if (!widget.cookingProcess) {
              widget.cookingProcess = true;
              context
                  .read<StepsWidgetCobit>()
                  .startCoocking(widget.recipe.cook);
            } else {
              widget.cookingProcess = false;
              context.read<StepsWidgetCobit>().stopSteps();
            }
          }
        }),
        child: Container(
          width: 232,
          height: 48,
          decoration: BoxDecoration(
              color: const Color(0xFF165932),
              borderRadius: BorderRadius.circular(24)),
          child: Center(
              child: widget.cookingProcess
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
