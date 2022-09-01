// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'known_fact.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class KnownFactAdapter extends TypeAdapter<KnownFact> {
  @override
  final int typeId = 0;

  @override
  KnownFact read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return KnownFact()
      ..date = fields[0] as DateTime
      ..fact = fields[1] as String;
  }

  @override
  void write(BinaryWriter writer, KnownFact obj) {
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
      other is KnownFactAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
