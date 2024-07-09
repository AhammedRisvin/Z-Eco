class GetFlicksSubscriptionModel {
  bool? success;
  String? message;
  List<Membership>? memberships;
  num? walletAmount;
  FlicksMembership? flicksMembership;

  GetFlicksSubscriptionModel({
    this.success,
    this.message,
    this.memberships,
    this.walletAmount,
    this.flicksMembership,
  });

  factory GetFlicksSubscriptionModel.fromJson(Map<String, dynamic> json) =>
      GetFlicksSubscriptionModel(
        success: json["success"],
        message: json["message"],
        memberships: json["memberships"] == null
            ? []
            : List<Membership>.from(
                json["memberships"]!.map((x) => Membership.fromJson(x))),
        walletAmount: json["walletAmount"],
        flicksMembership: json["flicksMembership"] == null
            ? null
            : FlicksMembership.fromJson(json["flicksMembership"]),
      );
}

class Membership {
  bool? isDownloadable;
  String? id;
  String? name;
  List<String>? description;
  num? amount;
  num? offer;
  String? currency;

  Membership({
    this.id,
    this.name,
    this.description,
    this.amount,
    this.offer,
    this.currency,
    this.isDownloadable,
  });

  factory Membership.fromJson(Map<String, dynamic> json) => Membership(
        id: json["_id"],
        name: json["name"],
        description: json["description"] == null
            ? []
            : List<String>.from(json["description"]!.map((x) => x)),
        amount: json["amount"],
        offer: json["offer"],
        currency: json["currency"],
        isDownloadable: json["isDownloadable"],
      );
}

class FlicksMembership {
  bool? isMembership;
  DateTime? expires;
  String? membershipPlan;

  FlicksMembership({
    this.isMembership,
    this.expires,
    this.membershipPlan,
  });

  factory FlicksMembership.fromJson(Map<String, dynamic> json) =>
      FlicksMembership(
        isMembership: json["isMembership"],
        expires:
            json["expires"] == null ? null : DateTime.parse(json["expires"]),
        membershipPlan: json["membershipPlan"],
      );
}
