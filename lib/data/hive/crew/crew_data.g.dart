// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crew_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CrewResponseAdapter extends TypeAdapter<CrewResponse> {
  @override
  final int typeId = 4;

  @override
  CrewResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CrewResponse(
      id: fields[0] as String,
      firstName: fields[1] as String,
      lastName: fields[2] as String,
      email: fields[3] as String,
      role: fields[4] as String,
      createdAt: fields[5] as DateTime,
      updatedAt: fields[6] as DateTime,
      activeStatus: fields[7] as bool,
      password: fields[8] as String,
      status: fields[9] as bool,
      createdBy: fields[10] as String,
      verificationCode: fields[11] as int,
      verificationCodeExpiry: fields[12] as String,
      profilePhoto: fields[13] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CrewResponse obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.firstName)
      ..writeByte(2)
      ..write(obj.lastName)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.role)
      ..writeByte(5)
      ..write(obj.createdAt)
      ..writeByte(6)
      ..write(obj.updatedAt)
      ..writeByte(7)
      ..write(obj.activeStatus)
      ..writeByte(8)
      ..write(obj.password)
      ..writeByte(9)
      ..write(obj.status)
      ..writeByte(10)
      ..write(obj.createdBy)
      ..writeByte(11)
      ..write(obj.verificationCode)
      ..writeByte(12)
      ..write(obj.verificationCodeExpiry)
      ..writeByte(13)
      ..write(obj.profilePhoto);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CrewResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
