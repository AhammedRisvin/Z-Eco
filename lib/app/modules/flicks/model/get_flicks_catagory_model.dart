class FlicksCatagoryModel {
  bool? success;
  String? message;
  List<Flick>? flicks;

  FlicksCatagoryModel({
    this.success,
    this.message,
    this.flicks,
  });

  factory FlicksCatagoryModel.fromJson(Map<String, dynamic> json) =>
      FlicksCatagoryModel(
        success: json["success"],
        message: json["message"],
        flicks: json["flicks"] == null
            ? []
            : List<Flick>.from(json["flicks"]!.map((x) => Flick.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "flicks": flicks == null
            ? []
            : List<dynamic>.from(flicks!.map((x) => x.toJson())),
      };
}

class Flick {
  String? banner;
  String? name;
  String? link;

  Flick({
    this.banner,
    this.name,
    this.link,
  });

  factory Flick.fromJson(Map<String, dynamic> json) => Flick(
        banner: json["banner"],
        name: json["name"],
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "banner": banner,
        "name": name,
        "link": link,
      };
}
