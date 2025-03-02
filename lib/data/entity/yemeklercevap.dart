import 'package:tikladoy/data/entity/yemekler.dart';

class Yemeklercevap {
  List<Yemekler> yemekler;
  int success;

  Yemeklercevap({required this.yemekler, required this.success});

  factory Yemeklercevap.fromJson(Map<String, dynamic> json) {
    var jsonArray = json["yemekler"] as List;
    var success= json["success"] as int;
    
    var kisiler=jsonArray.map((jsonArrayNesnesi)=> Yemekler.fromJson(jsonArrayNesnesi)).toList();
    
    return Yemeklercevap(yemekler: kisiler, success: success);
  }
}
