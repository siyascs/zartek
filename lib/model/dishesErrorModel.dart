import 'dart:convert';

DishesErrorModel userErrorFromJson(String str) => DishesErrorModel.fromJson(json.decode(str));

String userErrorToJson(DishesErrorModel data) => json.encode(data.toJson());

class DishesErrorModel {
  DishesErrorModel({
    this.code,
    this.message,
  });

  int code;
  String message;

  factory DishesErrorModel.fromJson(Map<String, dynamic> json) => DishesErrorModel(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
  };
}