import 'barang.dart';

class Cart {
  
  int? idBarang;
  String? namaBarang;
  int? hargaBarang;
  String? imageBarang;
  int? totalBarang;
  int? totalHarga;

  Cart(
      {this.idBarang,
      this.namaBarang,
      this.hargaBarang,
      this.imageBarang,
      this.totalBarang,
      this.totalHarga});

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      idBarang: (json['barang_id'] != null) ? json['barang_id'] : 0,
      namaBarang:
          (json['nama_barang'] != null) ? json['nama_barang'].toString() : "",
      hargaBarang: (json['harga'] != null) ? json['harga'] : 0,
      imageBarang: (json['image'] != null) ? json['image'].toString() : "",
      totalBarang: (json['total_barang'] != null) ? json['total_barang'] : 0,
      totalHarga: (json['total_harga'] != null) ? json['total_harga'] : 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "barang_id": idBarang,
        "nama_barang": namaBarang,
        "harga": hargaBarang,
        "image": imageBarang,
        "total_barang": totalBarang,
        "total_harga": totalHarga
      };
}
