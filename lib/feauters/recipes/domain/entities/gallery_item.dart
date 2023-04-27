import 'dart:io';

import 'package:hive/hive.dart';
part 'gallery_item.g.dart';

@HiveType(typeId: 5)
class GalleryItem {
  @HiveField(0)
  final String recipeId;
  @HiveField(1)
  final String resource;
  const GalleryItem({
    required this.recipeId,
    required this.resource,
  });
}
