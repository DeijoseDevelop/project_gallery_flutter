import 'package:flutter/material.dart';
import 'package:gallery_image/models/models.dart';
import 'package:gallery_image/modelview/services/gallery_service.dart';
import 'package:gallery_image/views/widgets/image_detail.dart';

class ListPhotoView extends StatelessWidget {

  Future<Gallery> galleryService;

  ListPhotoView({Key? key, required this.galleryService}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<Gallery>(
      future: galleryService,
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
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ImageDetail(
                        image: photos[index],
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: Hero(
                    tag: photos[index].id!,
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
