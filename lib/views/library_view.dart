import 'package:flutter/material.dart';
import 'package:gallery_image/models/models.dart';
import 'package:gallery_image/modelview/services/gallery_service.dart';
import 'package:gallery_image/views/views.dart';
import 'package:google_fonts/google_fonts.dart';

class LibraryView extends StatelessWidget {
  const LibraryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GalleryService _galleryService = GalleryService();
    List category = [];

    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: GridView(
          physics: const BouncingScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.0,
          ),
          children: [
            _ElementGrid(
              category: 'Nature',
            ),
            _ElementGrid(
              category: 'Developer',
            ),
            _ElementGrid(
              category: 'People',
            ),
            _ElementGrid(
              category: 'Dogs',
            ),
            _ElementGrid(
              category: 'Cats',
            ),
            _ElementGrid(
              category: 'City',
            ),
            _ElementGrid(
              category: 'Technology',
            ),
            _ElementGrid(
              category: 'Games',
            ),
            _ElementGrid(
              category: 'Soccer',
            ),
            _ElementGrid(
              category: 'Baseball',
            ),
          ]),
    );
  }
}

class _ElementGrid extends StatefulWidget {
  String category;
  _ElementGrid({
    required this.category,
    Key? key,
  }) : super(key: key);

  @override
  State<_ElementGrid> createState() => _ElementGridState();
}

class _ElementGridState extends State<_ElementGrid> {
  final GalleryService _galleryService = GalleryService();

  String? image;
  Gallery? gallery;

  void setCategory(String category) async {
    final images = await _galleryService.searchGallery(category);
    setState(() {
      gallery = images;
      image = images.photos?[0].src?.small;
    });
  }

  @override
  void initState() {
    super.initState();
    setCategory(widget.category);
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width * 0.4;
    final _height = MediaQuery.of(context).size.height * 0.2;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LibraryDetailView(
              gallery: gallery!,
              description: widget.category,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(2.0),
        width: _width,
        height: _height,
        child: Column(
          children: [
            image != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: SizedBox(
                      width: _width,
                      height: _height * 0.8,
                      child: Image.network(
                        image!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : const Center(child: CircularProgressIndicator()),
            Expanded(
              child: Text(
                widget.category,
                style: GoogleFonts.roboto(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
