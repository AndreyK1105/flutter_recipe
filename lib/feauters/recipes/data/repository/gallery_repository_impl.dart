import 'package:flutter_recipe/feauters/recipes/data/datasources/gallery_source_hive.dart';
import 'package:flutter_recipe/feauters/recipes/domain/entities/gallery_item.dart';
import 'package:flutter_recipe/feauters/recipes/domain/repository/gallery_repository.dart';

class GalleryRepositoryImpl implements GalleryRepository {
  GallerySourceHive gallerySourceHive;
  GalleryRepositoryImpl({
    required this.gallerySourceHive,
  });

  @override
  Future<void> addGalleryItem(GalleryItem galleryItem, String recipeId) async {
    gallerySourceHive.addGalleryItem(galleryItem, recipeId);
  }

  @override
  Future<List<GalleryItem>> getGallery(String recipeId) {
    return gallerySourceHive.getGallery(recipeId);
  }
}
