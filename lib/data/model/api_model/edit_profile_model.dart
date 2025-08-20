import 'dart:convert';

import 'package:tvsaviation/data/hive/user/user_data.dart';

EditProfileModel editProfileModelFromJson(String str) => EditProfileModel.fromJson(json.decode(str));

String editProfileModelToJson(EditProfileModel data) => json.encode(data.toJson());

class EditProfileModel {
  final bool status;
  final String message;
  final User updatedUser;

  EditProfileModel({
    required this.status,
    required this.message,
    required this.updatedUser,
  });

  factory EditProfileModel.fromJson(Map<String, dynamic> json) => EditProfileModel(
        status: json["status"] ?? false,
        message: json["message"] ?? "",
        updatedUser: User.fromJson(json["updatedUser"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "updatedUser": updatedUser.toJson(),
      };
}

class UpdatedUser {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String role;
  final String createdAt;
  final String updatedAt;
  final bool activeStatus;
  final String profilePhoto;

  UpdatedUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
    required this.activeStatus,
    required this.profilePhoto,
  });

  factory UpdatedUser.fromJson(Map<String, dynamic> json) => UpdatedUser(
        id: json["_id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        password: json["password"],
        role: json["role"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        activeStatus: json["activeStatus"],
        profilePhoto: json["profilePhoto"],
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
        "profilePhoto": profilePhoto,
      };
}
