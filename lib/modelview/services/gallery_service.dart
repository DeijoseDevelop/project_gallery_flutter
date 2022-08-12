import 'dart:convert';

import 'package:gallery_image/models/models.dart';
import 'package:http/http.dart' as http;

class GalleryService {
  GalleryService();

  final _baseUrl = 'https://api.pexels.com/v1/';
  final _token = '563492ad6f917000010000017201ec2a3e1441f3a80f5d84f9f39004';

  Future<Gallery> getGallery() async {
    const urlGallery = 'curated?page=1&per_page=80';
    final response = await http.get(
      Uri.parse('$_baseUrl$urlGallery'),
      headers: {
        'Authorization': _token,
        'Content-Type': 'application/json',
      },
    );
    return galleryFromJson(response.body);
  }

  Future<Gallery> searchGallery(String search) async {
    final urlSearch = 'search?query=$search&page=1&per_page=80';
    final response = await http.get(
      Uri.parse('$_baseUrl$urlSearch'),
      headers: {
        "Authorization": _token,
        'Content-Type': 'application/json',
    });

    return galleryFromJson(response.body);
  }
}
