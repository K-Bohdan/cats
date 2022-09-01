// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_fact.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavoriteFactAdapter extends TypeAdapter<FavoriteFact> {
  @override
  final int typeId = 1;

  @override
  FavoriteFact read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavoriteFact()
      ..date = fields[0] as DateTime
      ..fact = fields[1] as String;
  }

  @override
  void write(BinaryWriter writer, FavoriteFact obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.fact);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoriteFactAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
