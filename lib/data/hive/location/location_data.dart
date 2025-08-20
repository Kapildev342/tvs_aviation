import 'package:hive/hive.dart';
part 'location_data.g.dart';

@HiveType(typeId: 2)
class LocationResponse extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String name;

  @HiveField(2)
  late String type;

  @HiveField(3)
  late String createdAt;

  @HiveField(4)
  late String updatedAt;

  @HiveField(5)
  late bool activeStatus;

  LocationResponse({
    required this.id,
    required this.name,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
    required this.activeStatus,
  });

  factory LocationResponse.fromJson(Map<String, dynamic> json) => LocationResponse(
        id: json["_id"] ?? '',
        name: json["name"] ?? '',
        type: json["type"] ?? '',
        createdAt: json["createdAt"] ?? '',
        updatedAt: json["updatedAt"] ?? '',
        activeStatus: json["activeStatus"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "type": type,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "activeStatus": activeStatus,
      };
}
