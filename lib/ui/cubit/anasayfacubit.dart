import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tikladoy/data/entity/yemekler.dart';
import 'package:tikladoy/data/repo/tikladoydaorepository.dart';

class Anasayfacubit extends Cubit<List<Yemekler>> {
  Anasayfacubit() : super(<Yemekler>[]);

  var yRepo = Tikladoydaorepository();

  Future<void> yemekListele() async {
    var liste =await yRepo.yemekListele();
    emit(liste);
  }

  Future<void> arama(aramakelimesi) async {
    var aramaSonucu = await yRepo.arama(aramakelimesi);
    emit(aramaSonucu);
  }
}
