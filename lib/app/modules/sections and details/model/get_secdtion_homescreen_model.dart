import 'dart:convert';

GetSectionHomeModel getSectionHomeModelFromJson(String str) =>
    GetSectionHomeModel.fromJson(json.decode(str));

String getSectionHomeModelToJson(GetSectionHomeModel data) =>
    json.encode(data.toJson());

class GetSectionHomeModel {
  bool? success;
  List<CategoryElement>? categories;
  Banners? banners;
  List<FilteredProduct>? filteredProducts;
  List<Product>? topDeals;
  List<TopBrand>? topBrands;

  GetSectionHomeModel({
    this.success,
    this.categories,
    this.banners,
    this.filteredProducts,
    this.topDeals,
    this.topBrands,
  });

  factory GetSectionHomeModel.fromJson(Map<String, dynamic> json) =>
      GetSectionHomeModel(
        success: json["success"],
        categories: json["categories"] == null
            ? []
            : List<CategoryElement>.from(
                json["categories"]!.map((x) => CategoryElement.fromJson(x))),
        banners:
            json["banners"] == null ? null : Banners.fromJson(json["banners"]),
        filteredProducts: json["filteredProducts"] == null
            ? []
            : List<FilteredProduct>.from(json["filteredProducts"]!
                .map((x) => FilteredProduct.fromJson(x))),
        topDeals: json["topDeals"] == null
            ? []
            : List<Product>.from(
                json["topDeals"]!.map((x) => Product.fromJson(x))),
        topBrands: json["topBrands"] == null
            ? []
            : List<TopBrand>.from(
                json["topBrands"]!.map((x) => TopBrand.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "categories": categories == null
            ? []
            : List<dynamic>.from(categories!.map((x) => x.toJson())),
        "banners": banners?.toJson(),
        "filteredProducts": filteredProducts == null
            ? []
            : List<dynamic>.from(filteredProducts!.map((x) => x.toJson())),
        "topDeals": topDeals == null
            ? []
            : List<dynamic>.from(topDeals!.map((x) => x.toJson())),
        "topBrands": topBrands == null
            ? []
            : List<dynamic>.from(topBrands!.map((x) => x.toJson())),
      };
}

class Banners {
  List<TopBanner>? topBanners;
  List<TopBanner>? bottomBanners;

  Banners({
    this.topBanners,
    this.bottomBanners,
  });

  factory Banners.fromJson(Map<String, dynamic> json) => Banners(
        topBanners: json["topBanners"] == null
            ? []
            : List<TopBanner>.from(
                json["topBanners"]!.map((x) => TopBanner.fromJson(x))),
        bottomBanners: json["bottomBanners"] == null
            ? []
            : List<TopBanner>.from(
                json["bottomBanners"]!.map((x) => TopBanner.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "topBanners": topBanners == null
            ? []
            : List<dynamic>.from(topBanners!.map((x) => x)),
        "bottomBanners": bottomBanners == null
            ? []
            : List<dynamic>.from(bottomBanners!.map((x) => x)),
      };
}

class TopBanner {
  String? image;
  TopBannerCategory? category;
  DateTime? validity;
  String? vendor;
  String? id;

  TopBanner({
    this.image,
    this.category,
    this.validity,
    this.vendor,
    this.id,
  });

  factory TopBanner.fromJson(Map<String, dynamic> json) => TopBanner(
        image: json["image"],
        category: json["category"] == null
            ? null
            : TopBannerCategory.fromJson(json["category"]),
        validity:
            json["validity"] == null ? null : DateTime.parse(json["validity"]),
        vendor: json["vendor"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "category": category?.toJson(),
        "validity": validity?.toIso8601String(),
        "vendor": vendor,
        "_id": id,
      };
}

class TopBannerCategory {
  String? id;
  String? name;

  TopBannerCategory({
    this.id,
    this.name,
  });

  factory TopBannerCategory.fromJson(Map<String, dynamic> json) =>
      TopBannerCategory(
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
      };
}

class CategoryElement {
  String? id;
  String? name;
  List<SubCategory>? subCategories;
  String? image;
  List<TopBrand>? brands;

  CategoryElement({
    this.id,
    this.name,
    this.subCategories,
    this.image,
    this.brands,
  });

  factory CategoryElement.fromJson(Map<String, dynamic> json) =>
      CategoryElement(
        id: json["_id"],
        name: json["name"],
        subCategories: json["subCategories"] == null
            ? []
            : List<SubCategory>.from(
                json["subCategories"]!.map((x) => SubCategory.fromJson(x))),
        image: json["image"],
        brands: json["brands"] == null
            ? []
            : List<TopBrand>.from(
                json["brands"]!.map((x) => TopBrand.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "subCategories": subCategories == null
            ? []
            : List<dynamic>.from(subCategories!.map((x) => x.toJson())),
        "image": image,
        "brands": brands == null
            ? []
            : List<dynamic>.from(brands!.map((x) => x.toJson())),
      };
}

class TopBrand {
  String? name;
  String? image;
  String? id;
  String? description;

  TopBrand({
    this.name,
    this.image,
    this.id,
    this.description,
  });

  factory TopBrand.fromJson(Map<String, dynamic> json) => TopBrand(
        name: json["name"],
        image: json["image"],
        id: json["_id"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "image": image,
        "_id": id,
        "description": description,
      };
}

class SubCategory {
  String? id;
  String? name;
  String? image;

  SubCategory({
    this.id,
    this.name,
    this.image,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
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

class FilteredProduct {
  num? offer;
  List<Product>? products;

  FilteredProduct({
    this.offer,
    this.products,
  });

  factory FilteredProduct.fromJson(Map<String, dynamic> json) =>
      FilteredProduct(
        offer: json["offer"],
        products: json["products"] == null
            ? []
            : List<Product>.from(
                json["products"]!.map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "offer": offer,
        "products": products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x.toJson())),
      };
}

class Product {
  Ratings? ratings;
  String? id;
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

  Product({
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
    this.link,
    this.wishlist,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        ratings:
            json["ratings"] == null ? null : Ratings.fromJson(json["ratings"]),
        id: json["_id"],
        productName: json["productName"],
        description: json["description"],
        brand: json["brand"],
        offers: json["offers"],
        images: json["images"] == null
            ? []
            : List<String>.from(json["images"].map((x) => x.toString())),
        section: json["section"],
        category: json["category"],
        price: json["price"],
        discountPrice: json["discountPrice"],
        currency: json["currency"],
        link: json["link"],
        wishlist: json["wishlist"],
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
