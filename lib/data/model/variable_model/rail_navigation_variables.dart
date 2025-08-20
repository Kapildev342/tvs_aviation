import 'dart:convert';

RailNavigationVariables railNavigationVariablesFromJson(String str) => RailNavigationVariables.fromJson(json.decode(str));

String railNavigationVariablesToJson(RailNavigationVariables data) => json.encode(data.toJson());

class RailNavigationVariables {
  bool loader;
  bool isDrawerOpen;
  int drawerSelectedIndex;
  int mainSelectedIndex;
  List<TabsDatum> tabsData;

  RailNavigationVariables({
    required this.loader,
    required this.isDrawerOpen,
    required this.drawerSelectedIndex,
    required this.mainSelectedIndex,
    required this.tabsData,
  });

  factory RailNavigationVariables.fromJson(Map<String, dynamic> json) => RailNavigationVariables(
        loader: json["loader"] ?? false,
        isDrawerOpen: json["is_drawer_open"] ?? false,
        drawerSelectedIndex: json["drawer_selected_index"] ?? 0,
        mainSelectedIndex: json["main_selected_index"] ?? 0,
        tabsData: List<TabsDatum>.from((json["tabs_data"] ??
                [
                  {
                    "heading": "Reports",
                    "drawer_data": [
                      {"image_data": "assets/rail_navigation/reports_file/overall.png", "text": "Overall Stock In Hand"},
                      {"image_data": "assets/rail_navigation/reports_file/low_stock.png", "text": "Low Stock"},
                      {"image_data": "assets/rail_navigation/reports_file/expiry.png", "text": "Expiry"},
                      {"image_data": "assets/rail_navigation/reports_file/dispute.png", "text": "Dispute"},
                      {"image_data": "assets/rail_navigation/reports_file/transaction.png", "text": "Transaction History"},
                      {"image_data": "assets/rail_navigation/reports_file/cabin.png", "text": "Cabin And Galley"},
                      {"image_data": "assets/rail_navigation/check_list_file/pre_flight.png", "text": "Pre Flight Checklist"},
                      {"image_data": "assets/rail_navigation/check_list_file/post_flight.png", "text": "Post Flight Checklist"},
                      {"image_data": "assets/rail_navigation/check_list_file/maintenance.png", "text": "Maintenance Checklist"}
                    ]
                  },
                  {
                    "heading": "Checklist",
                    "drawer_data": [
                      {"image_data": "assets/rail_navigation/check_list_file/pre_flight.png", "text": "Pre Flight Checklist"},
                      {"image_data": "assets/rail_navigation/check_list_file/post_flight.png", "text": "Post Flight Checklist"},
                      {"image_data": "assets/rail_navigation/check_list_file/maintenance.png", "text": "Maintenance Checklist"}
                    ]
                  },
                  {
                    "heading": "Manage",
                    "drawer_data": [
                      {"image_data": "assets/rail_navigation/manage_file/inventory.png", "text": "Add Inventory"},
                      {"image_data": "assets/rail_navigation/manage_file/product_type.png", "text": "Product "},
                      {"image_data": "assets/rail_navigation/manage_file/product_type.png", "text": "Brand/Type"},
                      {"image_data": "assets/rail_navigation/manage_file/category.png", "text": "Category"},
                      {"image_data": "assets/rail_navigation/manage_file/crew.png", "text": "Crew"},
                      {"image_data": "assets/rail_navigation/manage_file/handler.png", "text": "Handler"},
                      {"image_data": "assets/rail_navigation/manage_file/warehouse.png", "text": "My Warehouse"},
                      {"image_data": "assets/rail_navigation/manage_file/aircraft.png", "text": "Aircraft"},
                      {"image_data": "assets/rail_navigation/manage_file/sector.png", "text": "Sector"},
                    ]
                  }
                ])
            .map((x) => TabsDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "loader": loader,
        "drawer_selected_index": drawerSelectedIndex,
        "main_selected_index": mainSelectedIndex,
        "is_drawer_open": isDrawerOpen,
        "tabs_data": List<dynamic>.from(tabsData.map((x) => x.toJson())),
      };
}

class TabsDatum {
  final String heading;
  final List<DrawerDatum> drawerData;

  TabsDatum({
    required this.heading,
    required this.drawerData,
  });

  factory TabsDatum.fromJson(Map<String, dynamic> json) => TabsDatum(
        heading: json["heading"] ?? "",
        drawerData: List<DrawerDatum>.from((json["drawer_data"] ?? []).map((x) => DrawerDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "heading": heading,
        "drawer_data": List<dynamic>.from(drawerData.map((x) => x.toJson())),
      };
}

class DrawerDatum {
  final String imageData;
  final String text;

  DrawerDatum({
    required this.imageData,
    required this.text,
  });

  factory DrawerDatum.fromJson(Map<String, dynamic> json) => DrawerDatum(
        imageData: json["image_data"] ?? "",
        text: json["text"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "image_data": imageData,
        "text": text,
      };
}
