import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tikladoy/data/entity/sepetyemekler.dart';
import 'package:tikladoy/data/repo/tikladoydaorepository.dart';

class Sepetsayfacubit extends Cubit<List<SepetYemekler>> {
  Sepetsayfacubit() : super(<SepetYemekler>[]);

  var sRepo = Tikladoydaorepository();

  Future<void> sepetim(String kullanici_adi) async {
    var liste = await sRepo.sepetim(kullanici_adi);
    emit(liste);
  }

  Future<void> kaydet(
    String adi,
    String resim,
    int fiyat,
    int adet,
    String kullanici,
  ) async {
    await sRepo.kaydet(adi, resim, fiyat, adet, kullanici);
    await sepetim(kullanici);
  }

  Future<void> sil(int id, String kulanici) async {
    await sRepo.sil(id, kulanici);
    await sepetim(kulanici);
  }
}
