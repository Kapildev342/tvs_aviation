import 'dart:convert';

ManualVariables manualVariablesFromJson(String str) => ManualVariables.fromJson(json.decode(str));

String manualVariablesToJson(ManualVariables data) => json.encode(data.toJson());

class ManualVariables {
  bool loader;
  String filePath;

  ManualVariables({
    required this.loader,
    required this.filePath,
  });

  factory ManualVariables.fromJson(Map<String, dynamic> json) => ManualVariables(
        loader: json["loader"] ?? false,
        filePath: json["file_path"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "loader": loader,
        "file_path": filePath,
      };
}
