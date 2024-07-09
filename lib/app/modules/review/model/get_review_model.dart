import '../../sections and details/model/get_product_details_model.dart';

class GetReviewsModel {
  String? message;
  List<Review>? reviews;
  bool? hasPurchasedProduct;
  int? totalReview;
  double? totalAvg;
  RatingsCount? ratingsCount;

  GetReviewsModel({
    this.message,
    this.reviews,
    this.hasPurchasedProduct,
    this.totalReview,
    this.totalAvg,
    this.ratingsCount,
  });

  factory GetReviewsModel.fromJson(Map<String, dynamic> json) =>
      GetReviewsModel(
        message: json["message"],
        reviews: json["reviews"] == null
            ? []
            : List<Review>.from(
                json["reviews"]!.map((x) => Review.fromJson(x))),
        hasPurchasedProduct: json["hasPurchasedProduct"],
        totalReview: json["totalReview"],
        totalAvg: json["totalAvg"]?.toDouble(),
        ratingsCount: json["ratingsCount"] == null
            ? null
            : RatingsCount.fromJson(json["ratingsCount"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "reviews": reviews == null
            ? []
            : List<dynamic>.from(reviews!.map((x) => x.toJson())),
        "hasPurchasedProduct": hasPurchasedProduct,
        "totalReview": totalReview,
        "totalAvg": totalAvg,
        "ratingsCount": ratingsCount?.toJson(),
      };
}

class RatingsCount {
  int? the1;
  int? the2;
  int? the3;
  int? the4;
  int? the5;

  RatingsCount({
    this.the1,
    this.the2,
    this.the3,
    this.the4,
    this.the5,
  });

  factory RatingsCount.fromJson(Map<String, dynamic> json) => RatingsCount(
        the1: json["1"],
        the2: json["2"],
        the3: json["3"],
        the4: json["4"],
        the5: json["5"],
      );

  Map<String, dynamic> toJson() => {
        "1": the1,
        "2": the2,
        "3": the3,
        "4": the4,
        "5": the5,
      };
}

// class Review {
//   String? id;
//   DateTime? date;
//   List<String>? images;
//   int? rating;
//   String? review;
//   User? user;

//   Review({
//     this.id,
//     this.date,
//     this.images,
//     this.rating,
//     this.review,
//     this.user,
//   });

  


//   factory Review.fromJson(Map<String, dynamic> json) => Review(
//         id: json["_id"],
//         date: json["Date"] == null ? null : DateTime.parse(json["Date"]),
//         images: json["images"] == null
//             ? []
//             : List<String>.from(json["images"]!.map((x) => x)),
//         rating: json["rating"],
//         review: json["review"],
//         user: json["user"] == null ? null : User.fromJson(json["user"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "Date": date?.toIso8601String(),
//         "images":
//             images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
//         "rating": rating,
//         "review": review,
//         "user": user?.toJson(),
//       };
// }

// class User {
//   Image? image;
//   String? id;
//   String? name;

//   User({
//     this.image,
//     this.id,
//     this.name,
//   });

//   factory User.fromJson(Map<String, dynamic> json) => User(
//         image: json["image"] == null ? null : Image.fromJson(json["image"]),
//         id: json["_id"],
//         name: json["name"],
//       );

//   Map<String, dynamic> toJson() => {
//         "image": image?.toJson(),
//         "_id": id,
//         "name": name,
//       };
// }

// class Image {
//   String? url;

//   Image({
//     this.url,
//   });

//   factory Image.fromJson(Map<String, dynamic> json) => Image(
//         url: json["Url"],
//       );

//   Map<String, dynamic> toJson() => {
//         "Url": url,
//       };
// }
