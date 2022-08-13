import 'dart:convert';

import 'package:gallery_image/models/models.dart';

Gallery galleryFromJson(String str) => Gallery.fromJson(json.decode(str));

String galleryToJson(Gallery data) => json.encode(data.toJson());

class Gallery {
    Gallery({
        this.page,
        this.perPage,
        this.photos,
        this.totalResults,
        this.nextPage,
    });

    int? page;
    int? perPage;
    List<Photo>? photos;
    int? totalResults;
    String? nextPage;

    Gallery copyWith({
        int? page,
        int? perPage,
        List<Photo>? photos,
        int? totalResults,
        String? nextPage,
    }) =>
        Gallery(
            page: page ?? this.page,
            perPage: perPage ?? this.perPage,
            photos: photos ?? this.photos,
            totalResults: totalResults ?? this.totalResults,
            nextPage: nextPage ?? this.nextPage,
        );

    factory Gallery.fromJson(Map<String, dynamic> json) => Gallery(
        page: json["page"],
        perPage: json["per_page"],
        photos: json["photos"] == null ? null : List<Photo>.from(json["photos"]!.map((x) => Photo.fromJson(x))),
        totalResults: json["total_results"],
        nextPage: json["next_page"],
    );

    Map<String, dynamic> toJson() => {
        "page": page,
        "per_page": perPage,
        "photos": List<dynamic>.from(photos!.map((x) => x.toJson())),
        "total_results": totalResults,
        "next_page": nextPage,
    };
}
