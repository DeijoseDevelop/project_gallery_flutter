import 'package:flutter/material.dart';
import 'package:gallery_image/models/models.dart';
import 'package:gallery_image/modelview/services/gallery_service.dart';
import 'package:gallery_image/views/widgets/image_detail.dart';

class SearchPhotoView extends StatefulWidget {
  const SearchPhotoView({Key? key}) : super(key: key);

  @override
  State<SearchPhotoView> createState() => _SearchPhotoViewState();
}

class _SearchPhotoViewState extends State<SearchPhotoView> {
  Gallery? photos;

  @override
  Widget build(BuildContext context) {

    TextEditingController _searchController = TextEditingController();

    GalleryService _galleryService = GalleryService();

    final Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        SizedBox(
          height: size.height * 0.1,
          width: size.width,
          child: Center(
              child: _searchForm(
                  searchController: _searchController,
                  galleryService: _galleryService)),
        ),
        Expanded(child: _Builder(photos: photos)),
      ],
    );
  }

  Form _searchForm(
      {required TextEditingController searchController,
      required GalleryService galleryService}) {
    return Form(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            height: MediaQuery.of(context).size.height * 0.1,
            child: TextFormField(
              controller: searchController,
              decoration: const InputDecoration(
                labelText: 'Search',
                hintText: 'Search',
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          ElevatedButton(
            child: const Text('Search'),
            onPressed: () async {
              final photos =
                  await galleryService.searchGallery(searchController.text);
              setState(() {
                this.photos = photos;
              });
            },
          ),
        ],
      ),
    );
  }
}

class _Builder extends StatelessWidget {
  const _Builder({
    Key? key,
    required this.photos,
  }) : super(key: key);

  final Gallery? photos;

  @override
  Widget build(BuildContext context) {
    if (photos != null) {
      if (photos!.photos != null && photos!.photos!.isNotEmpty) {
        return GridView.builder(
          physics: const BouncingScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3),
          itemCount: (photos!.photos ?? []).length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ImageDetail(
                      image: photos!.photos![index],
                    ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: Hero(
                  tag: photos!.photos![index].id!,
                  child: Image.network(photos!.photos![index].src!.small!,
                      fit: BoxFit.cover),
                ),
              ),
            );
          },
        );
      } else {
        return const Center(
          child: Text('No results found'),
        );
      }
    } else {
      return const Center(
        child: CircularProgressIndicator.adaptive(),
      );
    }
  }
}
