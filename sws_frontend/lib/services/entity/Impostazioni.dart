// To parse this JSON data, do
//
//     final impostazioni = impostazioniFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';

Impostazioni impostazioniFromJson(String str) => Impostazioni.fromJson(json.decode(str));

String impostazioniToJson(Impostazioni data) => json.encode(data.toJson());

class Impostazioni {
  Impostazioni({
    this.id,
    required this.icon,
    required this.idEnte,
    required this.idArea,
    required this.privacyPolicy,
  });

  String? id;
  String icon;
  String idEnte;
  String idArea;
  String privacyPolicy;

  factory Impostazioni.fromJson(Map<String, dynamic> json) => Impostazioni(
    id: json["id"],
    icon: json["icon"],
    idEnte: json["idEnte"],
    idArea: json["idArea"],
    privacyPolicy: json["privacyPolicy"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "icon": icon,
    "idEnte": idEnte,
    "idArea": idArea,
    "privacyPolicy": privacyPolicy,
  };
  IconData getIconData(){

    return IconData(int.parse(icon!),fontFamily: "MaterialIcons");
  }
}
