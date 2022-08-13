import 'dart:convert';

import 'package:gallery_image/models/models.dart';
import 'package:http/http.dart' as http;

class GalleryService {
  GalleryService();

  final _baseUrl = 'https://api.pexels.com/v1/';

  Future<Gallery> getGallery() async {
    const urlGallery = 'curated?page=1&per_page=80';
    final response = await http.get(Uri.parse('$_baseUrl$urlGallery'));
    return galleryFromJson(response.body);
  }
}
