import 'package:hive/hive.dart';
part 'crew_data.g.dart';

@HiveType(typeId: 4)
class CrewResponse extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String firstName;

  @HiveField(2)
  late String lastName;

  @HiveField(3)
  late String email;

  @HiveField(4)
  late String role;

  @HiveField(5)
  late DateTime createdAt;

  @HiveField(6)
  late DateTime updatedAt;

  @HiveField(7)
  late bool activeStatus;

  @HiveField(8)
  late String password;

  @HiveField(9)
  late bool status;

  @HiveField(10)
  late String createdBy;

  @HiveField(11)
  late int verificationCode;

  @HiveField(12)
  late String verificationCodeExpiry;

  @HiveField(13)
  late String profilePhoto;

  CrewResponse({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
    required this.activeStatus,
    required this.password,
    required this.status,
    required this.createdBy,
    required this.verificationCode,
    required this.verificationCodeExpiry,
    required this.profilePhoto,
  });

  factory CrewResponse.fromJson(Map<String, dynamic> json) => CrewResponse(
        id: json["_id"] ?? "",
        firstName: json["firstName"] ?? '',
        lastName: json["lastName"] ?? '',
        email: json["email"] ?? '',
        password: json["password"] ?? "",
        role: json["role"] ?? "",
        createdAt: json["createdAt"] == null ? DateTime.now() : DateTime.parse("${json["createdAt"]}"),
        updatedAt: json["updatedAt"] == null ? DateTime.now() : DateTime.parse("${json["updatedAt"]}"),
        activeStatus: json["activeStatus"] ?? false,
        status: json["status"] ?? false,
        createdBy: json["createdBy"] ?? '',
        verificationCode: json["verificationCode"] ?? 0,
        verificationCodeExpiry: json["verificationCodeExpiry"] ?? "",
        profilePhoto: json["profilePhoto"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "password": password,
        "role": role,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "activeStatus": activeStatus,
        "status": status,
        "createdBy": createdBy,
        "verificationCode": verificationCode,
        "verificationCodeExpiry": verificationCodeExpiry,
        "profilePhoto": profilePhoto,
      };
}
