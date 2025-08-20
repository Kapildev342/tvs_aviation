import 'dart:convert';

LoginApiModel loginApiModelFromJson(String str) => LoginApiModel.fromJson(json.decode(str));

String loginApiModelToJson(LoginApiModel data) => json.encode(data.toJson());

class LoginApiModel {
  final String token;
  final String message;
  final UserApi user;
  final bool status;

  LoginApiModel({
    required this.token,
    required this.message,
    required this.user,
    required this.status,
  });

  factory LoginApiModel.fromJson(Map<String, dynamic> json) => LoginApiModel(
        token: json["token"] ?? "",
        message: json["message"] ?? "",
        user: UserApi.fromJson(json["user"] ?? {}),
        status: json["status"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "message": message,
        "user": user.toJson(),
        "status": status,
      };
}

class UserApi {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String role;
  final String createdAt;
  final String updatedAt;
  final bool activeStatus;
  final int verificationCode;
  final String verificationCodeExpiry;
  final String profilePhoto;

  UserApi({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
    required this.activeStatus,
    required this.verificationCode,
    required this.verificationCodeExpiry,
    required this.profilePhoto,
  });

  factory UserApi.fromJson(Map<String, dynamic> json) => UserApi(
        id: json["_id"] ?? "",
        firstName: json["firstName"] ?? "",
        lastName: json["lastName"] ?? "",
        email: json["email"] ?? "",
        password: json["password"] ?? "",
        role: json["role"] ?? "",
        createdAt: json["createdAt"] ?? "",
        updatedAt: json["updatedAt"] ?? "",
        activeStatus: json["activeStatus"] ?? false,
        verificationCode: json["verificationCode"] ?? 0,
        verificationCodeExpiry: json["verificationCodeExpiry"] ?? '',
        profilePhoto: json["profilePhoto"] ?? '',
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
        "verificationCode": verificationCode,
        "verificationCodeExpiry": verificationCodeExpiry,
        "profilePhoto": profilePhoto,
      };
}
