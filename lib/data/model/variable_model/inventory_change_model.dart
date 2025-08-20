import 'package:tvsaviation/resources/constants.dart';

class InventoryChangeModel {
  String photo;
  String barCode;
  String productName;
  String brandName;
  String purchaseDate;
  String expiryDate;
  int quantity;
  int addQuantity;
  String productId;
  String id;

  InventoryChangeModel({
    required this.photo,
    required this.barCode,
    required this.productName,
    required this.brandName,
    required this.purchaseDate,
    required this.expiryDate,
    required this.quantity,
    required this.addQuantity,
    required this.productId,
    required this.id,
  });

  factory InventoryChangeModel.fromJson(Map<String, dynamic> json) => InventoryChangeModel(
        photo: json["productImage"] ?? "",
        barCode: json["barcode"] ?? "",
        productName: json["productName"] ?? "",
        brandName: json["brandName"] ?? "",
        purchaseDate: json["purchaseDate"] == null ? "-" : mainFunctions.dateFormat(date: json["purchaseDate"]),
        expiryDate: json["expiryDate"] == null ? "-" : mainFunctions.dateFormat(date: json["expiryDate"]),
        quantity: json["quantity"] ?? 0,
        addQuantity: json["add_quantity"] ?? 0,
        productId: json["productId"] ?? "",
        id: json["_id"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "productImage": photo,
        "barcode": barCode,
        "productName": productName,
        "brandName": brandName,
        "purchaseDate": purchaseDate,
        "expiryDate": expiryDate,
        "quantity": quantity,
        "add_quantity": addQuantity,
        "productId": productId,
        "_id": id,
      };
}

class TransitChangeModel {
  String transId;
  String action;
  String senderLocation;
  String receiverLocation;
  String senderName;
  String receiverName;
  String date;
  int quantity;
  String id;

  TransitChangeModel({
    required this.transId,
    required this.action,
    required this.senderLocation,
    required this.receiverLocation,
    required this.senderName,
    required this.receiverName,
    required this.date,
    required this.quantity,
    required this.id,
  });

  factory TransitChangeModel.fromJson(Map<String, dynamic> json) => TransitChangeModel(
        transId: json["TransId"] ?? "",
        action: json["action"] ?? "",
        senderLocation: json["senderLocation"] ?? "",
        receiverLocation: json["receiverLocation"] ?? "",
        senderName: json["senderName"] ?? "",
        receiverName: json["receiverName"] ?? "",
        date: json["createdAt"] == null ? "-" : mainFunctions.dateTimeFormat(date: json["createdAt"]),
        quantity: json["quantity"] ?? 0,
        id: json["_id"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "TransId": transId,
        "action": action,
        "senderLocation": senderLocation,
        "receiverLocation": receiverLocation,
        "senderName": senderName,
        "receiverName": receiverName,
        "createdAt": date,
        "quantity": quantity,
        "_id": id,
      };
}

class TransitInventoryChangeModel {
  String photo;
  String barCode;
  String productName;
  String brandName;
  String purchaseDate;
  String expiryDate;
  int quantity;
  String action;
  String productId;
  String stockDispute;
  String inventoryId;

  TransitInventoryChangeModel({
    required this.photo,
    required this.barCode,
    required this.productName,
    required this.brandName,
    required this.purchaseDate,
    required this.expiryDate,
    required this.quantity,
    required this.action,
    required this.productId,
    required this.stockDispute,
    required this.inventoryId,
  });

  factory TransitInventoryChangeModel.fromJson(Map<String, dynamic> json) => TransitInventoryChangeModel(
        photo: json["productImage"] ?? "",
        barCode: json["barcode"] ?? "",
        productName: json["productName"] ?? "",
        brandName: json["brandType"] ?? "",
        purchaseDate: json["monthOfPurchase"] == "" ? "-" : mainFunctions.dateFormat(date: json["monthOfPurchase"]),
        expiryDate: json["expiry"] == "" ? "-" : mainFunctions.dateFormat(date: json["expiry"]),
        quantity: json["quantity"] ?? 0,
        action: json["action"] ?? "-",
        productId: json["productId"] ?? "",
        stockDispute: json["stockDispute"] ? "yes" : "no",
        inventoryId: json["inventoryId"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "productImage": photo,
        "barcode": barCode,
        "productName": productName,
        "brandType": brandName,
        "monthOfPurchase": purchaseDate,
        "expiry": expiryDate,
        "quantity": quantity,
        "action": action,
        "productId": productId,
        "stockDispute": stockDispute,
        "inventoryId": inventoryId,
      };
}

class TransitDisputeChangeModel {
  String photo;
  String disputeId;
  String productName;
  String brandName;
  String purchaseDate;
  String expiryDate;
  int stockQuantity;
  String action;
  String productId;
  String stockDispute;
  String inventoryId;

  TransitDisputeChangeModel({
    required this.photo,
    required this.disputeId,
    required this.productName,
    required this.brandName,
    required this.purchaseDate,
    required this.expiryDate,
    required this.stockQuantity,
    required this.action,
    required this.productId,
    required this.stockDispute,
    required this.inventoryId,
  });

  factory TransitDisputeChangeModel.fromJson(Map<String, dynamic> json) => TransitDisputeChangeModel(
        photo: json["productImage"] ?? "",
        disputeId: json["stockDisputeId"] ?? "",
        productName: json["productName"] ?? "",
        brandName: json["brandType"] ?? "",
        purchaseDate: json["monthOfPurchase"] == "" ? "-" : mainFunctions.dateFormat(date: json["monthOfPurchase"]),
        expiryDate: json["expiry"] == "" ? "-" : mainFunctions.dateFormat(date: json["expiry"]),
        stockQuantity: json["stockQuantity"] ?? 0,
        action: json["action"] ?? "-",
        productId: json["productId"] ?? "",
        stockDispute: json["stockDispute"] ? "yes" : "no",
        inventoryId: json["inventoryId"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "productImage": photo,
        "stockDisputeId": disputeId,
        "productName": productName,
        "brandType": brandName,
        "monthOfPurchase": purchaseDate,
        "expiry": expiryDate,
        "stockQuantity": stockQuantity,
        "action": action,
        "productId": productId,
        "stockDispute": stockDispute,
        "inventoryId": inventoryId,
      };
}

class ResolutionDisputeChangeModel {
  String photo;
  String barCode;
  String productName;
  String brandName;
  String purchaseDate;
  String expiryDate;
  int quantity;

  ResolutionDisputeChangeModel({
    required this.photo,
    required this.barCode,
    required this.productName,
    required this.brandName,
    required this.purchaseDate,
    required this.expiryDate,
    required this.quantity,
  });

  factory ResolutionDisputeChangeModel.fromJson(Map<String, dynamic> json) => ResolutionDisputeChangeModel(
        photo: json["photo"] ?? "",
        barCode: json["barcode"] ?? "",
        productName: json["productName"] ?? "",
        brandName: json["brandName"] ?? "",
        purchaseDate: json["monthOfPurchase"] == "" ? "-" : mainFunctions.dateFormat(date: json["monthOfPurchase"]),
        expiryDate: json["expiry"] == "" ? "-" : mainFunctions.dateFormat(date: json["expiry"]),
        quantity: json["quantity"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "photo": photo,
        "barcode": barCode,
        "productName": productName,
        "brandName": brandName,
        "monthOfPurchase": purchaseDate,
        "expiry": expiryDate,
        "quantity": quantity,
      };
}

class OverAllChangeModel {
  String productImage;
  String productName;
  String brandName;
  int quantity;
  String location;
  String id;

  OverAllChangeModel({
    required this.productImage,
    required this.productName,
    required this.brandName,
    required this.quantity,
    required this.location,
    required this.id,
  });

  factory OverAllChangeModel.fromJson(Map<String, dynamic> json) => OverAllChangeModel(
        productImage: json["productImage"] ?? "",
        productName: json["productName"] ?? "",
    brandName: json["brandType"] ?? "1234567",
        quantity: json["quantity"] ?? 0,
        location: json["location"] ?? "",
        id: json["_id"] ?? "-",
      );

  Map<String, dynamic> toJson() => {
        "productImage": productImage,
        "productName": productName,
        "brandType": brandName,
        "quantity": quantity,
        "location": location,
        "_id": id,
      };
}

class LowStockChangeModel {
  String productImage;
  String productName;
  String brandName;
  String date;
  String location;
  int currentQuantity;
  int minimumQuantity;
  String id;

  LowStockChangeModel({
    required this.productImage,
    required this.productName,
    required this.brandName,
    required this.date,
    required this.location,
    required this.currentQuantity,
    required this.minimumQuantity,
    required this.id,
  });

  factory LowStockChangeModel.fromJson(Map<String, dynamic> json) => LowStockChangeModel(
        productImage: json["productPhoto"] ?? "",
        productName: json["productName"] ?? "",
    brandName: json["brandType"] ?? "1234567",
        date: json["date"] == "" ? "-" : mainFunctions.dateTimeFormat(date: json["date"]),
        location: json["location"] ?? "",
        currentQuantity: json["currentQty"] ?? 0,
        minimumQuantity: json["minQty"] ?? 0,
        id: json["_id"] ?? "-",
      );

  Map<String, dynamic> toJson() => {
        "productPhoto": productImage,
        "productName": productName,
        "brandType": brandName,
        "date": date,
        "location": location,
        "currentQty": currentQuantity,
        "minQty": minimumQuantity,
        "_id": id,
      };
}

class ExpiryChangeModel {
  String productImage;
  String productName;
  String brandType;
 // String barCode;
  String location;
  String expiryDate;
  int daysUntilExpiry;
  int quantity;
  String id;

  ExpiryChangeModel({
    required this.productImage,
    required this.productName,
    required this.brandType,
  //  required this.barCode,
    required this.location,
    required this.expiryDate,
    required this.daysUntilExpiry,
    required this.quantity,
    required this.id,
  });

  factory ExpiryChangeModel.fromJson(Map<String, dynamic> json) => ExpiryChangeModel(
        productImage: json["productImage"] ?? "",
        productName: json["productName"] ?? "",
    brandType: json["brandType"] ?? "1234567",
      //  barCode: json["barcode"] ?? "",
        location: json["locationName"] ?? "",
        expiryDate: json["expiryDate"] == "" ? "-" : mainFunctions.dateFormat(date: json["expiryDate"]),
        daysUntilExpiry: json["daysUntilExpiry"] ?? 0,
        quantity: json["quantity"] ?? 0,
        id: json["_id"] ?? "-",
      );

  Map<String, dynamic> toJson() => {
        "productImage": productImage,
        "productName": productName,
        "brandType": brandType,
      //  "barcode": barCode,
        "locationName": location,
        "expiryDate": expiryDate,
        "daysUntilExpiry": daysUntilExpiry,
        "quantity": quantity,
        "_id": id,
      };
}

class DisputesChangeModel {
  String disputeId;
  String date;
  String crewHandler;
  String location;
  int quantity;
  String action;
  String id;
  String transId;

  DisputesChangeModel({
    required this.disputeId,
    required this.date,
    required this.crewHandler,
    required this.location,
    required this.quantity,
    required this.action,
    required this.id,
    required this.transId,
  });

  factory DisputesChangeModel.fromJson(Map<String, dynamic> json) => DisputesChangeModel(
        disputeId: json["stockDisputeId"] ?? "",
        date: json["createdAt"] == "" ? "-" : mainFunctions.dateTimeFormat(date: json["createdAt"]),
        crewHandler: json["crew"] ?? "",
        location: json["location"] ?? "",
        quantity: json["totalQuantity"] ?? 0,
        action: "${json["resolve"] ?? false}",
        id: json["_id"] ?? "-",
        transId: json["transitId"] ?? "-",
      );

  Map<String, dynamic> toJson() => {
        "stockDisputeId": disputeId,
        "date": date,
        "crew": crewHandler,
        "location": location,
        "totalQuantity": quantity,
        "action": action,
        "_id": id,
        "transitId": transId,
      };
}

class TransactionHistoryChangeModel {
  String serialNo;
  String transId;
  String from;
  String to;
  String sender;
  String receiver;
  String fromDate;
  String receivedDate;
  int disputeQuantity;
  int quantity;
  String id;

  TransactionHistoryChangeModel({
    required this.serialNo,
    required this.transId,
    required this.from,
    required this.to,
    required this.sender,
    required this.receiver,
    required this.fromDate,
    required this.receivedDate,
    required this.disputeQuantity,
    required this.quantity,
    required this.id,
  });

  factory TransactionHistoryChangeModel.fromJson(Map<String, dynamic> json) => TransactionHistoryChangeModel(
        serialNo: json["serial_no"] ?? "0",
        transId: json["TransId"] ?? "",
        from: json["from"] ?? "",
        to: json["to"] ?? "",
        sender: json["sender"] ?? "",
        receiver: json["receiver"] ?? "",
        fromDate: json["fromDate"] == "" ? "-" : mainFunctions.dateTimeFormat(date: json["fromDate"]),
        receivedDate: json["receivedDate"] == "" ? "-" : mainFunctions.dateTimeFormat(date: json["receivedDate"]),
        disputeQuantity: json["disputeQuantity"] ?? 0,
        quantity: json["totalQty"] ?? 0,
        id: json["id"] ?? "-",
      );

  Map<String, dynamic> toJson() => {
        "serial_no": serialNo,
        "TransId": transId,
        "from": from,
        "to": to,
        "sender": sender,
        "receiver": receiver,
        "fromDate": fromDate,
        "receivedDate": receivedDate,
        "disputeQuantity": disputeQuantity,
        "totalQty": quantity,
        "id": id,
      };
}

class CabinGalleyChangeModel {
  String transId;
  String date;
  String from;
  String to;
  String crew;
  String sector;
  int quantity;
  String id;

  CabinGalleyChangeModel({
    required this.transId,
    required this.date,
    required this.from,
    required this.to,
    required this.crew,
    required this.sector,
    required this.quantity,
    required this.id,
  });

  factory CabinGalleyChangeModel.fromJson(Map<String, dynamic> json) => CabinGalleyChangeModel(
        transId: json["TransId"] ?? "",
        date: json["createdAt"] == "" ? "-" : mainFunctions.dateTimeFormat(date: json["createdAt"]),
        from: json["senderLocation"] ?? "",
        to: json["receiverLocation"] ?? "",
        crew: json["senderName"] ?? "",
        sector: json["sector"] ?? "",
        quantity: json["quantity"] ?? 0,
        id: json["_id"] ?? "-",
      );

  Map<String, dynamic> toJson() => {
        "TransId": transId,
        "createdAt": date,
        "senderLocation": from,
        "receiverLocation": to,
        "senderName": crew,
        "sector": sector,
        "quantity": quantity,
        "_id": id,
      };
}

class PreFlightChangeModel {
  String reportId;
  String date;
  String aircraft;
  String crew;
  String sector;
  String id;

  PreFlightChangeModel({
    required this.reportId,
    required this.date,
    required this.aircraft,
    required this.crew,
    required this.sector,
    required this.id,
  });

  factory PreFlightChangeModel.fromJson(Map<String, dynamic> json) => PreFlightChangeModel(
        reportId: json["reportID"] ?? "",
        date: json["date"] == "" ? "-" : mainFunctions.dateTimeFormat(date: json["date"]),
        aircraft: json["location"] ?? "",
        crew: json["crew"] ?? "",
        sector: json["sector"] ?? "",
        id: json["_id"] ?? "-",
      );

  Map<String, dynamic> toJson() => {
        "reportID": reportId,
        "date": date,
        "location": aircraft,
        "crew": crew,
        "sector": sector,
        "_id": id,
      };
}

class PostFlightChangeModel {
  String reportId;
  String date;
  String aircraft;
  String crew;
  String sector;
  String id;

  PostFlightChangeModel({
    required this.reportId,
    required this.date,
    required this.aircraft,
    required this.crew,
    required this.sector,
    required this.id,
  });

  factory PostFlightChangeModel.fromJson(Map<String, dynamic> json) => PostFlightChangeModel(
        reportId: json["reportID"] ?? "",
        date: json["date"] == "" ? "-" : mainFunctions.dateTimeFormat(date: json["date"]),
        aircraft: json["location"] ?? "",
        crew: json["crew"] ?? "",
        sector: json["sector"] ?? "",
        id: json["_id"] ?? "-",
      );

  Map<String, dynamic> toJson() => {
        "reportID": reportId,
        "date": date,
        "location": aircraft,
        "crew": crew,
        "sector": sector,
        "_id": id,
      };
}

class MaintenanceChangeModel {
  String reportId;
  String date;
  String aircraft;
  String crew;
  String sector;
  String id;

  MaintenanceChangeModel({
    required this.reportId,
    required this.date,
    required this.aircraft,
    required this.crew,
    required this.sector,
    required this.id,
  });

  factory MaintenanceChangeModel.fromJson(Map<String, dynamic> json) => MaintenanceChangeModel(
        reportId: json["reportID"] ?? "",
        date: json["date"] == "" ? "-" : mainFunctions.dateTimeFormat(date: json["date"]),
        aircraft: json["location"] ?? "",
        crew: json["crew"] ?? "",
        sector: json["sector"] ?? "",
        id: json["_id"] ?? "-",
      );

  Map<String, dynamic> toJson() => {
        "reportID": reportId,
        "date": date,
        "location": aircraft,
        "crew": crew,
        "sector": sector,
        "_id": id,
      };
}

class SafetyChangeModel {
  String reportId;
  String date;
  String aircraft;
  String crew;
  String sector;
  String id;

  SafetyChangeModel({
    required this.reportId,
    required this.date,
    required this.aircraft,
    required this.crew,
    required this.sector,
    required this.id,
  });

  factory SafetyChangeModel.fromJson(Map<String, dynamic> json) => SafetyChangeModel(
        reportId: json["reportID"] ?? "",
        date: json["date"] == "" ? "-" : mainFunctions.dateTimeFormat(date: json["date"]),
        aircraft: json["location"] ?? "",
        crew: json["crew"] ?? "",
        sector: json["sector"] ?? "",
        id: json["_id"] ?? "-",
      );

  Map<String, dynamic> toJson() => {
        "reportID": reportId,
        "date": date,
        "location": aircraft,
        "crew": crew,
        "sector": sector,
        "_id": id,
      };
}

class InventoryProductsChangeModel {
  String barCode;
  String date;
  String location;
  int quantity;
  String action;
  String id;
  String actionQty;

  InventoryProductsChangeModel({
    required this.barCode,
    required this.date,
    required this.location,
    required this.quantity,
    required this.action,
    required this.id,
    required this.actionQty,
  });

  factory InventoryProductsChangeModel.fromJson(Map<String, dynamic> json) => InventoryProductsChangeModel(
        barCode: json["barcode"] ?? "",
        date: mainVariables.inventoryVariables.selectedStockTypeId == "food_items_&_disposables"
            ? json["expiryDate"] == ""
                ? "-"
                : mainFunctions.dateFormat(date: json["expiryDate"])
            : json["purchaseDate"] == ""
                ? "-"
                : mainFunctions.dateFormat(date: json["purchaseDate"]),
        location: json["locationName"] ?? "",
        quantity: json["quantity"] ?? 0,
        action: json["action"] ?? "0",
        id: json["inventoryId"] ?? "",
        actionQty: (json["cartCount"] ?? 0).toString(),
      );

  Map<String, dynamic> toJson() => {
        "barcode": barCode,
        "date": date,
        "locationName": location,
        "quantity": quantity,
        "action": action,
        "inventoryId": id,
        "cartCount": actionQty,
      };
}

class InventoryShortageChangeModel {
  final String disputeId;
  final String purchaseDate;
  final String crewName;
  final String location;
  final int quantity;
  final String disputeMainId;

  InventoryShortageChangeModel({
    required this.disputeId,
    required this.purchaseDate,
    required this.crewName,
    required this.location,
    required this.quantity,
    required this.disputeMainId,
  });

  factory InventoryShortageChangeModel.fromJson(Map<String, dynamic> json) => InventoryShortageChangeModel(
        disputeId: json["disputeId"] ?? "",
        purchaseDate: json["purchaseDate"] == "" ? "-" : mainFunctions.dateFormat(date: json["purchaseDate"]),
        crewName: json["crewName"] ?? "",
        location: json["locationName"] ?? "",
        quantity: json["quantity"] ?? 0,
        disputeMainId: json["_id"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "disputeId": disputeId,
        "purchaseDate": purchaseDate,
        "crewName": crewName,
        "locationName": location,
        "quantity": quantity,
        "_id": disputeMainId,
      };
}

class ProductChangeModel {
  final String productImage;
  final String combinedName;
  final String categoryName;
  final String activeStatus;
  final String action;
  final String id;
  final String productName;
  final String brandName;
  final String categoryId;
  final String brandId;
  final int daysUntilExpiry;

  ProductChangeModel({
    required this.productImage,
    required this.combinedName,
    required this.categoryName,
    required this.activeStatus,
    required this.action,
    required this.id,
    required this.productName,
    required this.brandName,
    required this.categoryId,
    required this.brandId,
    required this.daysUntilExpiry,
  });

  factory ProductChangeModel.fromJson(Map<String, dynamic> json) => ProductChangeModel(
        productImage: json["productImage"] ?? "",
        combinedName: json["combinedName"] ?? "",
        categoryName: json["categoryName"] ?? "",
        activeStatus: json["activeStatus"] ? "active" : "inactive",
        action: json["action"] ?? "-",
        id: json["_id"] ?? "",
        productName: json["productName"] ?? "",
        brandName: json["brandTypeName"] ?? "",
        categoryId: json["categoryId"] ?? "",
        brandId: json["brandTypeId"] ?? "",
        daysUntilExpiry: json["daysUntilExpiry"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "productImage": productImage,
        "combinedName": combinedName,
        "categoryName": categoryName,
        "activeStatus": activeStatus,
        "action": action,
        "_id": id,
        "productName": productName,
        "brandTypeName": brandName,
        "categoryId": categoryId,
        "brandTypeId": brandId,
        "daysUntilExpiry": daysUntilExpiry,
      };
}

class BrandChangeModel {
  final String brandName;
  final String action;
  final String id;

  BrandChangeModel({
    required this.brandName,
    required this.action,
    required this.id,
  });

  factory BrandChangeModel.fromJson(Map<String, dynamic> json) => BrandChangeModel(
        brandName: json["name"] ?? "",
        action: json["action"] ?? "-",
        id: json["_id"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "name": brandName,
        "action": action,
        "_id": id,
      };
}

class CategoryChangeModel {
  final String name;
  final String action;
  final String id;

  CategoryChangeModel({
    required this.name,
    required this.action,
    required this.id,
  });

  factory CategoryChangeModel.fromJson(Map<String, dynamic> json) => CategoryChangeModel(
        name: json["name"] ?? "",
        action: json["action"] ?? "-",
        id: json["_id"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "action": action,
        "_id": id,
      };
}

class CrewChangeModel {
  final String crewImage;
  final String crewName;
  final String email;
  final String activeStatus;
  final String action;
  final String id;
  final String role;

  CrewChangeModel({
    required this.crewImage,
    required this.crewName,
    required this.email,
    required this.activeStatus,
    required this.action,
    required this.id,
    required this.role,
  });

  factory CrewChangeModel.fromJson(Map<String, dynamic> json) => CrewChangeModel(
        crewImage: json["profilePhoto"] ?? "",
        crewName: json["fullName"] ?? "",
        email: json["email"] ?? "",
        activeStatus: json["activeStatus"] ? "active" : "inactive",
        action: json["action"] ?? "-",
        id: json["_id"] ?? "",
        role: json["role"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "profilePhoto": crewImage,
        "fullName": crewName,
        "email": email,
        "activeStatus": activeStatus,
        "action": action,
        "_id": id,
        "role": role,
      };
}

class HandlerChangeModel {
  final String name;
  final String action;
  final String id;

  HandlerChangeModel({
    required this.name,
    required this.action,
    required this.id,
  });

  factory HandlerChangeModel.fromJson(Map<String, dynamic> json) => HandlerChangeModel(
        name: json["name"] ?? "",
        action: json["action"] ?? "-",
        id: json["_id"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "action": action,
        "_id": id,
      };
}

class WarehouseOrAirCraftModel {
  final String name;
  final String action;
  final String id;

  WarehouseOrAirCraftModel({
    required this.name,
    required this.action,
    required this.id,
  });

  factory WarehouseOrAirCraftModel.fromJson(Map<String, dynamic> json) => WarehouseOrAirCraftModel(
        name: json["name"] ?? "",
        action: json["action"] ?? "-",
        id: json["_id"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "action": action,
        "_id": id,
      };
}

class SectorChangeModel {
  final String airportName;
  final String city;
  final String icao;
  final String iata;
  final String action;
  final String id;

  SectorChangeModel({
    required this.airportName,
    required this.city,
    required this.icao,
    required this.iata,
    required this.action,
    required this.id,
  });

  factory SectorChangeModel.fromJson(Map<String, dynamic> json) => SectorChangeModel(
        airportName: json["airportName"] ?? "",
        city: json["city"] ?? "",
        icao: json["icao"] ?? "",
        iata: json["iata"] ?? "",
        action: json["action"] ?? "-",
        id: json["_id"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "airportName": airportName,
        "city": city,
        "icao": icao,
        "iata": iata,
        "action": action,
        "_id": id,
      };
}

class CheckListAddFormatChangeModel {
  String listName;
  String userId;
  String date;
  String locationId;
  String sectorFrom;
  String sectorTo;
  OtherLists otherLists;
  List<ChecklistValue> checklists;

  CheckListAddFormatChangeModel({
    required this.listName,
    required this.userId,
    required this.date,
    required this.locationId,
    required this.sectorFrom,
    required this.sectorTo,
    required this.otherLists,
    required this.checklists,
  });

  factory CheckListAddFormatChangeModel.fromJson(Map<String, dynamic> json) => CheckListAddFormatChangeModel(
        listName: json["listName"] ?? "",
        userId: json["userId"] ?? "",
        date: json["date"] ?? "",
        locationId: json["locationId"] ?? "",
        sectorFrom: json["sectorFrom"] ?? "",
        sectorTo: json["sectorTo"] ?? "",
        otherLists: OtherLists.fromJson(json["otherlists"] ?? {}),
        checklists: List<ChecklistValue>.from((json["checklists"] ?? []).map((x) => ChecklistValue.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "listName": listName,
        "userId": userId,
        "date": date,
        "locationId": locationId,
        "sectorFrom": sectorFrom,
        "sectorTo": sectorTo,
        "otherlists": otherLists.toJson(),
        "checklists": List<dynamic>.from(checklists.map((x) => x.toJson())),
      };
}

class ChecklistValue {
  String fieldName;
  List<Check> checks;
  String remarks;

  ChecklistValue({
    required this.fieldName,
    required this.checks,
    required this.remarks,
  });

  factory ChecklistValue.fromJson(Map<String, dynamic> json) => ChecklistValue(
        fieldName: json["fieldName"] ?? "",
        checks: List<Check>.from((json["checks"] ?? []).map((x) => Check.fromJson(x))),
        remarks: json["remarks"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "fieldName": fieldName,
        "checks": List<dynamic>.from(checks.map((x) => x.toJson())),
        "remarks": remarks,
      };
}

class Check {
  String name;
  bool status;

  Check({
    required this.name,
    required this.status,
  });

  factory Check.fromJson(Map<String, dynamic> json) => Check(
        name: json["name"] ?? "",
        status: json["is_check_selected"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "status": status,
      };
}

class OtherLists {
  String fieldName;
  List<Check> checks;
  String remarks;

  OtherLists({
    required this.fieldName,
    required this.checks,
    required this.remarks,
  });

  factory OtherLists.fromJson(Map<String, dynamic> json) => OtherLists(
        fieldName: json["fieldName"] ?? "",
        checks: List<Check>.from((json["checks"] ?? []).map((x) => Check.fromJson(x))),
        remarks: json["remarks"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "fieldName": fieldName,
        "checks": List<dynamic>.from(checks.map((x) => x.toJson())),
        "remarks": remarks,
      };
}
