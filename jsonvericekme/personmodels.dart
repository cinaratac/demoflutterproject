// To parse this JSON data, do
//
//     final persons = personsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Persons personsFromJson(String str) => Persons.fromJson(json.decode(str));

String personsToJson(Persons data) => json.encode(data.toJson());

class Persons {
  List<Person> persons;

  Persons({required this.persons});

  factory Persons.fromJson(Map<String, dynamic> json) => Persons(
    persons: List<Person>.from(json["persons"].map((x) => Person.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "persons": List<dynamic>.from(persons.map((x) => x.toJson())),
  };
}

class Person {
  int id;
  String isim;
  bool erkekMi;
  List<String> sevdigirenkler;
  List<Adre> adres;

  Person({
    required this.id,
    required this.isim,
    required this.erkekMi,
    required this.sevdigirenkler,
    required this.adres,
  });

  factory Person.fromJson(Map<String, dynamic> json) => Person(
    id: json["id"],
    isim: json["isim"],
    erkekMi: json["erkekMi"],
    sevdigirenkler: List<String>.from(json["sevdigirenkler"].map((x) => x)),
    adres: List<Adre>.from(json["adres"].map((x) => Adre.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "isim": isim,
    "erkekMi": erkekMi,
    "sevdigirenkler": List<dynamic>.from(sevdigirenkler.map((x) => x)),
    "adres": List<dynamic>.from(adres.map((x) => x.toJson())),
  };
}

class Adre {
  String il;
  String ilce;
  String tur;

  Adre({required this.il, required this.ilce, required this.tur});

  factory Adre.fromJson(Map<String, dynamic> json) =>
      Adre(il: json["il"], ilce: json["ilce"], tur: json["tur"]);

  Map<String, dynamic> toJson() => {"il": il, "ilce": ilce, "tur": tur};
}
