abstract class LikeIkonState {}

class LikeIkonStateEmptry extends LikeIkonState {}

class LikeIkonStatteLoaded extends LikeIkonState {
  Map<String, bool> likes = {};
  LikeIkonStatteLoaded({required this.likes});
}

class LikeIkonStateLoading extends LikeIkonState {}
