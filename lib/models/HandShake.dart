
import 'dart:convert';

HandShakeModel handShakeFromJson(String str) => HandShakeModel.fromJson(json.decode(str));
String handShakeToJson(HandShakeModel data) => json.encode(data.toJson());

List<HandShakeModel> userHandShakeFromJson(String str) =>
    List<HandShakeModel>.from(json.decode(str).map((x) => HandShakeModel.fromJson(x)));


class HandShakeModel {
  HandShakeModel({
    required this.status,
    required this.code,
    required this.description,
    required this.body,
  });

  bool status;
  String code;
  String description;
  Body body;

  factory HandShakeModel.fromJson(Map<String, dynamic> json) => HandShakeModel(
    status: json["status"],
    code: json["code"],
    description: json["description"],
    body: Body.fromJson(json["body"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "description": description,
    "body": body.toJson(),
  };
}

class Body {
  Body({
    required this.handshake,
    required this.termsAndConditionsBit,
    required this.termsAndConditionsOnboardBit,
    required this.statusBit,
    required this.actionBit,
    required this.remarks,
    required this.remarksKh,
  });

  Handshake handshake;
  String termsAndConditionsBit;
  String termsAndConditionsOnboardBit;
  bool statusBit;
  bool actionBit;
  String remarks;
  String remarksKh;

  factory Body.fromJson(Map<String, dynamic> json) => Body(
    handshake: Handshake.fromJson(json["handshake"]),
    termsAndConditionsBit: json["termsAndConditionsBit"],
    termsAndConditionsOnboardBit: json["termsAndConditionsOnboardBit"],
    statusBit: json["statusBit"],
    actionBit: json["actionBit"],
    remarks: json["remarks"],
    remarksKh: json["remarksKh"],
  );

  Map<String, dynamic> toJson() => {
    "handshake": handshake.toJson(),
    "termsAndConditionsBit": termsAndConditionsBit,
    "termsAndConditionsOnboardBit": termsAndConditionsOnboardBit,
    "statusBit": statusBit,
    "actionBit": actionBit,
    "remarks": remarks,
    "remarksKh": remarksKh,
  };
}

class Handshake {
  Handshake({
    required this.publicKey,
    required this.id,
  });

  String publicKey;
  String id;

  factory Handshake.fromJson(Map<String, dynamic> json) => Handshake(
    publicKey: json["publicKey"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "publicKey": publicKey,
    "id": id,
  };
}
