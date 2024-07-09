// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'downloads_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DownloadModelAdapter extends TypeAdapter<DownloadModel> {
  @override
  final int typeId = 0;

  @override
  DownloadModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DownloadModel(
      path: fields[0] as String,
      image: fields[1] as String,
      videoId: fields[2] as String,
      duration: fields[3] as String,
      name: fields[4] as String,
      fileSize: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DownloadModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.path)
      ..writeByte(1)
      ..write(obj.image)
      ..writeByte(2)
      ..write(obj.videoId)
      ..writeByte(3)
      ..write(obj.duration)
      ..writeByte(4)
      ..write(obj.name)
      ..writeByte(5)
      ..write(obj.fileSize);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DownloadModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
