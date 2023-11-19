// To parse this JSON data, do
//
//     final detailPaketModel = detailPaketModelFromJson(jsonString);

import 'dart:convert';

DetailPaketModel detailPaketModelFromJson(String str) => DetailPaketModel.fromJson(json.decode(str));

String detailPaketModelToJson(DetailPaketModel data) => json.encode(data.toJson());

class DetailPaketModel {
    String namaPemesan;
    String tanggalPesanan;
    String kodePesanan;
    String alamatPengiriman;
    Distance distance;
    Distance duration;
    String overviewPolyline;
    String lat;
    String long;
    String status;
    List<ListBarang> listBarang;
    String? bukti;

    DetailPaketModel({
        required this.namaPemesan,
        required this.tanggalPesanan,
        required this.kodePesanan,
        required this.alamatPengiriman,
        required this.distance,
        required this.duration,
        required this.overviewPolyline,
        required this.lat,
        required this.long,
        required this.listBarang,
        required this.status,
        this.bukti
    });

    factory DetailPaketModel.fromJson(Map<String, dynamic> json) => DetailPaketModel(
        namaPemesan: json["nama_pemesan"],
        tanggalPesanan: json["tanggal_pesanan"],
        kodePesanan: json["kode_pesanan"],
        alamatPengiriman: json["alamat_pengiriman"],
        distance: Distance.fromJson(json["distance"]),
        duration: Distance.fromJson(json["duration"]),
        overviewPolyline: json["overview_polyline"],
        lat: json["lat"],
        long: json["long"],
        status: json["status"],
        listBarang: List<ListBarang>.from(json["listBarang"].map((x) => ListBarang.fromJson(x))),
        bukti:json["foto_bukti_penerima"]
    );

    Map<String, dynamic> toJson() => {
        "nama_pemesan": namaPemesan,
        "tanggal_pesanan": tanggalPesanan,
        "kode_pesanan": kodePesanan,
        "alamat_pengiriman": alamatPengiriman,
        "distance": distance.toJson(),
        "duration": duration.toJson(),
        "overview_polyline": overviewPolyline,
        "lat": lat,
        "long": long,
        "status": status,
        "listBarang": List<dynamic>.from(listBarang.map((x) => x.toJson())),
        "foto_bukti_penerima":bukti,
    };
}

class Distance {
    String text;
    int value;

    Distance({
        required this.text,
        required this.value,
    });

    factory Distance.fromJson(Map<String, dynamic> json) => Distance(
        text: json["text"],
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "text": text,
        "value": value,
    };
}

class ListBarang {
    String id;
    String idPemesanan;
    String namaBarang;

    ListBarang({
        required this.id,
        required this.idPemesanan,
        required this.namaBarang,
    });

    factory ListBarang.fromJson(Map<String, dynamic> json) => ListBarang(
        id: json["id"],
        idPemesanan: json["id_pemesanan"],
        namaBarang: json["nama_barang"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "id_pemesanan": idPemesanan,
        "nama_barang": namaBarang,
    };
}
