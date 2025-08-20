import 'dart:convert';

GetCrewListModel getCrewListModelFromJson(String str) => GetCrewListModel.fromJson(json.decode(str));

String getCrewListModelToJson(GetCrewListModel data) => json.encode(data.toJson());

class GetCrewListModel {
  final bool status;
  final List<UserManageResponse> users;
  final int totalUsers;
  final int totalPages;
  final int currentPage;

  GetCrewListModel({
    required this.status,
    required this.users,
    required this.totalUsers,
    required this.totalPages,
    required this.currentPage,
  });

  factory GetCrewListModel.fromJson(Map<String, dynamic> json) => GetCrewListModel(
        status: json["status"] ?? false,
        users: List<UserManageResponse>.from((json["users"] ?? []).map((x) => UserManageResponse.fromJson(x))),
        totalUsers: json["totalUsers"] ?? 0,
        totalPages: json["totalPages"] ?? 1,
        currentPage: json["currentPage"] ?? 1,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
        "totalUsers": totalUsers,
        "totalPages": totalPages,
        "currentPage": currentPage,
      };
}

class UserManageResponse {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final bool activeStatus;
  final String profilePhoto;
  final String fullName;
  final String role;

  UserManageResponse({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.activeStatus,
    required this.profilePhoto,
    required this.fullName,
    required this.role,
  });

  factory UserManageResponse.fromJson(Map<String, dynamic> json) => UserManageResponse(
        id: json["_id"] ?? "",
        firstName: json["firstName"] ?? "",
        lastName: json["lastName"] ?? "",
        email: json["email"] ?? "",
        activeStatus: json["activeStatus"] ?? false,
        profilePhoto: json["profilePhoto"] ?? "",
        fullName: json["fullName"] ?? "",
        role: json["role"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "activeStatus": activeStatus,
        "profilePhoto": profilePhoto,
        "fullName": fullName,
        "role": role,
      };
}
