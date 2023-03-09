import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../bloc/steps_widget_cubit/steps_widget_cubit.dart';
import '../bloc/steps_widget_cubit/steps_widget_state.dart';

class BotomAppBarWidget extends StatelessWidget {
  int timeCookingSec = 0;
  bool cooking = false;
  BotomAppBarWidget({super.key});
  @override
  Widget build(BuildContext context) {
    var state = context.watch<StepsWidgetCobit>().state;
    if (state is StepsWidgetStateCooking) {
      timeCookingSec = state.timeStepList.reduce((a, b) => a + b);
      cooking = true;
    } else {
      cooking = false;
    }
    return PreferredSize(
      preferredSize: const Size.fromHeight(0),
      child: Padding(
          padding: const EdgeInsets.only(left: 100, right: 100),
          child: cooking
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                      const Text(
                        'timer',
                        style: TextStyle(fontSize: 15),
                      ),
                      Text(
                        DateFormat.ms()
                            .format(DateTime(0, 0, 0, 0, 0, timeCookingSec)),
                        style: const TextStyle(fontSize: 24),
                      ),
                    ])
              : null),
    );
  }
}
