import 'package:flutter/material.dart';
import 'package:gallery_image/modelview/services/gallery_service.dart';
import 'package:google_fonts/google_fonts.dart';

class LibraryView extends StatelessWidget {
  const LibraryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    GalleryService _galleryService = GalleryService();


    return const Scaffold(
      body: Center(
        child: Text('HomeView'),
      ),
    );
  }
}