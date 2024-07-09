class GetWatchHistoryModel {
  bool? success;
  String? message;
  List<Flick>? flicks;

  GetWatchHistoryModel({
    this.success,
    this.message,
    this.flicks,
  });

  factory GetWatchHistoryModel.fromJson(Map<String, dynamic> json) =>
      GetWatchHistoryModel(
        success: json["success"],
        message: json["message"],
        flicks: json["flicks"] == null
            ? []
            : List<Flick>.from(json["flicks"]!.map((x) => Flick.fromJson(x))),
      );
}

class Flick {
  String? id;
  String? banner;
  String? name;
  String? link;
  String? fileSize;
  int? duration;
  String? timeAgo;

  Flick({
    this.id,
    this.banner,
    this.name,
    this.link,
    this.fileSize,
    this.duration,
    this.timeAgo,
  });

  factory Flick.fromJson(Map<String, dynamic> json) => Flick(
        id: json["id"],
        banner: json["banner"],
        name: json["name"],
        link: json["link"],
        fileSize: json["fileSize"],
        duration: json["duration"],
        timeAgo: json["timeAgo"],
      );
}
