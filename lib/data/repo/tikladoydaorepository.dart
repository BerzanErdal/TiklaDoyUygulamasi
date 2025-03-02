import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:tikladoy/data/entity/sepetyemekler.dart';
import 'package:tikladoy/data/entity/sepetyemeklercevap.dart';
import 'package:tikladoy/data/entity/yemekler.dart';
import 'package:tikladoy/data/entity/yemeklercevap.dart';

class Tikladoydaorepository {
  List<Yemekler> parseYemekler(String cevap) {
    return Yemeklercevap.fromJson(json.decode(cevap)).yemekler;
  }

  Future<List<Yemekler>> yemekListele() async {
    var url = "http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php";
    var response = await Dio().get(url);
    return parseYemekler(response.data.toString());
  }

  Future<List<Yemekler>> arama(aramaKelimesi) async {
    var aranacakKelime = aramaKelimesi.toLowerCase();
    var arananYemekler = <Yemekler>[];
    var yemekler = await yemekListele();
    yemekler.forEach((yemek) {
      var yemekAdi = yemek.yemek_adi.toLowerCase();
      if (yemekAdi.contains(aranacakKelime)) {
        arananYemekler.add(yemek);
      }
    });
    return await Future.value(arananYemekler);
  }

  List<SepetYemekler> Parsesepetliste(String cevap) {
    if (cevap.isEmpty) {
      return []; // Eğer cevap boşsa, boş bir liste döndür.
    }

    try {
      return Sepetyemeklercevap.fromJson(json.decode(cevap)).sepet_yemekler;
    } catch (e) {
      print("JSON parse hatası: $e");
      return []; // Hata durumunda da boş liste döndür.
    }
  }

  Future<List<SepetYemekler>> sepetim(String kullanici_adi) async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php";
    var veri = {"kullanici_adi": kullanici_adi};
    var response = await Dio().post(url, data: FormData.fromMap(veri));
    return Parsesepetliste(response.data.toString());
  }

  Future<void> kaydet(
    String adi,
    String resim,
    int fiyat,
    int adet,
    String kullanici,
  ) async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php";
    var veri = {
      "yemek_adi": adi,
      "yemek_resim_adi": resim,
      "yemek_fiyat": fiyat,
      "yemek_siparis_adet": adet,
      "kullanici_adi": kullanici,
    };
    var response = await Dio().post(url, data: FormData.fromMap(veri));
    print("yemek_ekleme_basarili:${response.data.toString()}");
  }

  Future<void> sil(int id, String kullanici) async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php";
    var veri = {"sepet_yemek_id": id, "kullanici_adi": kullanici};
    var response = await Dio().post(url, data: FormData.fromMap(veri));
    print("yemek_silme_basarili:${response.data.toString()}");
  }
}
