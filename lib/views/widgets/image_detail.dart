import 'package:flutter/material.dart';
import 'package:gallery_image/models/photo.dart';
import 'package:photo_view/photo_view.dart';

class ImageDetail extends StatelessWidget {
  Photo image;
  ImageDetail({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: PhotoView(
          imageProvider: NetworkImage(image.src!.large2X!),
          minScale: PhotoViewComputedScale.contained * 1,
          maxScale: PhotoViewComputedScale.covered * 1.1,
          initialScale: PhotoViewComputedScale.contained * 0.8,
          basePosition: Alignment.center,
          gaplessPlayback: true,
          heroAttributes: const PhotoViewHeroAttributes(tag: "image"),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        backgroundColor: Colors.white12,
        elevation: 0,
        child: const Icon(Icons.arrow_back),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
