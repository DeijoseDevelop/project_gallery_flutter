import 'package:flutter/material.dart';
import 'package:gallery_image/models/models.dart';
import 'package:gallery_image/modelview/services/gallery_service.dart';

class ListPhotoView extends StatelessWidget {
  const ListPhotoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GalleryService _galleryService = GalleryService();

    return FutureBuilder<Gallery>(
      future: _galleryService.getGallery(),
      builder: (context, snapshot) {
        List<Photo> photos = snapshot.data?.photos ?? [];

        if (snapshot.hasData) {
          return GridView.builder(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            padding: const EdgeInsets.only(top: 10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            itemCount: photos.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {/*
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PhotoDetailView(
                        photo: photos[index],
                      ),
                    ),
                  );
                 */},
                child: Hero(
                  tag: photos[index].id!,
                  child: Padding(
                    padding: const EdgeInsets.all(2),
                    child: Image.network(photos[index].src?.large ?? "",
                        fit: BoxFit.cover),
                  ),
                ),
              );
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
      },
    );
  }
}
