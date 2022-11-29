import 'package:belajar_api/main.dart';
import 'package:belajar_api/service/cart_service.dart';
import 'package:flutter/material.dart';
import 'buttonCounter.dart';
import 'model/cart.dart';
import 'dart:convert';

import 'service/barang_service.dart';

class CartPage extends StatefulWidget {
  const CartPage({
    Key? key,
  }) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final Future<List<Cart>> datas = CartService().fetchBarang();
  int _totalHarga = 0;

  void _payAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Confirm"),
        content: Text("Bayar sekarang?"),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "Nanti deh",
                style: TextStyle(color: Colors.red[900]),
              )),
          TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyApp(
                              barangPakansari:
                                  BarangService().fetchBarangPakansari(),
                              barangPasarRebo:
                                  BarangService().fetchBarangPasarRebo(),
                            )));
                CartService().deleteAllData();
              },
              child: Text("Bayar", style: TextStyle(color: Colors.red[900]))),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Checkout")),
          backgroundColor: Colors.red[900],
        ),
        body: FutureBuilder<List<Cart>>(
          future: datas,
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return !snapshot.hasData
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: snapshot.data!.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 600,
                        // margin: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                    child: ListTile(
                                  leading: Image.network(
                                      'http://127.0.0.1:8000/${snapshot.data![index].imageBarang}',
                                      width: 60,
                                      fit: BoxFit.cover),
                                  title: Text(
                                    snapshot.data![index].namaBarang!,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                  ),
                                  subtitle: Text(
                                    snapshot.data![index].hargaBarang!
                                        .toString(),
                                    style: const TextStyle(fontSize: 11),
                                  ),
                                )),
                                Container(
                                    margin: const EdgeInsets.only(top: 45),
                                    child: Row(
                                      children: [
                                        // Text(
                                        //   "Rp. ${snapshot.data![index].totalHarga!.toString()},-",
                                        //   style: const TextStyle(
                                        //       fontWeight: FontWeight.bold,
                                        //       fontSize: 13),
                                        // ),
                                        ButtonCounterCustom(
                                          startCounter: snapshot
                                              .data![index].totalBarang!,
                                          currentCounter: (value) {
                                            setState(() {
                                              snapshot.data![index].totalHarga =
                                                  value *
                                                      snapshot.data![index]
                                                          .hargaBarang!;
                                              _totalHarga = 0;
                                            });
                                          },
                                        ),
                                      ],
                                    ))
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
            // ListCart(items: snapshot.data);
          },
        ),
        bottomNavigationBar: FutureBuilder<List<Cart>>(
          future: datas,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              for (var value in snapshot.data!) {
                _totalHarga += value.totalHarga!;
              }
            } else {
              _totalHarga = 0;
            }
            return Container(
              height: 35,
              child: Row(children: [
                Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Row(
                        children: [
                          Text("Total: "),
                          Text(
                            "Rp. ${_totalHarga.toString()}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    )),
                Expanded(
                  child: Container(
                    height: 40,
                    color: Colors.red[900],
                    child: TextButton(
                      onPressed: () {
                        _payAlert(context);
                      },
                      child: const Text(
                        "Checkout",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                )
              ]),
            );
          },
        )
        // body: FutureBuilder(
        //   future: _getListBarang(),
        //   builder: (context, _) {
        //     return Card(
        //       child: Text(nama_barang!),
        //     );
        //   },
        // )
        // Container(
        //   padding: EdgeInsets.all(15),
        //   child: Card(
        //     child: Text(widget.data.harga),
        //   ),
        // ),
        // bottomNavigationBar: Container(
        //   height: 35,
        //   child: Row(children: [
        //     Expanded(
        //         flex: 2,
        //         child: Row(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [Text("Total: "), Text(dataList!.totalHarga!)],
        //         )),
        //     Expanded(
        //       child: Container(
        //         color: Colors.red[900],
        //         child: TextButton(
        //           onPressed: () {},
        //           child: const Text(
        //             "Checkout",
        //             style: TextStyle(color: Colors.white),
        //           ),
        //         ),
        //       ),
        //     )
        //   ]),
        // ),
        );
  }
}
