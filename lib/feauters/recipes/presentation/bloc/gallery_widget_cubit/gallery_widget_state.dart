import 'package:flutter_recipe/feauters/recipes/domain/entities/gallery_item.dart';

abstract class GalleryWidgetState {}

class GalleryWidgetEmptyState extends GalleryWidgetState {}

class GalleryWidgetLoadingState extends GalleryWidgetState {}

class GalleryWidgetLoadedState extends GalleryWidgetState {
  List<GalleryItem> gallery;
  GalleryWidgetLoadedState({required this.gallery});
}
