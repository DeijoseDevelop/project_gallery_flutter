import 'dart:convert';
import 'dart:io';
import 'package:gallery_image/models/models.dart';
import 'package:http/http.dart' as http;

class GalleryService {
  GalleryService();

  final _baseUrl = 'https://api.pexels.com/v1/';
  final _token = '563492ad6f917000010000017201ec2a3e1441f3a80f5d84f9f39004';

  Future<Gallery> getGallery() async {
    final urlGallery = Uri.parse('${_baseUrl}curated?page=1&per_page=80');
    final response = await http.get(
      urlGallery,
      headers: {
        'Authorization': _token,
        'Content-Type': 'application/json',
      },
    );
    return galleryFromJson(response.body);
  }

  Future<Gallery> searchGallery(String search) async {
    final urlSearch =
        Uri.parse('${_baseUrl}search?query=$search&page=1&per_page=80');
    final response = await http.get(urlSearch, headers: {
      "Authorization": _token,
      'Content-Type': 'application/json',
    });

    return galleryFromJson(response.body);
  }

  Future<String?> uploadImage(String path) async {
    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/lsv-personal/image/upload?upload_preset=nfkeak4p');

    final imageUploadRequest = http.MultipartRequest('POST', url);
    final file = await http.MultipartFile.fromPath('file', path);

    imageUploadRequest.files.add(file);
    final streamResponse = await imageUploadRequest.send();
    final response = await http.Response.fromStream(streamResponse);

    if (response.statusCode != 200 && response.statusCode != 201) {
      print('Something went wrong');
      print('StatusCode: ${response.statusCode}');
      print(response.body);
    }
    final responseData = json.decode(response.body);
    return responseData['secure_url'];
  }

  Future getImageServer() async{
    final url = Uri.parse(
        'https://flutterapp-25acc-default-rtdb.firebaseio.com/gallery.json');
    final response = await http.get(url);
    final json = jsonDecode(response.body);
    return json;
  }

  Future<String?> postImageServer(String image) async {
    final url = Uri.parse(
        'https://flutterapp-25acc-default-rtdb.firebaseio.com/gallery.json');
    final json = {
      "image": image,
    };
    final response = await http.post(
      url,
      body: jsonEncode(json),
    );
    return null;
  }
}
