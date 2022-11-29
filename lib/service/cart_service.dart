import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/barang.dart';
import '../model/cart.dart';

class CartService {
  final String _baseUrl = 'http://127.0.0.1:8000/api/cart';

  Future<List<Cart>> fetchBarang() async {
    final uri = Uri.parse(_baseUrl);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      return parseBarang(response.body.toString());
    } else {
      throw new Exception("Data gagal diload");
    }
  }

  List<Cart> parseBarang(String responseBody) {
    final responseJson = json.decode(responseBody);
    List<dynamic> responseData = (responseJson as Map<String, dynamic>)['data'];
    return responseData.map<Cart>((json) => Cart.fromJson(json)).toList();
  }

  Future storeData({required int id}) async {
    final response = await http.post(Uri.parse(_baseUrl), body: {
      "barang_id": id.toString(),
    });
    // String uri = 'http://127.0.0.1:8000/api/cart';
    // if(response.statusCode == 200) {
    //   debugPrint("Data berhasil di kirim");
    // } else {
    //   debugPrint("Data gagal di kirim");
    // }
  }

  Future deleteAllData() async {
    final response = await http.delete(Uri.parse(_baseUrl));
  }
}
