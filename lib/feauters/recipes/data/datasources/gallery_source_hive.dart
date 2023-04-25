import 'package:hive/hive.dart';

import '../../domain/entities/gallery_item.dart';

class GallerySourceHive {
  Future<List<GalleryItem>> getGallery(String recipeId) async {
    List<GalleryItem> gallery = [];
    // print('get hive');
    // if ((Hive.box<GalleryItem>(recipeId).isOpen) != true) {
    //   print('is not open');
    //   await Hive.openBox<GalleryItem>(recipeId);
    // }
    await Hive.openBox<GalleryItem>(recipeId);
    print('get gallery');
    var box = Hive.box<GalleryItem>(recipeId);
    int boxLenght = box.length;
    // box.clear();
    for (int i = 0; i < boxLenght; i++) {
      GalleryItem galleryItem = box.getAt(i) as GalleryItem;

      gallery.add(galleryItem);
    }
    return gallery;
  }





  Future<void> addGalleryItem(GalleryItem galleryItem, String recipeId) async {
    // if (!Hive.box<GalleryItem>(recipeId).isOpen) {
    //   await Hive.openBox<GalleryItem>(recipeId);
    // }

    var box = Hive.box<GalleryItem>(recipeId);
    print('add gallery${box.name}');
    // await box.clear();

    await box.add(galleryItem);
  }
}
