import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_recipe/feauters/recipes/data/repository/gallery_repository_impl.dart';
import 'package:flutter_recipe/feauters/recipes/domain/entities/gallery_item.dart';
import 'package:flutter_recipe/feauters/recipes/presentation/bloc/gallery_widget_cubit/gallery_widget_state.dart';

class GalleryWidgetCubit extends Cubit<GalleryWidgetState> {
  GalleryRepositoryImpl galleryRepositoryImpl;

  GalleryWidgetCubit(
    GalleryWidgetEmptyState galleryWidgetEmptyState, {
    required this.galleryRepositoryImpl,
  }) : super(GalleryWidgetEmptyState());

  void getGallery(String recipeId) async {
    List<GalleryItem> galleryItem =
        await galleryRepositoryImpl.getGallery(recipeId);
    emit(GalleryWidgetLoadedState(gallery: galleryItem));
  }

  void addImage(String resourceImage, String recipeId) async {
    GalleryItem galleryItem =
        GalleryItem(recipeId: recipeId, resource: resourceImage);
    await galleryRepositoryImpl.addGalleryItem(galleryItem, recipeId);
    getGallery(recipeId);
  }
}
