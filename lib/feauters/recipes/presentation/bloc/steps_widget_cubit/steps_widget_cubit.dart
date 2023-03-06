import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_recipe/feauters/recipes/presentation/bloc/steps_widget_cubit/steps_widget_state.dart';

import '../../../domain/entities/recipe.dart';

class StepsWidgetCobit extends Cubit<StepsWidgetState> {
  StepsWidgetCobit(super.initialState);

  Timer? countdownTimer;

  void init(List<Cook> steps) {}

  void startCoocking(List<Cook> steps) {
    List<bool> checkboxOn = List.generate(steps.length, (index) => false);
    List<int> timeStepList =
        List.generate(steps.length, (index) => steps[index].timeStepSec);
    int curentStep = 0;
    int timeStep = steps.first.timeStepSec;
    StepDetails stepDetails = StepDetails(
        curentStep: curentStep,
        checkboxOn: checkboxOn,
        timeStepList: timeStepList);
    countdownTimer = Timer.periodic(
        Duration(seconds: 1),
        (_) => {
              //print('Timer.periodic'),
              stepDetails = setTimeDown(stepDetails, steps)
            });
  }

  void stepEnd(int curentStep, List<bool> checkboxOn, List<int> timeStepList,
      List<Cook> steps) {
    timeStepList[curentStep] = 1;

    StepDetails stepDetails = StepDetails(
        curentStep: curentStep,
        checkboxOn: checkboxOn,
        timeStepList: timeStepList);

    setTimeDown(stepDetails, steps);
  }

  void stopSteps() {
    stopTimer();
    emit(StepsWidgetStateEmpty());
  }

  StepDetails setTimeDown(StepDetails stepDetails, List<Cook> steps) {
    if (stepDetails.timeStepList[stepDetails.curentStep] != 0) {
      stepDetails.timeStepList[stepDetails.curentStep]--;
      //print(stepDetails.timeStepList[stepDetails.curentStep]);

      emit(StepsWidgetStateCooking(
          curentStep: stepDetails.curentStep,
          checkboxOn: stepDetails.checkboxOn,
          timeStepList: stepDetails.timeStepList));
      return stepDetails;
    } else {
      stepDetails.checkboxOn[stepDetails.curentStep] = true;
      if (stepDetails.curentStep + 1 < stepDetails.checkboxOn.length) {
        stepDetails.curentStep++;
        stepDetails.timeStepList[stepDetails.curentStep] =
            steps[stepDetails.curentStep].timeStepSec;
        emit(StepsWidgetStateCooking(
            curentStep: stepDetails.curentStep,
            checkboxOn: stepDetails.checkboxOn,
            timeStepList: stepDetails.timeStepList));
        return stepDetails;
      } else {
        stepDetails.checkboxOn[stepDetails.curentStep] = true;
        emit(StepsWidgetStateCooking(
            curentStep: stepDetails.curentStep,
            checkboxOn: stepDetails.checkboxOn,
            timeStepList: stepDetails.timeStepList));
        stopTimer();
        return stepDetails;
      }
      ;
    }
  }
//  void startTimer() {
//     countdownTimer =
//         Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
//   }

  void stopTimer() {
    if (countdownTimer != null) countdownTimer!.cancel();
  }

  // void resetTimer() {
  //   stopTimer();
  //   setState(() => myDuration = Duration(seconds: timeCookingSec));
  // }

  // void setCountDown() {
  //   const reduceSecondsBy = 1;
  //   setState(() {
  //     final seconds = myDuration.inSeconds - reduceSecondsBy;
  //     if (seconds < 0) {
  //       countdownTimer!.cancel();
  //     } else {
  //       myDuration = Duration(seconds: seconds);
  //     }
  //   });
  // }
}

class StepDetails {
  int curentStep;
  List<bool> checkboxOn;
  List<int> timeStepList;
  StepDetails({
    required this.curentStep,
    required this.checkboxOn,
    required this.timeStepList,
  });
}
