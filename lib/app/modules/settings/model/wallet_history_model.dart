class GetWalletHistoryModel {
  String? message;
  String? currencyCode;
  String? currencySymbol;
  List<WalletDatum>? walletData;
  num? walletAmount;

  GetWalletHistoryModel({
    this.message,
    this.currencyCode,
    this.currencySymbol,
    this.walletData,
    this.walletAmount,
  });

  factory GetWalletHistoryModel.fromJson(Map<String, dynamic> json) =>
      GetWalletHistoryModel(
        message: json["message"],
        currencyCode: json["currencyCode"],
        currencySymbol: json["currencySymbol"],
        walletData: json["walletData"] == null
            ? []
            : List<WalletDatum>.from(
                json["walletData"]!.map((x) => WalletDatum.fromJson(x))),
        walletAmount: json["WalletAmount"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "currencyCode": currencyCode,
        "currencySymbol": currencySymbol,
        "walletData": walletData == null
            ? []
            : List<dynamic>.from(walletData!.map((x) => x.toJson())),
        "WalletAmount": walletAmount,
      };
}

class WalletDatum {
  String? id;
  String? userId;
  String? method;
  num? amount;
  String? appId;
  String? currency;
  String? countryCode;
  DateTime? createdAt;
  DateTime? updatedAt;
  num? v;

  WalletDatum({
    this.id,
    this.userId,
    this.method,
    this.appId,
    this.amount,
    this.currency,
    this.countryCode,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory WalletDatum.fromJson(Map<String, dynamic> json) => WalletDatum(
        id: json["_id"],
        userId: json["userId"],
        method: json["method"],
        appId: json["appId"],
        amount: json["amount"],
        currency: json["currency"],
        countryCode: json["countryCode"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "method": method,
        "appId": appId,
        "amount": amount,
        "currency": currency,
        "countryCode": countryCode,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}
