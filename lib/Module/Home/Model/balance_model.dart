import 'dart:convert';

BalanceModel userModelFromJson(String str) =>
    BalanceModel.fromJson(json.decode(str));

String userModelToJson(BalanceModel data) => json.encode(data.toJson());

class BalanceModel {
  int saldo;

  BalanceModel({
    required this.saldo,
  });

  factory BalanceModel.fromJson(Map<String, dynamic> json) => BalanceModel(
        saldo: json["saldo"],
      );

  Map<String, dynamic> toJson() => {
        "saldo": saldo,
      };
}
