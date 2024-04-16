// To parse this JSON data, do
//
//     final term = termFromJson(jsonString);

import 'dart:convert';

String termToJson(Term data) => json.encode(data.toJson());

class Term {
  Term({
    required this.id,
    required this.type,
  });

  String id;
  String type;

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
  };
}
