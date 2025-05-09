// To parse this JSON data, do
//
//     final modelListDataUser = modelListDataUserFromJson(jsonString);

import 'dart:convert';

ModelListDataUser modelListDataUserFromJson(String str) => ModelListDataUser.fromJson(json.decode(str));

String modelListDataUserToJson(ModelListDataUser data) => json.encode(data.toJson());

class ModelListDataUser {

  final int? page;
  final int? perPage;
  final int? total;
  final int? totalPages;
  final List<DataUser>? data;
  final Support? support;

  // int page;
  // int perPage;
  // int total;
  // int totalPages;
  // List<DataUser> data;
  // Support support;

  ModelListDataUser({
    // required this.page,
    // required this.perPage,
    // required this.total,
    // required this.totalPages,
    // required this.data,
    // required this.support,

    this.page,
    this.perPage,
    this.total,
    this.totalPages,
    this.data,
    this.support,
  });

  factory ModelListDataUser.fromJson(Map<String, dynamic> json) => ModelListDataUser(
    // page: json["page"],
    // perPage: json["per_page"],
    // total: json["total"],
    // totalPages: json["total_pages"],
    // data: List<DataUser>.from(json["data"].map((x) => DataUser.fromJson(x))),
    // support: Support.fromJson(json["support"]),

    page: json["page"] is int ? json["page"] : null,
    perPage: json["per_page"] is int ? json["per_page"] : null,
    total: json["total"] is int ? json["total"] : null,
    totalPages: json["total_pages"] is int ? json["total_pages"] : null,
    data: json["data"] == null
        ? []
        : List<DataUser>.from(json["data"].map((x) => DataUser.fromJson(x))),
    support: json["support"] == null ? null : Support.fromJson(json["support"]),

  );

  Map<String, dynamic> toJson() => {
    // "page": page,
    // "per_page": perPage,
    // "total": total,
    // "total_pages": totalPages,
    // "data": List<dynamic>.from(data.map((x) => x.toJson())),
    // "support": support.toJson(),

    "page": page,
    "per_page": perPage,
    "total": total,
    "total_pages": totalPages,
    "data": data?.map((x) => x.toJson()).toList(),
    "support": support?.toJson(),
  };
}

class DataUser {
  // int id;
  // String email;
  // String firstName;
  // String lastName;
  // String avatar;

  final int? id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? avatar;

  DataUser({

    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.avatar,
    //
    // required this.id,
    // required this.email,
    // required this.firstName,
    // required this.lastName,
    // required this.avatar,
  });

  factory DataUser.fromJson(Map<String, dynamic> json) => DataUser(
    // id: json["id"],
    // email: json["email"],
    // firstName: json["first_name"],
    // lastName: json["last_name"],
    // avatar: json["avatar"],


    id: json["id"] is int ? json["id"] : null,
    email: json["email"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    avatar: json["avatar"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "first_name": firstName,
    "last_name": lastName,
    "avatar": avatar,
  };
}

class Support {
  String url;
  String text;

  Support({
    required this.url,
    required this.text,
  });

  factory Support.fromJson(Map<String, dynamic> json) => Support(
    url: json["url"],
    text: json["text"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "text": text,
  };
}
