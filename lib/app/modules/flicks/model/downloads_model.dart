import 'package:hive_flutter/hive_flutter.dart';

part 'downloads_model.g.dart';

@HiveType(typeId: 0)
class DownloadModel {
  @HiveField(0)
  String path;

  @HiveField(1)
  String image;

  @HiveField(2)
  String videoId;

  @HiveField(3)
  String duration;

  @HiveField(4)
  String name;

  @HiveField(5)
  String fileSize;

  DownloadModel({
    required this.path,
    required this.image,
    required this.videoId,
    required this.duration,
    required this.name,
    required this.fileSize,
  });
}
