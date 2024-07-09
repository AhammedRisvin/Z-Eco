class GetHomeProductsModel {
  String? message;
  List<ProductDatum>? productData;
  String? currency;
  String? currencySymbol;

  GetHomeProductsModel({
    this.message,
    this.productData,
    this.currency,
    this.currencySymbol,
  });

  factory GetHomeProductsModel.fromJson(Map<String, dynamic> json) =>
      GetHomeProductsModel(
        message: json["message"],
        productData: json["productData"] == null
            ? []
            : List<ProductDatum>.from(
                json["productData"]!.map((x) => ProductDatum.fromJson(x))),
        currency: json["currency"],
        currencySymbol: json["currencySymbol"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "productData": productData == null
            ? []
            : List<dynamic>.from(productData!.map((x) => x.toJson())),
        "currency": currency,
        "currencySymbol": currencySymbol,
      };
}

class ProductDatum {
  String? id;
  String? productId;
  String? productName;
  String? description;
  String? link;
  List<String>? images;
  String? brand;
  num? offers;
  num? price;
  num? discountPrice;
  num? ratings;
  String? sectionId;
  String? sectionName;
  String? categoryId;
  String? categoryName;
  BrandInfo? brandInfo;
  bool? wishlist;

  ProductDatum({
    this.id,
    this.productId,
    this.productName,
    this.description,
    this.link,
    this.images,
    this.brand,
    this.offers,
    this.price,
    this.discountPrice,
    this.ratings,
    this.sectionId,
    this.sectionName,
    this.categoryId,
    this.categoryName,
    this.brandInfo,
    this.wishlist,
  });

  factory ProductDatum.fromJson(Map<String, dynamic> json) => ProductDatum(
        id: json["_id"],
        productId: json["productId"],
        productName: json["productName"],
        description: json["description"],
        link: json["link"],
        images: json["images"] == null
            ? []
            : List<String>.from(json["images"]!.map((x) => x)),
        brand: json["brand"],
        offers: json["offers"]?.toDouble(),
        price: json["price"],
        discountPrice: json["discountPrice"]?.toDouble(),
        ratings: json["ratings"],
        sectionId: json["sectionId"],
        sectionName: json["sectionName"],
        categoryId: json["categoryId"],
        categoryName: json["categoryName"],
        brandInfo: json["brandInfo"] == null
            ? null
            : BrandInfo.fromJson(json["brandInfo"]),
        wishlist: json["wishlist"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "productId": productId,
        "productName": productName,
        "description": description,
        "link": link,
        "images":
            images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "brand": brand,
        "offers": offers,
        "price": price,
        "discountPrice": discountPrice,
        "ratings": ratings,
        "sectionId": sectionId,
        "sectionName": sectionName,
        "categoryId": categoryId,
        "categoryName": categoryName,
        "brandInfo": brandInfo?.toJson(),
        "wishlist": wishlist,
      };
}

class BrandInfo {
  String? id;
  String? name;
  String? image;
  String? description;

  BrandInfo({
    this.id,
    this.name,
    this.image,
    this.description,
  });

  factory BrandInfo.fromJson(Map<String, dynamic> json) => BrandInfo(
        id: json["_id"],
        name: json["name"],
        image: json["image"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "image": image,
        "description": description,
      };
}
