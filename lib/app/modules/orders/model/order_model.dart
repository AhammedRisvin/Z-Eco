import '../../cart/model/get_cart_model.dart';

class OrdersModel {
  String? message;
  List<Cart>? response;
  String? currency;
  String? currencySymbol;

  OrdersModel({
    this.message,
    this.response,
    this.currency,
    this.currencySymbol,
  });

  factory OrdersModel.fromJson(Map<String, dynamic> json) => OrdersModel(
        message: json["message"],
        response: json["response"] == null
            ? []
            : List<Cart>.from(json["response"]!.map((x) => Cart.fromJson(x))),
        currency: json["currency"],
        currencySymbol: json["currencySymbol"],
      );
}
