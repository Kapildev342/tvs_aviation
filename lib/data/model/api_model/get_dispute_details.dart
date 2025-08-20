import 'dart:convert';

GetDisputeDetails getDisputeDetailsFromJson(String str) => GetDisputeDetails.fromJson(json.decode(str));

String getDisputeDetailsToJson(GetDisputeDetails data) => json.encode(data.toJson());

class GetDisputeDetails {
  final bool status;
  final StockDispute stockDispute;
  final List<Product> products;

  GetDisputeDetails({
    required this.status,
    required this.stockDispute,
    required this.products,
  });

  factory GetDisputeDetails.fromJson(Map<String, dynamic> json) => GetDisputeDetails(
        status: json["status"] ?? false,
        stockDispute: StockDispute.fromJson(json["stockDispute"] ?? {}),
        products: List<Product>.from((json["products"] ?? []).map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "stockDispute": stockDispute.toJson(),
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}

class Product {
  final int quantity;
  final String barcode;
  final String photo;
  final String productName;
  final String brandName;
  final String monthOfPurchase;
  final String expiry;

  Product({
    required this.quantity,
    required this.barcode,
    required this.photo,
    required this.productName,
    required this.brandName,
    required this.monthOfPurchase,
    required this.expiry,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        quantity: json["quantity"] ?? 0,
        barcode: json["barcode"] ?? "",
        photo: json["photo"] ?? "",
        productName: json["productName"] ?? "",
        brandName: json["brandName"] ?? "",
        monthOfPurchase: json["monthOfPurchase"] ?? "",
        expiry: json["expiry"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "quantity": quantity,
        "barcode": barcode,
        "photo": photo,
        "productName": productName,
        "brandName": brandName,
        "monthOfPurchase": monthOfPurchase,
        "expiry": expiry,
      };
}

class StockDispute {
  final String id;
  final String disputeReason;
  final String comments;
  final String adminComments;
  final bool resolve;
  final String createdAt;
  final String stockDisputeId;
  final int totalProducts;
  final int totalQuantity;
  final String crew;
  final String location;

  StockDispute({
    required this.id,
    required this.disputeReason,
    required this.comments,
    required this.adminComments,
    required this.resolve,
    required this.createdAt,
    required this.stockDisputeId,
    required this.totalProducts,
    required this.totalQuantity,
    required this.crew,
    required this.location,
  });

  factory StockDispute.fromJson(Map<String, dynamic> json) => StockDispute(
        id: json["_id"] ?? "",
        disputeReason: json["disputeReason"] ?? "",
        comments: json["comments"] ?? "",
        adminComments: json["adminComments"] ?? "",
        resolve: json["resolve"] ?? false,
        createdAt: json["createdAt"] ?? "",
        stockDisputeId: json["stockDisputeId"] ?? "",
        totalProducts: json["totalProducts"] ?? 0,
        totalQuantity: json["totalQuantity"] ?? 0,
        crew: json["crew"] ?? "",
        location: json["location"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "disputeReason": disputeReason,
        "comments": comments,
        "adminComments": adminComments,
        "resolve": resolve,
        "createdAt": createdAt,
        "stockDisputeId": stockDisputeId,
        "totalProducts": totalProducts,
        "totalQuantity": totalQuantity,
        "crew": crew,
        "location": location,
      };
}
