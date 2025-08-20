import 'package:hive/hive.dart';
part 'stock_type_data.g.dart';

@HiveType(typeId: 3)
class StockTypeResponse extends HiveObject {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late String id;

  StockTypeResponse({
    required this.name,
    required this.id,
  });

  factory StockTypeResponse.fromJson(Map<String, dynamic> json) => StockTypeResponse(
        name: json["name"] ?? "",
        id: json["_id"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "_id": id,
      };
}
