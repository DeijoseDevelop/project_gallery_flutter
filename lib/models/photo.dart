import 'package:gallery_image/models/models.dart';

class Photo {
    Photo({
        this.id,
        this.width,
        this.height,
        this.url,
        this.photographer,
        this.photographerUrl,
        this.photographerId,
        this.avgColor,
        this.src,
        this.liked,
        this.alt,
    });

    int? id;
    int? width;
    int? height;
    String? url;
    String? photographer;
    String? photographerUrl;
    int? photographerId;
    String? avgColor;
    Src? src;
    bool? liked;
    String? alt;

    Photo copyWith({
        int? id,
        int? width,
        int? height,
        String? url,
        String? photographer,
        String? photographerUrl,
        int? photographerId,
        String? avgColor,
        Src? src,
        bool? liked,
        String? alt,
    }) =>
        Photo(
            id: id ?? this.id,
            width: width ?? this.width,
            height: height ?? this.height,
            url: url ?? this.url,
            photographer: photographer ?? this.photographer,
            photographerUrl: photographerUrl ?? this.photographerUrl,
            photographerId: photographerId ?? this.photographerId,
            avgColor: avgColor ?? this.avgColor,
            src: src ?? this.src,
            liked: liked ?? this.liked,
            alt: alt ?? this.alt,
        );

    factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        id: json["id"],
        width: json["width"],
        height: json["height"],
        url: json["url"],
        photographer: json["photographer"],
        photographerUrl: json["photographer_url"],
        photographerId: json["photographer_id"],
        avgColor: json["avg_color"],
        src: Src.fromJson(json["src"]),
        liked: json["liked"],
        alt: json["alt"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "width": width,
        "height": height,
        "url": url,
        "photographer": photographer,
        "photographer_url": photographerUrl,
        "photographer_id": photographerId,
        "avg_color": avgColor,
        "src": src!.toJson(),
        "liked": liked,
        "alt": alt,
    };
}