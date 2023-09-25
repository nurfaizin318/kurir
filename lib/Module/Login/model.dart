import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  Headers headers;
  Original original;
  dynamic exception;

  UserModel({
    required this.headers,
    required this.original,
    required this.exception,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        headers: Headers.fromJson(json["headers"]),
        original: Original.fromJson(json["original"]),
        exception: json["exception"],
      );

  Map<String, dynamic> toJson() => {
        "headers": headers.toJson(),
        "original": original.toJson(),
        "exception": exception,
      };
}

class Headers {
  Headers();

  factory Headers.fromJson(Map<String, dynamic> json) => Headers();

  Map<String, dynamic> toJson() => {};
}

class Original {
  String accessToken;
  User user;

  Original({
    required this.accessToken,
    required this.user,
  });

  factory Original.fromJson(Map<String, dynamic> json) => Original(
        accessToken: json["access_token"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "user": user.toJson(),
      };
}

class User {
  String id;
  String fullnama;
  String email;
  String noTelepon;
  String countrycode;
  String phone;
  DateTime createdOn;
  String jenis;
  DateTime tglLahir;
  int ratingPelanggan;
  int status;
  String fotopelanggan;
  int israte;
  String idDriver;
  String idTransaksi;
  String totalBiaya;
  String pakaiWallet;
  String namaDriver;
  String fotoDriver;
  String fitur;
  String response;
  int pointDriver;
  int istopup;
  String noreff;
  int islogin;
  String group;
  String role;

  User({
    required this.id,
    required this.fullnama,
    required this.email,
    required this.noTelepon,
    required this.countrycode,
    required this.phone,
    required this.createdOn,
    required this.jenis,
    required this.tglLahir,
    required this.ratingPelanggan,
    required this.status,
    required this.fotopelanggan,
    required this.israte,
    required this.idDriver,
    required this.idTransaksi,
    required this.totalBiaya,
    required this.pakaiWallet,
    required this.namaDriver,
    required this.fotoDriver,
    required this.fitur,
    required this.response,
    required this.pointDriver,
    required this.istopup,
    required this.noreff,
    required this.islogin,
    required this.group,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        fullnama: json["fullnama"],
        email: json["email"],
        noTelepon: json["no_telepon"],
        countrycode: json["countrycode"],
        phone: json["phone"],
        createdOn: DateTime.parse(json["created_on"]),
        jenis: json["jenis"],
        tglLahir: DateTime.parse(json["tgl_lahir"]),
        ratingPelanggan: json["rating_pelanggan"],
        status: json["status"],
        fotopelanggan: json["fotopelanggan"],
        israte: json["israte"],
        idDriver: json["id_driver"],
        idTransaksi: json["id_transaksi"],
        totalBiaya: json["total_biaya"],
        pakaiWallet: json["pakai_wallet"],
        namaDriver: json["nama_driver"],
        fotoDriver: json["foto_driver"],
        fitur: json["fitur"],
        response: json["response"],
        pointDriver: json["point_driver"],
        istopup: json["istopup"],
        noreff: json["noreff"],
        islogin: json["islogin"],
        group: json["group"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullnama": fullnama,
        "email": email,
        "no_telepon": noTelepon,
        "countrycode": countrycode,
        "phone": phone,
        "created_on": createdOn.toIso8601String(),
        "jenis": jenis,
        "tgl_lahir":
            "${tglLahir.year.toString().padLeft(4, '0')}-${tglLahir.month.toString().padLeft(2, '0')}-${tglLahir.day.toString().padLeft(2, '0')}",
        "rating_pelanggan": ratingPelanggan,
        "status": status,
        "fotopelanggan": fotopelanggan,
        "israte": israte,
        "id_driver": idDriver,
        "id_transaksi": idTransaksi,
        "total_biaya": totalBiaya,
        "pakai_wallet": pakaiWallet,
        "nama_driver": namaDriver,
        "foto_driver": fotoDriver,
        "fitur": fitur,
        "response": response,
        "point_driver": pointDriver,
        "istopup": istopup,
        "noreff": noreff,
        "islogin": islogin,
        "group": group,
        "role": role,
      };
}
