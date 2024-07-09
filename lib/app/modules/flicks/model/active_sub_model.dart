class GetFlicksActiveSubscriptionModel {
  bool? success;
  String? message;
  ActivePlan? activePlan;
  bool? currentPlan;

  GetFlicksActiveSubscriptionModel({
    this.success,
    this.message,
    this.activePlan,
    this.currentPlan,
  });

  factory GetFlicksActiveSubscriptionModel.fromJson(
          Map<String, dynamic> json) =>
      GetFlicksActiveSubscriptionModel(
        success: json["success"],
        message: json["message"],
        activePlan: json["activePlan"] == null
            ? null
            : ActivePlan.fromJson(json["activePlan"]),
        currentPlan: json["currentPlan"],
      );
}

class ActivePlan {
  String? name;
  DateTime? expiringDate;
  List<String>? description;

  ActivePlan({
    this.name,
    this.expiringDate,
    this.description,
  });

  factory ActivePlan.fromJson(Map<String, dynamic> json) => ActivePlan(
        name: json["name"],
        expiringDate: json["expiringDate"] == null
            ? null
            : DateTime.parse(json["expiringDate"]),
        description: json["description"] == null
            ? []
            : List<String>.from(json["description"]!.map((x) => x)),
      );
}
