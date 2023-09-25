import 'dart:convert';

NewsModel newsModelFromJson(String str) => NewsModel.fromJson(json.decode(str));

String newsModelToJson(NewsModel data) => json.encode(data.toJson());

class NewsModel {
  int idBerita;
  String idKategori;
  String title;
  String content;
  String fotoBerita;
  DateTime createdBerita;
  String statusBerita;

  NewsModel({
    required this.idBerita,
    required this.idKategori,
    required this.title,
    required this.content,
    required this.fotoBerita,
    required this.createdBerita,
    required this.statusBerita,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        idBerita: json["id_berita"],
        idKategori: json["id_kategori"],
        title: json["title"],
        content: json["content"],
        fotoBerita: json["foto_berita"],
        createdBerita: DateTime.parse(json["created_berita"]),
        statusBerita: json["status_berita"],
      );

  Map<String, dynamic> toJson() => {
        "id_berita": idBerita,
        "id_kategori": idKategori,
        "title": title,
        "content": content,
        "foto_berita": fotoBerita,
        "created_berita": createdBerita.toIso8601String(),
        "status_berita": statusBerita,
      };
}
