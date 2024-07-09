class MainCategories {
  bool? success;
  String? message;
  List<SectionElement>? sections;
  Banners? banners;

  MainCategories({
    this.success,
    this.message,
    this.sections,
    this.banners,
  });

  factory MainCategories.fromJson(Map<String, dynamic> json) => MainCategories(
        success: json["success"],
        message: json["message"],
        sections: json["sections"] == null
            ? []
            : List<SectionElement>.from(
                json["sections"]!.map((x) => SectionElement.fromJson(x))),
        banners:
            json["banners"] == null ? null : Banners.fromJson(json["banners"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "sections": sections == null
            ? []
            : List<dynamic>.from(sections!.map((x) => x.toJson())),
        "banners": banners?.toJson(),
      };
}

class Banners {
  List<Banner>? topBanner;
  List<Banner>? bottomBanner;
  DateTime? createdAt;
  DateTime? updatedAt;
  num? v;

  Banners({
    this.topBanner,
    this.bottomBanner,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Banners.fromJson(Map<String, dynamic> json) => Banners(
        topBanner: json["topBanner"] == null
            ? []
            : List<Banner>.from(
                json["topBanner"]!.map((x) => Banner.fromJson(x))),
        bottomBanner: json["bottomBanner"] == null
            ? []
            : List<Banner>.from(
                json["bottomBanner"]!.map((x) => Banner.fromJson(x))),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "topBanner": topBanner == null
            ? []
            : List<dynamic>.from(topBanner!.map((x) => x.toJson())),
        "bottomBanner": bottomBanner == null
            ? []
            : List<dynamic>.from(bottomBanner!.map((x) => x.toJson())),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class Banner {
  String? image;
  BottomBannerSection? section;
  DateTime? validity;
  String? id;

  Banner({
    this.image,
    this.section,
    this.validity,
    this.id,
  });

  factory Banner.fromJson(Map<String, dynamic> json) => Banner(
        image: json["image"],
        section: json["section"] == null
            ? null
            : BottomBannerSection.fromJson(json["section"]),
        validity:
            json["validity"] == null ? null : DateTime.parse(json["validity"]),
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "section": section?.toJson(),
        "validity": validity?.toIso8601String(),
        "_id": id,
      };
}

class BottomBannerSection {
  String? id;
  String? name;

  BottomBannerSection({
    this.id,
    this.name,
  });

  factory BottomBannerSection.fromJson(Map<String, dynamic> json) =>
      BottomBannerSection(
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
      };
}

class SectionElement {
  String? id;
  String? name;
  String? image;

  SectionElement({
    this.id,
    this.name,
    this.image,
  });

  factory SectionElement.fromJson(Map<String, dynamic> json) => SectionElement(
        id: json["_id"],
        name: json["name"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "image": image,
      };
}
