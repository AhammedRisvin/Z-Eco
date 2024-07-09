// To parse this JSON data, do
//
//     final serchModel = serchModelFromJson(jsonString);

import '../../sections and details/model/get_secdtion_homescreen_model.dart';

class SerchModel {
  bool? success;
  String? message;
  List<Product>? products;
  int? totalProducts;

  SerchModel({
    this.success,
    this.message,
    this.products,
    this.totalProducts,
  });

  factory SerchModel.fromJson(Map<String, dynamic> json) => SerchModel(
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

// class Product {
//   Ratings? ratings;
//   String? id;
//   String? productName;
//   String? description;
//   String? brand;
//   int? offers;
//   List<String>? images;
//   String? section;
//   String? category;
//   int? price;
//   int? discountPrice;
//   String? link;
//   String? currency;
//   bool? wishlist;

//   Product({
//     this.ratings,
//     this.id,
//     this.productName,
//     this.description,
//     this.brand,
//     this.offers,
//     this.images,
//     this.section,
//     this.category,
//     this.price,
//     this.discountPrice,
//     this.link,
//     this.currency,
//     this.wishlist,
//   });

//   factory Product.fromJson(Map<String, dynamic> json) => Product(
//         ratings:
//             json["ratings"] == null ? null : Ratings.fromJson(json["ratings"]),
//         id: json["_id"],
//         productName: json["productName"],
//         description: json["description"],
//         brand: json["brand"],
//         offers: json["offers"],
//         images: json["images"] == null
//             ? []
//             : List<String>.from(json["images"]!.map((x) => x)),
//         section: json["section"],
//         category: json["category"],
//         price: json["price"],
//         discountPrice: json["discountPrice"],
//         link: json["link"],
//         currency: json["currency"],
//         wishlist: json["wishlist"],
//       );

//   Map<String, dynamic> toJson() => {
//         "ratings": ratings?.toJson(),
//         "_id": id,
//         "productName": productName,
//         "description": description,
//         "brand": brand,
//         "offers": offers,
//         "images":
//             images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
//         "section": section,
//         "category": category,
//         "price": price,
//         "discountPrice": discountPrice,
//         "link": link,
//         "currency": currency,
//         "wishlist": wishlist,
//       };
// }

// class Ratings {
//   int? average;

//   Ratings({
//     this.average,
//   });

//   factory Ratings.fromJson(Map<String, dynamic> json) => Ratings(
//         average: json["average"],
//       );

//   Map<String, dynamic> toJson() => {
//         "average": average,
//       };
// }
