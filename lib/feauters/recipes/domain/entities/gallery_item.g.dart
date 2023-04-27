// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gallery_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GalleryItemAdapter extends TypeAdapter<GalleryItem> {
  @override
  final int typeId = 5;

  @override
  GalleryItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GalleryItem(
      recipeId: fields[0] as String,
      resource: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, GalleryItem obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.recipeId)
      ..writeByte(1)
      ..write(obj.resource);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GalleryItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
