// ignore_for_file: no_leading_underscores_for_local_identifiers, use_build_context_synchronously, avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gallery_image/models/models.dart';
import 'package:gallery_image/modelview/services/gallery_service.dart';
import 'package:gallery_image/views/widgets/image_detail.dart';
import 'package:gallery_image/views/widgets/loader.dart';
import 'package:image_picker/image_picker.dart';

class TakePhotoView extends StatefulWidget {
  const TakePhotoView({Key? key}) : super(key: key);

  @override
  State<TakePhotoView> createState() => _TakePhotoViewState();
}

class _TakePhotoViewState extends State<TakePhotoView> {
  List _imagePaths = [];
  File? compressImage;

  void setListImage() async {
    final response = await GalleryService().getImageServer();
    setState(() {
      _imagePaths = response.values.toList();
    });
  }

  @override
  void initState() {
    super.initState();
    setListImage();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.05,
        margin: const EdgeInsets.only(bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _customButton(
                text: 'Select a Photo',
                color: Colors.blue,
                type: ImageSource.gallery),
            _customButton(
                text: 'Take a Photo',
                color: Colors.green,
                type: ImageSource.camera),
          ],
        ),
      ),
      _imagePaths.isEmpty
          ? const Text('No image selected.')
          : Expanded(
              child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                ),
                itemCount: _imagePaths.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      if (_imagePaths[index]['image'] != null) {
                        Photo photo = Photo(
                            src: Src().copyWith(
                                large2X: _imagePaths[index]['image']));
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ImageDetail(image: photo),
                          ),
                        );
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(2),
                      child: Image.network(
                        _imagePaths[index]['image'],
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
    ]);
  }

  void _takePhoto(BuildContext context, type) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(
      source: type,
      maxWidth: 700,
      maxHeight: 700,
      imageQuality: 70,
    );
    if (image == null) {
      print('No image selected');
      return;
    }
    print('Image selected');

    openLoader(context);

    //? Send image to cloudinary
    final String? imageUrl = await GalleryService().uploadImage(image.path);
    print(imageUrl);

    //? Post image to firebase
    final String? post = await GalleryService().postImageServer(imageUrl!);

    //? get images from firebase
    final images = await GalleryService().getImageServer();
    setState(() {
      _imagePaths = images.values.toList();
    });

    closeLoader(context);
  }

  ElevatedButton _customButton({required text, required color, required type}) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(color),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      onPressed: () => _takePhoto(context, type),
      child: Text('$text'),
    );
  }
}
