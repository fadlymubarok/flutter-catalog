import 'dart:convert';

import 'package:belajar_api/model/barang.dart';
import 'package:http/http.dart' as http;

class BarangService {
  static final String _baseUrl = 'http://127.0.0.1:8000/api/barang';

  List<Barang> parseBarang(String responseBody) {
    final responseJson = json.decode(responseBody);
    List<dynamic> responseData = (responseJson as Map<String, dynamic>)['data'];
    return responseData.map<Barang>((json) => Barang.fromJson(json)).toList();
  }

  Future<List<Barang>> fetchBarang() async {
    final response = await http.get(Uri.parse(_baseUrl));
    if (response.statusCode == 200) {
      return parseBarang(response.body.toString());
    } else {
      throw new Exception("Failed to load barang");
    }
  }

  Future<List<Barang>> fetchBarangPasarRebo() async {
    final response = await http.get(Uri.parse("$_baseUrl/pasar_rebo"));
    if (response.statusCode == 200) {
      return parseBarang(response.body.toString());
    } else {
      throw new Exception("Failed to load barang");
    }
  }

  Future<List<Barang>> fetchBarangPakansari() async {
    final response = await http.get(Uri.parse("$_baseUrl/pakansari"));
    if (response.statusCode == 200) {
      return parseBarang(response.body.toString());
    } else {
      throw new Exception("Failed to load barang");
    }
  }
}
