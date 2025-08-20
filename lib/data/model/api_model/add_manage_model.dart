import 'get_product_list_model.dart';

class AddBrandTypeModel {
  final bool status;
  final String message;
  final AddBrandTypeResponse brandType;

  AddBrandTypeModel({
    required this.status,
    required this.message,
    required this.brandType,
  });

  factory AddBrandTypeModel.fromJson(Map<String, dynamic> json) => AddBrandTypeModel(
        status: json["status"] ?? false,
        message: json["message"] ?? "",
        brandType: AddBrandTypeResponse.fromJson(json["brandType"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "brandType": brandType.toJson(),
      };
}

class AddBrandTypeResponse {
  final String name;
  final String id;
  final String createdAt;
  final String updatedAt;

  AddBrandTypeResponse({
    required this.name,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AddBrandTypeResponse.fromJson(Map<String, dynamic> json) => AddBrandTypeResponse(
        name: json["name"] ?? "",
        id: json["_id"] ?? "",
        createdAt: json["createdAt"] ?? "",
        updatedAt: json["updatedAt"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "_id": id,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}

class AddCategoryModel {
  final bool status;
  final String message;
  final AddCategoryResponse category;

  AddCategoryModel({
    required this.status,
    required this.message,
    required this.category,
  });

  factory AddCategoryModel.fromJson(Map<String, dynamic> json) => AddCategoryModel(
        status: json["status"] ?? false,
        message: json["message"] ?? "",
        category: AddCategoryResponse.fromJson(json["category"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "category": category.toJson(),
      };
}

class AddCategoryResponse {
  final String name;
  final bool activeStatus;
  final String id;
  final String createdAt;
  final String updatedAt;

  AddCategoryResponse({
    required this.name,
    required this.activeStatus,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AddCategoryResponse.fromJson(Map<String, dynamic> json) => AddCategoryResponse(
        name: json["name"] ?? "",
        activeStatus: json["activeStatus"] ?? false,
        id: json["_id"] ?? "",
        createdAt: json["createdAt"] ?? '',
        updatedAt: json["updatedAt"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "activeStatus": activeStatus,
        "_id": id,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}

class AddHandlerModel {
  final bool status;
  final String message;
  final AddHandlerResponse handler;

  AddHandlerModel({
    required this.status,
    required this.message,
    required this.handler,
  });

  factory AddHandlerModel.fromJson(Map<String, dynamic> json) => AddHandlerModel(
        status: json["status"] ?? false,
        message: json["message"] ?? "",
        handler: AddHandlerResponse.fromJson(json["handler"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "handler": handler.toJson(),
      };
}

class AddHandlerResponse {
  final String name;
  final bool activeStatus;
  final String id;
  final String createdAt;
  final String updatedAt;

  AddHandlerResponse({
    required this.name,
    required this.activeStatus,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AddHandlerResponse.fromJson(Map<String, dynamic> json) => AddHandlerResponse(
        name: json["name"] ?? "",
        activeStatus: json["activeStatus"] ?? false,
        id: json["_id"] ?? "",
        createdAt: json["createdAt"] ?? "",
        updatedAt: json["updatedAt"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "activeStatus": activeStatus,
        "_id": id,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}

class AddWareHouseOrAirCraftModel {
  final bool status;
  final String message;
  final AddLocationResponse location;

  AddWareHouseOrAirCraftModel({
    required this.status,
    required this.message,
    required this.location,
  });

  factory AddWareHouseOrAirCraftModel.fromJson(Map<String, dynamic> json) => AddWareHouseOrAirCraftModel(
        status: json["status"] ?? false,
        message: json["message"] ?? "",
        location: AddLocationResponse.fromJson(json["location"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "location": location.toJson(),
      };
}

class AddLocationResponse {
  final String name;
  final String type;
  final bool activeStatus;
  final String id;
  final String createdAt;
  final String updatedAt;

  AddLocationResponse({
    required this.name,
    required this.type,
    required this.activeStatus,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AddLocationResponse.fromJson(Map<String, dynamic> json) => AddLocationResponse(
        name: json["name"] ?? "",
        type: json["type"] ?? "",
        activeStatus: json["activeStatus"] ?? false,
        id: json["_id"] ?? "",
        createdAt: json["createdAt"] ?? "",
        updatedAt: json["updatedAt"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "type": type,
        "activeStatus": activeStatus,
        "_id": id,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}

class AddSectorModel {
  final bool status;
  final String message;
  final AddSectorResponse sector;

  AddSectorModel({
    required this.status,
    required this.message,
    required this.sector,
  });

  factory AddSectorModel.fromJson(Map<String, dynamic> json) => AddSectorModel(
        status: json["status"] ?? false,
        message: json["message"] ?? "",
        sector: AddSectorResponse.fromJson(json["sector"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "sector": sector.toJson(),
      };
}

class AddSectorResponse {
  final String icao;
  final String iata;
  final String airportName;
  final String city;
  final bool activeStatus;
  final String id;
  final String createdAt;
  final String updatedAt;

  AddSectorResponse({
    required this.icao,
    required this.iata,
    required this.airportName,
    required this.city,
    required this.activeStatus,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AddSectorResponse.fromJson(Map<String, dynamic> json) => AddSectorResponse(
        icao: json["icao"] ?? "",
        iata: json["iata"] ?? "",
        airportName: json["airportName"] ?? "",
        city: json["city"] ?? "",
        activeStatus: json["activeStatus"] ?? false,
        id: json["_id"] ?? "",
        createdAt: json["createdAt"] ?? "",
        updatedAt: json["updatedAt"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "icao": icao,
        "iata": iata,
        "airportName": airportName,
        "city": city,
        "activeStatus": activeStatus,
        "_id": id,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}

class AddCrewModel {
  final bool status;
  final String message;
  final NewUser newUser;

  AddCrewModel({
    required this.status,
    required this.message,
    required this.newUser,
  });

  factory AddCrewModel.fromJson(Map<String, dynamic> json) => AddCrewModel(
        status: json["status"] ?? false,
        message: json["message"] ?? "",
        newUser: NewUser.fromJson(json["newUser"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "newUser": newUser.toJson(),
      };
}

class NewUser {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String role;
  final String createdBy;
  final bool activeStatus;
  final String id;
  final String createdAt;
  final String updatedAt;
  final String profilePhoto;

  NewUser({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.role,
    required this.createdBy,
    required this.activeStatus,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.profilePhoto,
  });

  factory NewUser.fromJson(Map<String, dynamic> json) => NewUser(
        firstName: json["firstName"] ?? "",
        lastName: json["lastName"] ?? "",
        email: json["email"] ?? "",
        password: json["password"] ?? "",
        role: json["role"] ?? "",
        createdBy: json["createdBy"] ?? "",
        activeStatus: json["activeStatus"] ?? false,
        id: json["_id"] ?? "",
        createdAt: json["createdAt"] ?? "",
        updatedAt: json["updatedAt"] ?? '',
        profilePhoto: json["profilePhoto"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "password": password,
        "role": role,
        "createdBy": createdBy,
        "activeStatus": activeStatus,
        "_id": id,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "profilePhoto": profilePhoto,
      };
}

class AddProductModel {
  final bool status;
  final String message;
  final NewProductResponse products;

  AddProductModel({
    required this.status,
    required this.message,
    required this.products,
  });

  factory AddProductModel.fromJson(Map<String, dynamic> json) => AddProductModel(
        status: json["status"] ?? false,
        message: json["message"] ?? "",
        products: NewProductResponse.fromJson(json["product"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "product": products.toJson(),
      };
}

class AddInventoryModel {
  final bool status;
  final String message;
  final NewInventory newInventory;

  AddInventoryModel({
    required this.status,
    required this.message,
    required this.newInventory,
  });

  factory AddInventoryModel.fromJson(Map<String, dynamic> json) => AddInventoryModel(
        status: json["status"] ?? false,
        message: json["message"] ?? "",
        newInventory: NewInventory.fromJson(json["newInventory"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "newInventory": newInventory.toJson(),
      };
}

class NewInventory {
  final String locationId;
  final String productId;
  final String stockType;
  final String category;
  final String barcode;
  final String expiryDate;
  final int minLevel;
  final int quantity;
  final String id;
  final String createdAt;
  final String updatedAt;

  NewInventory({
    required this.locationId,
    required this.productId,
    required this.stockType,
    required this.category,
    required this.barcode,
    required this.expiryDate,
    required this.minLevel,
    required this.quantity,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NewInventory.fromJson(Map<String, dynamic> json) => NewInventory(
        locationId: json["locationId"] ?? "",
        productId: json["productId"] ?? "",
        stockType: json["stockType"] ?? "",
        category: json["category"] ?? "",
        barcode: json["barcode"] ?? '',
        expiryDate: json["expiryDate"] ?? "",
        minLevel: json["minLevel"] ?? 0,
        quantity: json["quantity"] ?? 0,
        id: json["_id"] ?? "",
        createdAt: json["createdAt"] ?? "",
        updatedAt: json["updatedAt"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "locationId": locationId,
        "productId": productId,
        "stockType": stockType,
        "category": category,
        "barcode": barcode,
        "expiryDate": expiryDate,
        "minLevel": minLevel,
        "quantity": quantity,
        "_id": id,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}
