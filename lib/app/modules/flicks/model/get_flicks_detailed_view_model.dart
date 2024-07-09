class GetFlicksDetailedViewModel {
  bool? success;
  String? message;
  Flick? flick;

  GetFlicksDetailedViewModel({
    this.success,
    this.message,
    this.flick,
  });

  factory GetFlicksDetailedViewModel.fromJson(Map<String, dynamic> json) =>
      GetFlicksDetailedViewModel(
        success: json["success"],
        message: json["message"],
        flick: json["flick"] == null ? null : Flick.fromJson(json["flick"]),
      );
}

class Flick {
  String? id;
  String? appId;
  String? banner;
  String? name;
  String? description;
  List<Genre>? genres;
  String? video;
  List<Season>? seasons;
  String? ageCategory;
  String? releasedYear;
  List<dynamic>? trailers;
  String? link;
  String? category;
  String? fileSize;
  String? duration;
  List<Detail>? details;
  List<dynamic>? relatedFlicks;
  List<dynamic>? viewers;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  bool? saved;

  Flick({
    this.id,
    this.appId,
    this.banner,
    this.name,
    this.description,
    this.genres,
    this.video,
    this.seasons,
    this.ageCategory,
    this.releasedYear,
    this.trailers,
    this.link,
    this.category,
    this.fileSize,
    this.duration,
    this.details,
    this.relatedFlicks,
    this.viewers,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.saved,
  });

  factory Flick.fromJson(Map<String, dynamic> json) => Flick(
        id: json["_id"],
        appId: json["appId"],
        banner: json["banner"],
        name: json["name"],
        description: json["description"],
        genres: json["genres"] == null
            ? []
            : List<Genre>.from(json["genres"]!.map((x) => Genre.fromJson(x))),
        video: json["video"],
        seasons: json["seasons"] == null
            ? []
            : List<Season>.from(
                json["seasons"]!.map((x) => Season.fromJson(x))),
        ageCategory: json["ageCategory"],
        releasedYear: json["releasedYear"],
        trailers: json["trailers"] == null
            ? []
            : List<dynamic>.from(json["trailers"]!.map((x) => x)),
        link: json["link"],
        category: json["category"],
        fileSize: json["fileSize"],
        duration: json["duration"],
        details: json["details"] == null
            ? []
            : List<Detail>.from(
                json["details"]!.map((x) => Detail.fromJson(x))),
        relatedFlicks: json["relatedFlicks"] == null
            ? []
            : List<dynamic>.from(json["relatedFlicks"]!.map((x) => x)),
        viewers: json["viewers"] == null
            ? []
            : List<dynamic>.from(json["viewers"]!.map((x) => x)),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        saved: json["saved"],
      );
}

class Detail {
  String? key;
  String? value;

  Detail({
    this.key,
    this.value,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        key: json["key"],
        value: json["value"],
      );
}

class Genre {
  String? id;
  String? type;

  Genre({
    this.id,
    this.type,
  });

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: json["_id"],
        type: json["type"],
      );
}

class Season {
  String? name;
  List<Episode>? episodes;
  String? id;

  Season({
    this.name,
    this.episodes,
    this.id,
  });

  factory Season.fromJson(Map<String, dynamic> json) => Season(
        name: json["name"],
        episodes: json["episodes"] == null
            ? []
            : List<Episode>.from(
                json["episodes"]!.map((x) => Episode.fromJson(x))),
        id: json["_id"],
      );
}

class Episode {
  String? name;
  String? description;
  List<dynamic>? genres;
  String? thumbnail;
  String? video;
  int? count;
  String? id;

  Episode({
    this.name,
    this.description,
    this.genres,
    this.thumbnail,
    this.video,
    this.count,
    this.id,
  });

  factory Episode.fromJson(Map<String, dynamic> json) => Episode(
        name: json["name"],
        description: json["description"],
        genres: json["genres"] == null
            ? []
            : List<dynamic>.from(json["genres"]!.map((x) => x)),
        thumbnail: json["thumbnail"],
        video: json["video"],
        count: json["count"],
        id: json["_id"],
      );
}
