class GetCouponsModel {
  bool? success;
  String? messaage;
  List<Coupon>? coupons;

  GetCouponsModel({
    this.success,
    this.messaage,
    this.coupons,
  });

  factory GetCouponsModel.fromJson(Map<String, dynamic> json) =>
      GetCouponsModel(
        success: json["success"],
        messaage: json["messaage"],
        coupons: json["coupons"] == null
            ? []
            : List<Coupon>.from(
                json["coupons"]!.map((x) => Coupon.fromJson(x))),
      );
}

class Coupon {
  MaximumCount? maximumCount;
  Validity? validity;
  CouponBy? couponBy;
  String? id;
  String? name;
  String? description;
  num? count;
  num? minPrice;
  num? discount;
  String? discountType;
  bool? activeStatus;
  List<dynamic>? availableCount;
  DateTime? createdAt;
  DateTime? updatedAt;
  num? v;
  bool? isAvailable;

  Coupon({
    this.maximumCount,
    this.validity,
    this.couponBy,
    this.id,
    this.name,
    this.description,
    this.count,
    this.minPrice,
    this.discount,
    this.discountType,
    this.activeStatus,
    this.availableCount,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.isAvailable,
  });

  factory Coupon.fromJson(Map<String, dynamic> json) => Coupon(
        maximumCount: json["maximumCount"] == null
            ? null
            : MaximumCount.fromJson(json["maximumCount"]),
        validity: json["validity"] == null
            ? null
            : Validity.fromJson(json["validity"]),
        couponBy: json["couponBy"] == null
            ? null
            : CouponBy.fromJson(json["couponBy"]),
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        count: json["count"],
        minPrice: json["minPrice"],
        discount: json["discount"],
        discountType: json["discountType"],
        activeStatus: json["activeStatus"],
        availableCount: json["availableCount"] == null
            ? []
            : List<dynamic>.from(json["availableCount"]!.map((x) => x)),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        isAvailable: json["isAvailable"],
      );
}

class CouponBy {
  String? id;
  String? role;

  CouponBy({
    this.id,
    this.role,
  });

  factory CouponBy.fromJson(Map<String, dynamic> json) => CouponBy(
        id: json["id"],
        role: json["role"],
      );
}

class MaximumCount {
  bool? isUnlimited;
  num? userCount;

  MaximumCount({
    this.isUnlimited,
    this.userCount,
  });

  factory MaximumCount.fromJson(Map<String, dynamic> json) => MaximumCount(
        isUnlimited: json["isUnlimited"],
        userCount: json["userCount"],
      );
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
}
