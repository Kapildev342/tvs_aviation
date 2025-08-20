import 'package:hive/hive.dart';
part 'handler_data.g.dart';

@HiveType(typeId: 6)
class HandlerResponse extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String name;

  @HiveField(2)
  late bool activeStatus;

  @HiveField(3)
  late String createdAt;

  @HiveField(4)
  late String updatedAt;

  HandlerResponse({
    required this.id,
    required this.name,
    required this.activeStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  factory HandlerResponse.fromJson(Map<String, dynamic> json) => HandlerResponse(
        id: json["_id"] ?? "",
        name: json["name"] ?? '',
        activeStatus: json["activeStatus"] ?? false,
        createdAt: json["createdAt"] ?? "",
        updatedAt: json["updatedAt"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "activeStatus": activeStatus,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}
