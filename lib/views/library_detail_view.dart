import 'package:flutter/material.dart';
import 'package:gallery_image/models/models.dart';

import 'widgets/image_detail.dart';
import 'widgets/title_menu.dart';

class LibraryDetailView extends StatelessWidget {
  Gallery gallery;
  String description;

  LibraryDetailView(
      {required this.gallery, required this.description, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        title: Text(description),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: gallery.photos?.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ImageDetail(
                      image: gallery.photos![index],
                    ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Hero(
                    tag: gallery.photos![index].src!.small!,
                    child: Image.network(
                      gallery.photos![index].src!.small!,
                      fit: BoxFit.cover,
                    )),
              ),
            );
          },
        ),
      ),
    );
  }
}
