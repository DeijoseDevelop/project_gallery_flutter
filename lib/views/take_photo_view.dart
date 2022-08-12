import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TakePhotoView extends StatelessWidget {
  const TakePhotoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          final ImagePicker _picker = ImagePicker();
          final XFile? image =
              await _picker.pickImage(source: ImageSource.gallery);
          if (image == null) {
            print('No image selected');
            return;
          }
          print('Image selected');
        },
        child: const Text('Take Photo'),
      ),
    );
  }
}
