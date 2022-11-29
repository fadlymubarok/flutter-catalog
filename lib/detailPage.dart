import 'package:belajar_api/cartPage.dart';
import 'package:belajar_api/listBarang.dart';
import 'package:belajar_api/service/cart_service.dart';
import 'dart:convert';
import 'model/barang.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key, required this.data}) : super(key: key);
  final Barang data;

  // Future<void> _setDataBarang() async {
  //   int jumlah = 1;
  //   final pref = await SharedPreferences.getInstance();

  //   if (pref.containsKey('_setBarang')) {
  //     pref.clear();
  //   }

  //   final _setBarang = json.encode({
  //     'nama_barang': data.namaBarang.toString(),
  //     'harga_barang': data.harga.toString(),
  //     'image_barang': data.image.toString(),
  //     'jumlah_barang': jumlah,
  //     'total_harga': data.harga.toString()
  //   });

  //   await pref.setString('list_barang', _setBarang);
  // }

  void _showAlert(BuildContext context, String nama_barang) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Berhasil!!"),
              content: Text("$nama_barang berhasil ditambah"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Kembali",
                        style: TextStyle(color: Colors.red[900]))),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CartPage(),
                          ));
                    },
                    child: Text("Lihat Cart",
                        style: TextStyle(color: Colors.red[900])))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(child: Text(data.namaBarang)),
          backgroundColor: Colors.red[900],
          actions: [
            IconButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const CartPage())),
                icon: Icon(Icons.shopping_cart))
          ]
          // const [Icon(Icons.shopping_cart)],
          ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Image.network("http://127.0.0.1:8000/${data.image}",
                fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                data.namaBarang,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 18),
              child: Text(
                "Rp. ${data.harga},-",
                style: const TextStyle(fontSize: 13, color: Colors.blue),
              ),
            ),
            const Text("Description",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                data.deskripsi!,
                style: const TextStyle(fontSize: 13),
              ),
            ),
          ]),
        ),
      ),
      bottomNavigationBar: Container(
          height: 45,
          color: Colors.red[900],
          child: TextButton(
            onPressed: () {
              _showAlert(context, data.namaBarang);
              // _setDataBarang();
              // _storeData(item: data);
              final cart = CartService().storeData(id: data.id!);
            },
            child: const Text(
              "Add To Cart",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          )),
    );
  }
}
