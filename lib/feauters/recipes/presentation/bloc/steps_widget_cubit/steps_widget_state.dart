abstract class StepsWidgetState {}

class StepsWidgetStateEmpty extends StepsWidgetState {}

class StepsWidgetStateInit extends StepsWidgetState {
  int curentStep;
  List<int> timeStepList;
  List<bool> checkboxOn;
  StepsWidgetStateInit({
    required this.curentStep,
    required this.timeStepList,
    required this.checkboxOn,
  });
}

class StepsWidgetStateCooking extends StepsWidgetState {
  int curentStep;
  List<int> timeStepList;
  List<bool> checkboxOn;
  StepsWidgetStateCooking({
    required this.curentStep,
    required this.timeStepList,
    required this.checkboxOn,
  });
}
