import 'package:hive/hive.dart';
part 'user_data.g.dart';

@HiveType(typeId: 0)
class UserResponse extends HiveObject {
  @HiveField(0)
  late String token;

  @HiveField(1)
  late User user;

  @HiveField(2)
  late bool status;

  UserResponse({
    required this.token,
    required this.user,
    required this.status,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        token: json["token"] ?? '',
        user: User.fromJson(json["user"] ?? {}),
        status: json["status"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "user": user.toJson(),
        "status": status,
      };
}

@HiveType(typeId: 1)
class User extends HiveObject {
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
  late int verificationCode;

  @HiveField(9)
  late DateTime verificationCodeExpiry;

  @HiveField(10)
  late String profilePhoto;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
    required this.activeStatus,
    required this.verificationCode,
    required this.verificationCodeExpiry,
    required this.profilePhoto,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
      id: json["_id"] ?? '',
      firstName: json["firstName"] ?? '',
      lastName: json["lastName"] ?? '',
      email: json["email"] ?? '',
      role: json["role"] ?? '',
      createdAt: json["createdAt"] == null ? DateTime.now() : DateTime.parse("${json["createdAt"]}"),
      updatedAt: json["updatedAt"] == null ? DateTime.now() : DateTime.parse("${json["updatedAt"]}"),
      activeStatus: json["activeStatus"] ?? false,
      verificationCode: json["verificationCode"] ?? 0,
      verificationCodeExpiry: json["verificationCodeExpiry"] == null ? DateTime.now() : DateTime.parse("${json["verificationCodeExpiry"]}"),
      profilePhoto: json["profilePhoto"] ?? "");

  Map<String, dynamic> toJson() => {
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "role": role,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "activeStatus": activeStatus,
        "verificationCode": verificationCode,
        "verificationCodeExpiry": verificationCodeExpiry,
        "profilePhoto": profilePhoto,
      };
}
