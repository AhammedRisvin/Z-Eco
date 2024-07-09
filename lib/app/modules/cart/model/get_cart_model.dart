class GetCartModel {
  String? message;
  num? walletAmount;
  String? currency;
  CartData? cartData;

  GetCartModel({
    this.message,
    this.walletAmount,
    this.currency,
    this.cartData,
  });

  factory GetCartModel.fromJson(Map<String, dynamic> json) => GetCartModel(
        message: json["message"],
        walletAmount: json["walletAmount"],
        currency: json["currency"],
        cartData: json["cartData"] == null
            ? null
            : CartData.fromJson(json["cartData"]),
      );
}

class CartData {
  String? id;
  List<Cart>? cart;
  num? totalPrice;
  num? totalItem;
  num? shippingCharge;
  num? totalDiscount;
  num? totalSubTotal;

  CartData({
    this.id,
    this.cart,
    this.totalPrice,
    this.totalItem,
    this.shippingCharge,
    this.totalDiscount,
    this.totalSubTotal,
  });

  factory CartData.fromJson(Map<String, dynamic> json) => CartData(
        id: json["_id"],
        cart: json["cart"] == null
            ? []
            : List<Cart>.from(json["cart"]!.map((x) => Cart.fromJson(x))),
        totalPrice: json["totalPrice"],
        totalItem: json["totalItem"],
        shippingCharge: json["shippingCharge"],
        totalDiscount: json["totalDiscount"],
        totalSubTotal: json["totalSubTotal"],
      );
}

class Cart {
  String? bookingId;
  String? productId;
  String? productName;
  List<String>? images;
  String? size;
  num? pricePerItem;
  String? sizeId;
  num? quantity;
  num? price;
  num? availableQuantity;
  bool? isAvailable;
  num? discount;
  num? total;
  String? orderStatus;
  DateTime? createdAt;
  String? productLink;
  List<Info>? shippingInfo;
  List<Info>? returnInfo;
  bool? isReturn;
  String? brandName;

  Cart({
    this.bookingId,
    this.productId,
    this.productName,
    this.images,
    this.size,
    this.pricePerItem,
    this.sizeId,
    this.quantity,
    this.price,
    this.availableQuantity,
    this.isAvailable,
    this.discount,
    this.total,
    this.orderStatus,
    this.createdAt,
    this.productLink,
    this.shippingInfo,
    this.returnInfo,
    this.isReturn,
    this.brandName,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        bookingId: json["bookingId"],
        productId: json["productId"],
        productName: json["productName"],
        images: json["images"] == null
            ? []
            : List<String>.from(json["images"]!.map((x) => x)),
        size: json["size"],
        pricePerItem: json["pricePerItem"],
        sizeId: json["sizeId"],
        quantity: json["quantity"],
        price: json["price"],
        shippingInfo: json["shippingInfo"] == null
            ? []
            : List<Info>.from(
                json["shippingInfo"]!.map((x) => Info.fromJson(x))),
        availableQuantity: json["availableQuantity"],
        isAvailable: json["isAvailable"],
        productLink: json["productLink"],
        discount: json["discount"],
        total: json["total"],
        orderStatus: json["orderStatus"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        isReturn: json["isReturn"],
        returnInfo: json["returnInfo"] == null
            ? []
            : List<Info>.from(json["returnInfo"]!.map((x) => Info.fromJson(x))),
        brandName: json["brandName"],
      );
}

class Info {
  String? status;
  DateTime? date;
  String? id;
  String? message;

  Info({
    this.status,
    this.date,
    this.id,
    this.message,
  });

  factory Info.fromJson(Map<String, dynamic> json) => Info(
        status: json["status"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        id: json["_id"],
        message: json["message"],
      );
}
