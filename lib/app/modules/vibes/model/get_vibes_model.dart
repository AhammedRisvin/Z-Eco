class GetVibesModel {
  String? message;
  List<VibesDatum>? vibesData;
  List<CategoryDatum>? categoryData;
  String? currency;
  String? currencySymbol;

  GetVibesModel({
    this.message,
    this.vibesData,
    this.categoryData,
    this.currency,
    this.currencySymbol,
  });

  factory GetVibesModel.fromJson(Map<String, dynamic> json) => GetVibesModel(
        message: json["message"],
        vibesData: json["vibesData"] == null
            ? []
            : List<VibesDatum>.from(
                json["vibesData"]!.map((x) => VibesDatum.fromJson(x))),
        categoryData: json["categoryData"] == null
            ? []
            : List<CategoryDatum>.from(
                json["categoryData"]!.map((x) => CategoryDatum.fromJson(x))),
        currency: json["currency"],
        currencySymbol: json["currencySymbol"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "vibesData": vibesData == null
            ? []
            : List<dynamic>.from(vibesData!.map((x) => x.toJson())),
        "categoryData": categoryData == null
            ? []
            : List<dynamic>.from(categoryData!.map((x) => x.toJson())),
        "currency": currency,
        "currencySymbol": currencySymbol,
      };
}

class CategoryDatum {
  String? id;
  String? name;
  String? image;

  CategoryDatum({
    this.id,
    this.name,
    this.image,
  });

  factory CategoryDatum.fromJson(Map<String, dynamic> json) => CategoryDatum(
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

class VibesDatum {
  String? id;
  String? videoUrl;
  String? imageUrl;
  List<Product>? products;

  VibesDatum({
    this.id,
    this.videoUrl,
    this.imageUrl,
    this.products,
  });

  factory VibesDatum.fromJson(Map<String, dynamic> json) => VibesDatum(
        id: json["_id"],
        videoUrl: json["videoUrl"],
        imageUrl: json["imageUrl"],
        products: json["products"] == null
            ? []
            : List<Product>.from(
                json["products"]!.map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "videoUrl": videoUrl,
        "imageUrl": imageUrl,
        "products": products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x.toJson())),
      };
}

class Product {
  String? productId;
  String? productName;
  List<String>? images;
  num? price;
  num? offers;
  num? discountPrice;
  num? ratings;
  String? size;
  String? sizeId;

  Product({
    this.productId,
    this.productName,
    this.images,
    this.price,
    this.offers,
    this.discountPrice,
    this.ratings,
    this.size,
    this.sizeId,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        productId: json["productId"],
        productName: json["productName"],
        images: json["images"] == null
            ? []
            : List<String>.from(json["images"]!.map((x) => x)),
        price: json["price"],
        offers: json["offers"],
        discountPrice: json["discountPrice"],
        ratings: json["ratings"],
        size: json["size"],
        sizeId: json["sizeId"],
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "productName": productName,
        "images":
            images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "price": price,
        "offers": offers,
        "discountPrice": discountPrice,
        "ratings": ratings,
        "size": size,
        "sizeId": sizeId,
      };
}
