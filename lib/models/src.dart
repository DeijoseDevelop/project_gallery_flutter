class Src {
    Src({
        this.original,
        this.large2X,
        this.large,
        this.medium,
        this.small,
        this.portrait,
        this.landscape,
        this.tiny,
    });

    String? original;
    String? large2X;
    String? large;
    String? medium;
    String? small;
    String? portrait;
    String? landscape;
    String? tiny;

    Src copyWith({
        String? original,
        String? large2X,
        String? large,
        String? medium,
        String? small,
        String? portrait,
        String? landscape,
        String? tiny,
    }) =>
        Src(
            original: original ?? this.original,
            large2X: large2X ?? this.large2X,
            large: large ?? this.large,
            medium: medium ?? this.medium,
            small: small ?? this.small,
            portrait: portrait ?? this.portrait,
            landscape: landscape ?? this.landscape,
            tiny: tiny ?? this.tiny,
        );

    factory Src.fromJson(Map<String, dynamic> json) => Src(
        original: json["original"],
        large2X: json["large2x"],
        large: json["large"],
        medium: json["medium"],
        small: json["small"],
        portrait: json["portrait"],
        landscape: json["landscape"],
        tiny: json["tiny"],
    );

    Map<String, dynamic> toJson() => {
        "original": original,
        "large2x": large2X,
        "large": large,
        "medium": medium,
        "small": small,
        "portrait": portrait,
        "landscape": landscape,
        "tiny": tiny,
    };
}
