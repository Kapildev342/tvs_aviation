// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'handler_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HandlerResponseAdapter extends TypeAdapter<HandlerResponse> {
  @override
  final int typeId = 6;

  @override
  HandlerResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HandlerResponse(
      id: fields[0] as String,
      name: fields[1] as String,
      activeStatus: fields[2] as bool,
      createdAt: fields[3] as String,
      updatedAt: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HandlerResponse obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.activeStatus)
      ..writeByte(3)
      ..write(obj.createdAt)
      ..writeByte(4)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HandlerResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
