import 'package:belajar_api/service/barang_service.dart';
import 'package:flutter/material.dart';

import 'detailPage.dart';
import 'model/barang.dart';

class ListBarang extends StatelessWidget {
  const ListBarang({Key? key, this.barang}) : super(key: key);

  final List<Barang>? barang;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 250,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: barang!.length,
          itemBuilder: (context, index) {
            return Container(
                margin: const EdgeInsets.only(right: 20),
                child: InkWell(
                  onTap: (() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DetailPage(data: barang![index])));
                  }),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Card(
                      color: Colors.transparent,
                      shadowColor: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Image.network(
                              'http://127.0.0.1:8000/${barang![index].image}',
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 4),
                            child: Text(
                              barang![index].namaBarang,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ),
                          
                          Text(
                            "Rp. ${barang![index].harga},-",
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                ));
          },
        ));
  }
}
