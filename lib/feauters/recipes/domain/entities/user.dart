import 'package:hive/hive.dart';

@HiveType(typeId: 4)
class User {
  @HiveField(0)
  String id = '';
  @HiveField(1)
  String name = '';
  @HiveField(2)
  String avatar = '';
  List<String> likeRecipeId;
  User(
      {required this.id,
      required this.name,
      required this.avatar,
      required this.likeRecipeId});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: (json['_id'] != null) ? (json['_id'] as String) : '',
      name: (json['name'] != null) ? (json['name'] as String) : '',
      avatar: (json['img'] != null) ? (json['img'] as String) : '',
      likeRecipeId: (json['likeRecipeId'] != null)
          ? (json['likeRecipeId'] as List)
              .map((e) => e['recipeId'] as String)
              .toList()
          : [],
    );
  }
}
