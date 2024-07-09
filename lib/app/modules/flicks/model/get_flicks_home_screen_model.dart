class GetFlicksHomeScreenModel {
  bool? success;
  String? message;
  List<Category>? categories;
  List<LatestFlick>? latestFlicks;
  List<Flick>? recommendedFlicks;
  List<Flick>? trendingFlicks;
  List<Flick>? catagoryFlicks;

  GetFlicksHomeScreenModel({
    this.success,
    this.message,
    this.categories,
    this.latestFlicks,
    this.recommendedFlicks,
    this.trendingFlicks,
  });

  factory GetFlicksHomeScreenModel.fromJson(Map<String, dynamic> json) =>
      GetFlicksHomeScreenModel(
        success: json["success"],
        message: json["message"],
        categories: json["categories"] == null
            ? []
            : List<Category>.from(
                json["categories"]!.map((x) => Category.fromJson(x))),
        latestFlicks: json["latestFlicks"] == null
            ? []
            : List<LatestFlick>.from(
                json["latestFlicks"]!.map((x) => LatestFlick.fromJson(x))),
        recommendedFlicks: json["recommendedFlicks"] == null
            ? []
            : List<Flick>.from(
                json["recommendedFlicks"]!.map((x) => Flick.fromJson(x))),
        trendingFlicks: json["trendingFlicks"] == null
            ? []
            : List<Flick>.from(
                json["trendingFlicks"]!.map((x) => Flick.fromJson(x))),
      );
}

class Category {
  String? id;
  String? name;

  Category({
    this.id,
    this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["_id"],
        name: json["name"],
      );
}

class LatestFlick {
  String? id;
  String? banner;
  String? video;
  String? link;
  bool? saved;

  LatestFlick({
    this.id,
    this.banner,
    this.video,
    this.link,
    this.saved,
  });

  factory LatestFlick.fromJson(Map<String, dynamic> json) => LatestFlick(
        id: json["_id"],
        banner: json["banner"],
        video: json["video"],
        link: json["link"],
        saved: json["saved"],
      );
}

class Flick {
  String? id;
  String? banner;
  List<String>? genres;
  String? video;
  String? link;
  bool? saved;

  Flick({
    this.id,
    this.banner,
    this.genres,
    this.video,
    this.link,
    this.saved,
  });

  factory Flick.fromJson(Map<String, dynamic> json) => Flick(
        id: json["_id"],
        banner: json["banner"],
        genres: json["genres"] == null
            ? []
            : List<String>.from(json["genres"]!.map((x) => x)),
        video: json["video"],
        link: json["link"],
        saved: json["saved"],
      );
}
