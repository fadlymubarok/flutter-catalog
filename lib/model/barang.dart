import 'package:http/http.dart' as http;
import 'dart:convert';

List<Barang> barangFromJson(String str) =>
    List<Barang>.from(json.decode(str).map((x) => Barang.fromJson(x)));

String barangToJson(List<Barang> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Barang {
  int? id;
  String namaBarang;
  String harga;
  String image;
  String category;
  String? deskripsi;

  Barang(
      {required this.id,
      required this.namaBarang,
      required this.harga,
      required this.image,
      required this.category,
      required this.deskripsi});

  factory Barang.fromJson(Map<String, dynamic> json) {
    return Barang(
        id: json['id'],
        namaBarang: json['nama_barang'],
        harga: json['harga'],
        image: json['image'],
        category: json['category'],
        deskripsi: json['deskripsi']);
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama_barang": namaBarang,
        "harga": harga,
        "image": image,
        "category": category,
        "deskripsi": deskripsi
      };
}
