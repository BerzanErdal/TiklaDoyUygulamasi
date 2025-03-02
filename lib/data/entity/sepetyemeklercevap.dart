import 'package:tikladoy/data/entity/sepetyemekler.dart';
import 'package:tikladoy/data/entity/yemekler.dart';

class Sepetyemeklercevap {
  List<SepetYemekler> sepet_yemekler;
  int success;
  Sepetyemeklercevap({required this.sepet_yemekler, required this.success});

  factory Sepetyemeklercevap.fromJson(Map<String, dynamic> json) {
    var jsonArray = json["sepet_yemekler"] as List;
    int success = json["success"] as int;
    var sepet_yemekler =
        jsonArray
            .map((jsonArrayNesnesi) => SepetYemekler.fromJson(jsonArrayNesnesi))
            .toList();
    return Sepetyemeklercevap(sepet_yemekler: sepet_yemekler, success: success);
  }
}
