class GetImageUpload {
  String? message;
  List<ImageData>? imageDatas;

  GetImageUpload({
    this.message,
    this.imageDatas,
  });

  factory GetImageUpload.fromJson(Map<String, dynamic> json) => GetImageUpload(
        message: json["message"],
        imageDatas: json["imageDatas"] == null
            ? []
            : List<ImageData>.from(
                json["imageDatas"]!.map((x) => ImageData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "imageDatas": imageDatas == null
            ? []
            : List<dynamic>.from(imageDatas!.map((x) => x.toJson())),
      };
}

class ImageData {
  String? imageUrl;
  String? hash;
  String? uniqueName;
  String? fieldName;

  ImageData({
    this.imageUrl,
    this.hash,
    this.uniqueName,
    this.fieldName,
  });

  factory ImageData.fromJson(Map<String, dynamic> json) => ImageData(
        imageUrl: json["imageUrl"],
        hash: json["hash"],
        uniqueName: json["uniqueName"],
        fieldName: json["fieldName"],
      );

  Map<String, dynamic> toJson() => {
        "imageUrl": imageUrl,
        "hash": hash,
        "uniqueName": uniqueName,
        "fieldName": fieldName,
      };
}
