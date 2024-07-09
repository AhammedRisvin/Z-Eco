import '../../sections and details/model/get_secdtion_homescreen_model.dart';

class GetFavouritesModel {
  bool? success;
  String? message;
  Wishlists? wishlists;

  GetFavouritesModel({
    this.success,
    this.message,
    this.wishlists,
  });

  factory GetFavouritesModel.fromJson(Map<String, dynamic> json) =>
      GetFavouritesModel(
        success: json["success"],
        message: json["message"],
        wishlists: json["wishlists"] == null
            ? null
            : Wishlists.fromJson(json["wishlists"]),
      );
}

class Wishlists {
  String? id;
  List<Product>? product;

  Wishlists({
    this.id,
    this.product,
  });

  factory Wishlists.fromJson(Map<String, dynamic> json) => Wishlists(
        id: json["_id"],
        product: json["product"] == null
            ? []
            : List<Product>.from(
                json["product"]!.map((x) => Product.fromJson(x))),
      );
}

class GetProductsModel {
  String? id;
  List<Product>? product;

  GetProductsModel({
    this.id,
    this.product,
  });

  factory GetProductsModel.fromJson(Map<String, dynamic> json) =>
      GetProductsModel(
        id: json["_id"],
        product: json["product"] == null
            ? []
            : List<Product>.from(
                json["product"]!.map((x) => Product.fromJson(x))),
      );
}
