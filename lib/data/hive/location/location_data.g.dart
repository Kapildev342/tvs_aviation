// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocationResponseAdapter extends TypeAdapter<LocationResponse> {
  @override
  final int typeId = 2;

  @override
  LocationResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocationResponse(
      id: fields[0] as String,
      name: fields[1] as String,
      type: fields[2] as String,
      createdAt: fields[3] as String,
      updatedAt: fields[4] as String,
      activeStatus: fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, LocationResponse obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.createdAt)
      ..writeByte(4)
      ..write(obj.updatedAt)
      ..writeByte(5)
      ..write(obj.activeStatus);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocationResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
