import 'get_secdtion_homescreen_model.dart';

class GetProductDetailsModel {
  bool? success;
  String? message;
  ProductDetails? product;
  List<Product>? relatedProducts;

  GetProductDetailsModel({
    this.success,
    this.message,
    this.product,
    this.relatedProducts,
  });

  factory GetProductDetailsModel.fromJson(Map<String, dynamic> json) =>
      GetProductDetailsModel(
        success: json["success"],
        message: json["message"],
        product: json["product"] == null
            ? null
            : ProductDetails.fromJson(json["product"]),
        relatedProducts: json["relatedProducts"] == null
            ? []
            : List<Product>.from(
                json["relatedProducts"]!.map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "product": product?.toJson(),
        "relatedProducts": relatedProducts == null
            ? []
            : List<dynamic>.from(relatedProducts!.map((x) => x.toJson())),
      };
}

class ProductDetails {
  Available? available;
  Ratings? ratings;
  String? id;
  String? productName;
  String? description;
  String? brand;
  num? offers;
  List<String>? images;
  Section? section;
  String? category;
  num? price;
  num? discountPrice;
  String? currency;
  List<Variant>? variants;
  List<Detail>? details;
  List<Specification>? specifications;
  String? returnPolicy;
  List<Review>? reviews;
  List<Viewer>? viewers;
  String? link;
  BrandInfo? brandInfo;
  bool? wishlist;
  bool? cart;

  ProductDetails({
    this.available,
    this.ratings,
    this.id,
    this.productName,
    this.description,
    this.brand,
    this.offers,
    this.images,
    this.section,
    this.category,
    this.price,
    this.discountPrice,
    this.currency,
    this.variants,
    this.details,
    this.specifications,
    this.returnPolicy,
    this.reviews,
    this.viewers,
    this.link,
    this.brandInfo,
    this.wishlist,
    this.cart,
  });

  factory ProductDetails.fromJson(Map<String, dynamic> json) => ProductDetails(
        available: json["available"] == null
            ? null
            : Available.fromJson(json["available"]),
        ratings:
            json["ratings"] == null ? null : Ratings.fromJson(json["ratings"]),
        id: json["_id"],
        productName: json["productName"],
        description: json["description"],
        brand: json["brand"],
        offers: json["offers"],
        images: json["images"] == null
            ? []
            : List<String>.from(json["images"]!.map((x) => x)),
        section:
            json["section"] == null ? null : Section.fromJson(json["section"]),
        category: json["category"],
        price: json["price"],
        discountPrice: json["discountPrice"],
        currency: json["currency"],
        variants: json["variants"] == null
            ? []
            : List<Variant>.from(
                json["variants"]!.map((x) => Variant.fromJson(x))),
        details: json["details"] == null
            ? []
            : List<Detail>.from(
                json["details"]!.map((x) => Detail.fromJson(x))),
        specifications: json["specifications"] == null
            ? []
            : List<Specification>.from(
                json["specifications"]!.map((x) => Specification.fromJson(x))),
        returnPolicy: json["returnPolicy"],
        reviews: json["reviews"] == null
            ? []
            : List<Review>.from(
                json["reviews"]!.map((x) => Review.fromJson(x))),
        viewers: json["viewers"] == null
            ? []
            : List<Viewer>.from(
                json["viewers"]!.map((x) => Viewer.fromJson(x))),
        link: json["link"],
        brandInfo: json["brandInfo"] == null
            ? null
            : BrandInfo.fromJson(json["brandInfo"]),
        wishlist: json["wishlist"],
        cart: json["cart"],
      );

  Map<String, dynamic> toJson() => {
        "available": available?.toJson(),
        "ratings": ratings?.toJson(),
        "_id": id,
        "productName": productName,
        "description": description,
        "brand": brand,
        "offers": offers,
        "images":
            images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "section": section?.toJson(),
        "category": category,
        "price": price,
        "discountPrice": discountPrice,
        "currency": currency,
        "variants": variants == null
            ? []
            : List<dynamic>.from(variants!.map((x) => x.toJson())),
        "details": details == null
            ? []
            : List<dynamic>.from(details!.map((x) => x.toJson())),
        "specifications": specifications == null
            ? []
            : List<dynamic>.from(specifications!.map((x) => x.toJson())),
        "returnPolicy": returnPolicy,
        "reviews":
            reviews == null ? [] : List<dynamic>.from(reviews!.map((x) => x)),
        "viewers": viewers == null
            ? []
            : List<dynamic>.from(viewers!.map((x) => x.toJson())),
        "link": link,
        "brandInfo": brandInfo?.toJson(),
        "wishlist": wishlist,
        "cart": cart,
      };
}

class Available {
  bool? isAll;
  List<dynamic>? countries;

  Available({
    this.isAll,
    this.countries,
  });

  factory Available.fromJson(Map<String, dynamic> json) => Available(
        isAll: json["isAll"],
        countries: json["countries"] == null
            ? []
            : List<dynamic>.from(json["countries"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "isAll": isAll,
        "countries": countries == null
            ? []
            : List<dynamic>.from(countries!.map((x) => x)),
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

class Detail {
  num? quantity;
  num? price;
  String? size;
  String? id;

  Detail({
    this.quantity,
    this.price,
    this.size,
    this.id,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        quantity: json["quantity"],
        price: json["price"],
        size: json["size"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "quantity": quantity,
        "price": price,
        "size": size,
        "_id": id,
      };
}

class Ratings {
  num? average;
  num? count;

  Ratings({
    this.average,
    this.count,
  });

  factory Ratings.fromJson(Map<String, dynamic> json) => Ratings(
        average: json["average"],
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "average": average,
        "count": count,
      };
}

class Section {
  String? id;
  String? name;

  Section({
    this.id,
    this.name,
  });

  factory Section.fromJson(Map<String, dynamic> json) => Section(
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
      };
}

class Specification {
  String? key;
  String? value;

  Specification({
    this.key,
    this.value,
  });

  factory Specification.fromJson(Map<String, dynamic> json) => Specification(
        key: json["key"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "value": value,
      };
}

class Variant {
  String? id;
  List<String>? images;
  String? link;

  Variant({
    this.id,
    this.images,
    this.link,
  });

  factory Variant.fromJson(Map<String, dynamic> json) => Variant(
        id: json["_id"],
        images: json["images"] == null
            ? []
            : List<String>.from(json["images"]!.map((x) => x)),
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "images":
            images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "link": link,
      };
}

class Review {
  User? user;
  num? rating;
  String? review;
  List<String>? images;
  DateTime? date;
  String? id;

  Review({
    this.user,
    this.rating,
    this.review,
    this.images,
    this.date,
    this.id,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        rating: json["rating"],
        review: json["review"],
        images: json["images"] == null
            ? []
            : List<String>.from(json["images"]!.map((x) => x)),
        date: json["Date"] == null ? null : DateTime.parse(json["Date"]),
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "rating": rating,
        "review": review,
        "images":
            images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "Date": date?.toIso8601String(),
        "_id": id,
      };
}

class User {
  Details? details;
  String? id;
  String? name;

  User({
    this.details,
    this.id,
    this.name,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        details:
            json["details"] == null ? null : Details.fromJson(json["details"]),
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "details": details?.toJson(),
        "_id": id,
        "name": name,
      };
}

class Details {
  String? profilePicture;

  Details({
    this.profilePicture,
  });

  factory Details.fromJson(Map<String, dynamic> json) => Details(
        profilePicture: json["profilePicture"],
      );

  Map<String, dynamic> toJson() => {
        "profilePicture": profilePicture,
      };
}

class Viewer {
  String? user;
  num? viewCount;
  String? id;

  Viewer({
    this.user,
    this.viewCount,
    this.id,
  });

  factory Viewer.fromJson(Map<String, dynamic> json) => Viewer(
        user: json["user"],
        viewCount: json["viewCount"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "viewCount": viewCount,
        "_id": id,
      };
}
