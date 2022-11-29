import 'dart:convert';

import 'package:belajar_api/model/barang.dart';
import 'package:belajar_api/service/barang_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'cartPage.dart';
import 'listBarang.dart';

void main() {
  runApp(MyApp(
    barangPakansari: BarangService().fetchBarangPakansari(),
    barangPasarRebo: BarangService().fetchBarangPasarRebo(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp(
      {Key? key, required this.barangPakansari, required this.barangPasarRebo})
      : super(key: key);

  final Future<List<Barang>>? barangPasarRebo;
  final Future<List<Barang>>? barangPakansari;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lotte',
      theme: ThemeData(
        primaryColor: Colors.red[900],
      ),
      home: HomePage(
        title: 'LOTTE',
        barangPakansari: barangPakansari,
        barangPasarRebo: barangPasarRebo,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage(
      {Key? key,
      required this.title,
      required this.barangPakansari,
      required this.barangPasarRebo})
      : super(key: key);

  final Future<List<Barang>>? barangPakansari;
  final Future<List<Barang>>? barangPasarRebo;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CartPage())),
            icon: Icon(Icons.shopping_cart),
          )
        ],
        backgroundColor: Colors.red[900],
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: const Text(
              "Lotte Pasar Rebo",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
          FutureBuilder<List<Barang>>(
            future: barangPasarRebo,
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);
              return snapshot.hasData
                  ? ListBarang(barang: snapshot.data)
                  : Center(
                      child: CircularProgressIndicator(
                          backgroundColor: Colors.transparent));
            },
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: const Text(
              "Lotte Pakansari",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
          FutureBuilder<List<Barang>>(
            future: barangPakansari,
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);
              return snapshot.hasData
                  ? ListBarang(barang: snapshot.data)
                  : Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.transparent,
                      ),
                    );
            },
          ),
        ],
      ),
    );
  }
}
