import 'package:flutter/material.dart';
import 'package:gallery_image/models/models.dart';

class PhotoDetailView extends StatelessWidget {

  Photo photo;

  PhotoDetailView({Key? key, required this.photo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
         child: Text('PhotoDetailView'),
    );
  }
}