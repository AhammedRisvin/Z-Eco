import 'get_secdtion_homescreen_model.dart';

class GetSectionProductModel {
  bool? success;
  String? message;
  List<Product>? products;
  num? totalProducts;

  GetSectionProductModel({
    this.success,
    this.message,
    this.products,
    this.totalProducts,
  });

  factory GetSectionProductModel.fromJson(Map<String, dynamic> json) =>
      GetSectionProductModel(
        success: json["success"],
        message: json["message"],
        products: json["products"] == null
            ? []
            : List<Product>.from(
                json["products"]!.map((x) => Product.fromJson(x))),
        totalProducts: json["totalProducts"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "products": products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x.toJson())),
        "totalProducts": totalProducts,
      };
}
