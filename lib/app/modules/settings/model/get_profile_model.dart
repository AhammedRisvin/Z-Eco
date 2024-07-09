class GetProfileModel {
  String? message;
  Profile? profile;

  GetProfileModel({
    this.message,
    this.profile,
  });

  factory GetProfileModel.fromJson(Map<String, dynamic> json) =>
      GetProfileModel(
        message: json["message"],
        profile:
            json["profile"] == null ? null : Profile.fromJson(json["profile"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "profile": profile?.toJson(),
      };
}

class Profile {
  String? profilePicture;
  String? name;
  String? email;
  String? userName;
  String? dialCode;
  String? countryCode;
  String? phone;
  String? adderss;
  String? city;
  String? state;
  dynamic pincode;

  Profile({
    this.profilePicture,
    this.name,
    this.email,
    this.userName,
    this.dialCode,
    this.countryCode,
    this.phone,
    this.adderss,
    this.city,
    this.state,
    this.pincode,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        profilePicture: json["profilePicture"],
        name: json["name"],
        email: json["email"],
        userName: json["userName"],
        dialCode: json["dialCode"],
        countryCode: json["countryCode"],
        phone: json["Phone"],
        adderss: json["adderss"],
        city: json["city"],
        state: json["state"],
        pincode: json["pincode"],
      );

  Map<String, dynamic> toJson() => {
        "profilePicture": profilePicture,
        "name": name,
        "email": email,
        "userName": userName,
        "dialCode": dialCode,
        "countryCode": countryCode,
        "Phone": phone,
        "adderss": adderss,
        "city": city,
        "state": state,
        "pincode": pincode,
      };
}
