// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sector_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SectorResponseAdapter extends TypeAdapter<SectorResponse> {
  @override
  final int typeId = 5;

  @override
  SectorResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SectorResponse(
      id: fields[0] as String,
      icao: fields[1] as String,
      iata: fields[2] as String,
      airportName: fields[3] as String,
      city: fields[4] as String,
      createdAt: fields[6] as DateTime,
      updatedAt: fields[7] as DateTime,
      activeStatus: fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, SectorResponse obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.icao)
      ..writeByte(2)
      ..write(obj.iata)
      ..writeByte(3)
      ..write(obj.airportName)
      ..writeByte(4)
      ..write(obj.city)
      ..writeByte(5)
      ..write(obj.activeStatus)
      ..writeByte(6)
      ..write(obj.createdAt)
      ..writeByte(7)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SectorResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
