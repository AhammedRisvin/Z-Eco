import '../../home/model/get_homeproduct_model.dart';

class GetDealsModel {
  String? message;
  List<BigSaving>? bigSavings;
  List<Sections>? sections;
  List<DealsBanner>? dealsBanner;
  List<BigSaving>? recommendedProducts;
  List<BigSaving>? specialDeals;

  GetDealsModel({
    this.message,
    this.bigSavings,
    this.sections,
    this.dealsBanner,
    this.recommendedProducts,
    this.specialDeals,
  });

  factory GetDealsModel.fromJson(Map<String, dynamic> json) => GetDealsModel(
        message: json["message"],
        bigSavings: json["bigSavings"] == null
            ? []
            : List<BigSaving>.from(
                json["bigSavings"]!.map((x) => BigSaving.fromJson(x))),
        sections: json["sections"] == null
            ? []
            : List<Sections>.from(
                json["sections"]!.map((x) => Sections.fromJson(x))),
        dealsBanner: json["dealsBanner"] == null
            ? []
            : List<DealsBanner>.from(
                json["dealsBanner"]!.map((x) => DealsBanner.fromJson(x))),
        recommendedProducts: json["recommendedProducts"] == null
            ? []
            : List<BigSaving>.from(
                json["recommendedProducts"]!.map((x) => BigSaving.fromJson(x))),

        specialDeals: json["specialDeals"] == null
            ? []
            : List<BigSaving>.from(
                json["specialDeals"]!.map((x) => BigSaving.fromJson(x))),

        // specialDeals: json["specialDeals"] == null
        //     ? []
        //     : List<SpecialDeal>.from(
        //         json["specialDeals"]!.map((x) => SpecialDeal.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "bigSavings": bigSavings == null
            ? []
            : List<dynamic>.from(bigSavings!.map((x) => x.toJson())),
        "sections": sections == null
            ? []
            : List<dynamic>.from(sections!.map((x) => x.toJson())),
        "dealsBanner": dealsBanner == null
            ? []
            : List<dynamic>.from(dealsBanner!.map((x) => x.toJson())),
        "recommendedProducts": recommendedProducts == null
            ? []
            : List<dynamic>.from(recommendedProducts!.map((x) => x.toJson())),
        "specialDeals": specialDeals == null
            ? []
            : List<dynamic>.from(specialDeals!.map((x) => x.toJson())),
      };
}

class SpecialDeal {
  Validity? validity;
  BigSaving? product;
  num? offer;
  bool? active;
  String? id;
  bool? wishlist;

  SpecialDeal({
    this.validity,
    this.product,
    this.offer,
    this.active,
    this.id,
    this.wishlist,
  });

  factory SpecialDeal.fromJson(Map<String, dynamic> json) => SpecialDeal(
        validity: json["validity"] == null
            ? null
            : Validity.fromJson(json["validity"]),
        product: json["product"] == null
            ? null
            : BigSaving.fromJson(json["product"]),
        offer: json["offer"],
        active: json["active"],
        id: json["_id"],
        wishlist: json["wishlist"],
      );

  Map<String, dynamic> toJson() => {
        "validity": validity?.toJson(),
        "product": product?.toJson(),
        "offer": offer,
        "active": active,
        "_id": id,
        "wishlist": wishlist,
      };
}

class Validity {
  DateTime? startDate;
  DateTime? endDate;

  Validity({
    this.startDate,
    this.endDate,
  });

  factory Validity.fromJson(Map<String, dynamic> json) => Validity(
        startDate: json["startDate"] == null
            ? null
            : DateTime.parse(json["startDate"]),
        endDate:
            json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
      );

  Map<String, dynamic> toJson() => {
        "startDate": startDate?.toIso8601String(),
        "endDate": endDate?.toIso8601String(),
      };
}

class BigSaving {
  Ratings? ratings;
  String? id;
  String? productId;
  String? productName;
  String? description;
  String? brand;
  num? offers;
  List<String>? images;
  String? section;
  String? category;
  num? price;
  num? discountPrice;
  String? currency;
  String? link;
  bool? wishlist;
  BrandInfo? brandInfo;

  BigSaving({
    this.ratings,
    this.id,
    this.productId,
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
    this.link,
    this.wishlist,
    this.brandInfo,
  });

  factory BigSaving.fromJson(Map<String, dynamic> json) => BigSaving(
        ratings:
            json["ratings"] == null ? null : Ratings.fromJson(json["ratings"]),
        id: json["_id"],
        productName: json["productName"],
        productId: json["productId"],
        description: json["description"],
        brand: json["brand"],
        offers: json["offers"],
        images: json["images"] == null
            ? []
            : List<String>.from(json["images"]!.map((x) => x)),
        section: json["section"],
        category: json["category"],
        price: json["price"],
        discountPrice: json["discountPrice"],
        currency: json["currency"],
        link: json["link"],
        wishlist: json["wishlist"],
        brandInfo: json["brandInfo"] == null
            ? null
            : BrandInfo.fromJson(json["brandInfo"]),
      );

  Map<String, dynamic> toJson() => {
        "ratings": ratings?.toJson(),
        "_id": id,
        "productName": productName,
        "description": description,
        "brand": brand,
        "offers": offers,
        "images":
            images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "section": section,
        "category": category,
        "price": price,
        "discountPrice": discountPrice,
        "currency": currency,
        "link": link,
        "wishlist": wishlist,
        "brandInfo": brandInfo?.toJson(),
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

class DealsBanner {
  String? id;
  String? appId;
  String? image;

  DealsBanner({
    this.id,
    this.appId,
    this.image,
  });

  factory DealsBanner.fromJson(Map<String, dynamic> json) => DealsBanner(
        id: json["_id"],
        appId: json["appId"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "appId": appId,
        "image": image,
      };
}

class Sections {
  String? id;
  String? name;
  String? image;

  Sections({
    this.id,
    this.name,
    this.image,
  });

  factory Sections.fromJson(Map<String, dynamic> json) => Sections(
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
