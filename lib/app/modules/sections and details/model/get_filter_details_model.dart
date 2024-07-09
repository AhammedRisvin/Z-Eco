class GetFilterDetailsModel {
  bool? success;
  String? message;
  List<String>? colors;
  List<FilterBrand>? brands;
  List<String>? sizes;

  GetFilterDetailsModel({
    this.success,
    this.message,
    this.colors,
    this.brands,
    this.sizes,
  });

  factory GetFilterDetailsModel.fromJson(Map<String, dynamic> json) =>
      GetFilterDetailsModel(
        success: json["success"],
        message: json["message"],
        colors: json["colors"] == null
            ? []
            : List<String>.from(json["colors"]!.map((x) => x)),
        brands: json["brands"] == null
            ? []
            : List<FilterBrand>.from(
                json["brands"]!.map((x) => FilterBrand.fromJson(x))),
        sizes: json["sizes"] == null
            ? []
            : List<String>.from(json["sizes"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "colors":
            colors == null ? [] : List<dynamic>.from(colors!.map((x) => x)),
        "brands":
            brands == null ? [] : List<dynamic>.from(brands!.map((x) => x)),
        "sizes": sizes == null ? [] : List<dynamic>.from(sizes!.map((x) => x)),
      };
}

class FilterBrand {
  String? name;
  String? id;

  FilterBrand({
    this.name,
    this.id,
  });

  factory FilterBrand.fromJson(Map<String, dynamic> json) => FilterBrand(
        name: json["name"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
      };
}
