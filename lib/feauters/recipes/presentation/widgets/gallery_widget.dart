import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_recipe/feauters/recipes/domain/entities/gallery_item.dart';
import 'package:flutter_recipe/feauters/recipes/presentation/bloc/gallery_widget_cubit/gallery_widget_cubit.dart';
import 'package:flutter_recipe/feauters/recipes/presentation/bloc/gallery_widget_cubit/gallery_widget_state.dart';
import 'package:flutter_recipe/feauters/recipes/presentation/widgets/tensor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class GalleryWidget extends StatelessWidget {
  final String recipeId;
  const GalleryWidget({required this.recipeId, super.key});

  @override
  Widget build(BuildContext context) {
    List<GalleryItem> gallery;
    context.read<GalleryWidgetCubit>().getGallery(recipeId);
    return Column(
      children: [
        ElevatedButton(
            onPressed: () async {
              final ImagePicker _picker = ImagePicker();
              final XFile? xFile = await _picker.pickImage(
                source: ImageSource.camera,
              );
              //String resourceImage='';
              var file = File(xFile!.path);
              String resourceImage = file.path;
              context
                  .read<GalleryWidgetCubit>()
                  .addImage(resourceImage, recipeId);
            },
            child: const Text('Добавить фото')),
        BlocBuilder<GalleryWidgetCubit, GalleryWidgetState>(
            builder: (context, state) {
          if (state is GalleryWidgetEmptyState) {
            context.read<GalleryWidgetCubit>().getGallery(recipeId);
            return const CircularProgressIndicator(
              color: Color.fromARGB(255, 8, 117, 26),
            );
          }
          if (state is GalleryWidgetLoadingState) {
            return const CircularProgressIndicator(
              color: Color.fromARGB(255, 8, 117, 26),
            );
          }
          if (state is GalleryWidgetLoadedState) {
            gallery = state.gallery;

            return //Text('data${gallery.length}');
                SizedBox(
              height: 200,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: gallery.length,
                  itemBuilder: (context, index) {
                    return GalleryExampleItemThumbnail(
                        galleryleItem: gallery[index],
                        onTap: () {
                          open(context, index, gallery);
                        });
                  }),
            );
          }
          return const SizedBox(
            height: 50,
          );
        }),
      ],
    );
  }

  void open(BuildContext context, final int index, List<GalleryItem> gallery) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GalleryPhotoViewWrapper(
          galleryItems: gallery,
          backgroundDecoration: const BoxDecoration(
            color: Colors.black,
          ),
          initialIndex: index,
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }
}

class GalleryExampleItemThumbnail extends StatelessWidget {
  const GalleryExampleItemThumbnail({
    Key? key,
    required this.galleryleItem,
    required this.onTap,
  }) : super(key: key);

  final GalleryItem galleryleItem;

  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    File file = File(galleryleItem.resource);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: GestureDetector(
        onTap: onTap,
        child: Hero(
          tag: galleryleItem.resource,
          child: Tensor(file: file),
          // Image.file(file, height: 80.0),
        ),
      ),
    );
  }
}

class GalleryPhotoViewWrapper extends StatefulWidget {
  GalleryPhotoViewWrapper({
    super.key,
    this.loadingBuilder,
    this.backgroundDecoration,
    this.minScale,
    this.maxScale,
    this.initialIndex = 0,
    required this.galleryItems,
    this.scrollDirection = Axis.horizontal,
  }) : pageController = PageController(initialPage: initialIndex);

  final LoadingBuilder? loadingBuilder;
  final BoxDecoration? backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;
  final int initialIndex;
  final PageController pageController;
  final List<GalleryItem> galleryItems;
  final Axis scrollDirection;

  @override
  State<StatefulWidget> createState() {
    return _GalleryPhotoViewWrapperState();
  }
}

class _GalleryPhotoViewWrapperState extends State<GalleryPhotoViewWrapper> {
  late int currentIndex = widget.initialIndex;

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: widget.backgroundDecoration,
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: <Widget>[
            PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              builder: _buildItem,
              itemCount: widget.galleryItems.length,
              loadingBuilder: widget.loadingBuilder,
              backgroundDecoration: widget.backgroundDecoration,
              pageController: widget.pageController,
              onPageChanged: onPageChanged,
              scrollDirection: widget.scrollDirection,
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Image ${currentIndex + 1}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17.0,
                  decoration: null,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  PhotoViewGalleryPageOptions _buildItem(BuildContext context, int index) {
    final GalleryItem item = widget.galleryItems[index];
    final File file = File(item.resource);
    return PhotoViewGalleryPageOptions.customChild(
      child: SizedBox(
        width: 300,
        height: 300,
        child: Image.file(
          file,
          height: 200.0,
        ),
      ),
      childSize: const Size(300, 300),
      initialScale: PhotoViewComputedScale.contained,
      minScale: PhotoViewComputedScale.contained * (0.5 + index / 10),
      maxScale: PhotoViewComputedScale.covered * 4.1,
      heroAttributes: PhotoViewHeroAttributes(tag: item.recipeId),
    );
  }
}
