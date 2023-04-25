import 'package:flutter_recipe/feauters/recipes/domain/entities/gallery_item.dart';

abstract class GalleryRepository {
  Future<List<GalleryItem>> getGallery(String recipeId);
  Future<void> addGalleryItem(GalleryItem galleryItem, String recipeId);
}
