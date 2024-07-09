class OrdersProductDetailModel {
  String? message;
  List<OrderData>? orderDatas;
  ShippingAddress? shippingAddress;
  String? currency;
  String? currencySymbol;

  OrdersProductDetailModel({
    this.message,
    this.orderDatas,
    this.shippingAddress,
    this.currency,
    this.currencySymbol,
  });

  factory OrdersProductDetailModel.fromJson(Map<String, dynamic> json) =>
      OrdersProductDetailModel(
        message: json["message"],
        orderDatas: json["orderDatas"] == null
            ? []
            : List<OrderData>.from(
                json["orderDatas"]!.map((x) => OrderData.fromJson(x))),
        shippingAddress: json["shippingAddress"] == null
            ? null
            : ShippingAddress.fromJson(json["shippingAddress"]),
        currency: json["currency"],
        currencySymbol: json["currencySymbol"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "orderDatas": orderDatas == null
            ? []
            : List<dynamic>.from(orderDatas!.map((x) => x.toJson())),
        "shippingAddress": shippingAddress?.toJson(),
        "currency": currency,
        "currencySymbol": currencySymbol,
      };
}

class OrderData {
  String? orderId;
  List<Info>? shippingInfo;
  List<Info>? returnInfo;
  String? productName;
  String? productId;
  String? sizeId;
  String? bookingId;
  List<String>? productImage;
  String? size;
  num? price;
  String? shippingAddress;
  num? discount;
  String? orderStatus;
  num? quantity;
  num? shippingCharge;
  num? totalPrice;
  String? brandName;
  String? otp;

  OrderData({
    this.orderId,
    this.shippingInfo,
    this.returnInfo,
    this.productName,
    this.productId,
    this.sizeId,
    this.bookingId,
    this.productImage,
    this.size,
    this.price,
    this.shippingAddress,
    this.discount,
    this.orderStatus,
    this.quantity,
    this.shippingCharge,
    this.totalPrice,
    this.brandName,
    this.otp,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) => OrderData(
        orderId: json["orderId"],
        shippingInfo: json["shippingInfo"] == null
            ? []
            : List<Info>.from(
                json["shippingInfo"]!.map((x) => Info.fromJson(x))),
        returnInfo: json["returnInfo"] == null
            ? []
            : List<Info>.from(json["returnInfo"]!.map((x) => Info.fromJson(x))),
        productName: json["productName"],
        productId: json["productId"],
        sizeId: json["sizeId"],
        bookingId: json["bookingId"],
        productImage: json["productImage"] == null
            ? []
            : List<String>.from(json["productImage"]!.map((x) => x)),
        size: json["size"],
        price: json["price"],
        shippingAddress: json["shippingAddress"],
        discount: json["discount"],
        orderStatus: json["orderStatus"],
        quantity: json["quantity"],
        shippingCharge: json["shippingCharge"],
        totalPrice: json["totalPrice"],
        brandName: json["brandName"],
        otp: json["otp"],
      );

  Map<String, dynamic> toJson() => {
        "orderId": orderId,
        "shippingInfo": shippingInfo == null
            ? []
            : List<dynamic>.from(shippingInfo!.map((x) => x.toJson())),
        "returnInfo": returnInfo == null
            ? []
            : List<dynamic>.from(returnInfo!.map((x) => x.toJson())),
        "productName": productName,
        "productId": productId,
        "sizeId": sizeId,
        "bookingId": bookingId,
        "productImage": productImage == null
            ? []
            : List<dynamic>.from(productImage!.map((x) => x)),
        "size": size,
        "price": price,
        "shippingAddress": shippingAddress,
        "discount": discount,
        "orderStatus": orderStatus,
        "quantity": quantity,
        "shippingCharge": shippingCharge,
        "totalPrice": totalPrice,
        "brandName": brandName,
        "otp": otp,
      };
}

class Info {
  String? status;
  DateTime? date;
  dynamic message;
  String? id;

  Info({
    this.status,
    this.date,
    this.message,
    this.id,
  });

  factory Info.fromJson(Map<String, dynamic> json) => Info(
        status: json["status"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        message: json["message"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "date": date?.toIso8601String(),
        "message": message,
        "_id": id,
      };
}

class ShippingAddress {
  String? name;
  String? phone;
  String? address;
  String? city;
  String? state;
  String? pincode;
  String? addressType;
  bool? isDelete;
  String? id;

  ShippingAddress({
    this.name,
    this.phone,
    this.address,
    this.city,
    this.state,
    this.pincode,
    this.addressType,
    this.isDelete,
    this.id,
  });

  factory ShippingAddress.fromJson(Map<String, dynamic> json) =>
      ShippingAddress(
        name: json["name"],
        phone: json["phone"],
        address: json["address"],
        city: json["city"],
        state: json["state"],
        pincode: json["pincode"],
        addressType: json["addressType"],
        isDelete: json["isDelete"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phone,
        "address": address,
        "city": city,
        "state": state,
        "pincode": pincode,
        "addressType": addressType,
        "isDelete": isDelete,
        "_id": id,
      };
}
