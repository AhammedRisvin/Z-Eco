class GetFlicksLibraryModel {
  bool? success;
  String? message;
  List<Flick>? flicks;
  // List<Flick>? watchHistory;
  List<Flick>? searchHistory;

  GetFlicksLibraryModel({
    this.success,
    this.message,
    this.flicks,
    // this.watchHistory,
    this.searchHistory,
  });

  factory GetFlicksLibraryModel.fromJson(Map<String, dynamic> json) =>
      GetFlicksLibraryModel(
        success: json["success"],
        message: json["message"],
        flicks: json["flicks"] == null
            ? []
            : List<Flick>.from(json["flicks"]!.map((x) => Flick.fromJson(x))),
        // watchHistory: json["watchHistory"] == null
        //     ? []
        //     : List<Flick>.from(
        //         json["watchHistory"]!.map((x) => Flick.fromJson(x))),
        searchHistory: json["searchHistory"] == null
            ? []
            : List<Flick>.from(
                json["searchHistory"]!.map((x) => Flick.fromJson(x))),
      );
}

class Flick {
  String? id;
  String? banner;
  String? name;
  String? link;
  String? fileSize;
  String? duration;
  bool? saved;
  String? timeAgo;

  Flick({
    this.id,
    this.banner,
    this.name,
    this.link,
    this.fileSize,
    this.duration,
    this.saved,
    this.timeAgo,
  });

  factory Flick.fromJson(Map<String, dynamic> json) => Flick(
        id: json["id"],
        banner: json["banner"],
        name: json["name"],
        link: json["link"],
        fileSize: json["fileSize"],
        duration: json["duration"],
        saved: json["saved"],
        timeAgo: json["timeAgo"],
      );
}
