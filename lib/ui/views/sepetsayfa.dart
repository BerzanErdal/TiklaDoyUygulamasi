import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tikladoy/data/entity/sepetyemekler.dart';
import 'package:tikladoy/ui/cubit/sepetsayfacubit.dart';

class Sepetsayfa extends StatefulWidget {
  @override
  State<Sepetsayfa> createState() => _SepetsayfaState();
}

class _SepetsayfaState extends State<Sepetsayfa> {
  @override
  void initState() {
    super.initState();
    context.read<Sepetsayfacubit>().sepetim("Berzan");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.clear, color: Colors.deepOrange, size: 32),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Sepetim",
          style: TextStyle(
            color: Colors.deepOrangeAccent,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<Sepetsayfacubit, List<SepetYemekler>>(
        builder: (context, sepetim) {
          if (sepetim.isEmpty) {
            return Center(child: Text("Sepetinizde ürün bulunmamaktadır."));
          }

          // **Toplam hesap hesaplanıyor**
          int toplamHesap = sepetim.fold(0, (toplam, yemek) {
            return toplam +
                (int.parse(yemek.yemek_fiyat) *
                    int.parse(yemek.yemek_siparis_adet));
          });

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: sepetim.length,
                  itemBuilder: (context, index) {
                    var yemek = sepetim[index];
                    int yemekToplam =
                        int.parse(yemek.yemek_fiyat) *
                        int.parse(yemek.yemek_siparis_adet);

                    return Card(
                      color: Colors.deepOrange,
                      margin: EdgeInsets.all(8),
                      child: ListTile(
                        leading: Image.network(
                          "http://kasimadalan.pe.hu/yemekler/resimler/${yemek.yemek_resim_adi}",
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                        title: Text(
                          yemek.yemek_adi,
                          style: TextStyle(color: Colors.black),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Adet: ${yemek.yemek_siparis_adet}",
                              style: TextStyle(color: Colors.black),
                            ),
                            Text(
                              "$yemekToplam₺",
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.clear, color: Colors.white),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  backgroundColor: Colors.yellow,
                                  title: Text(
                                    "${yemek.yemek_adi} sepetten silinsin mi?",
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text("İptal"),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        context.read<Sepetsayfacubit>().sil(
                                          int.parse(yemek.sepet_yemek_id),
                                          yemek.kulanici_adi,
                                        );
                                        Navigator.pop(context);
                                      },
                                      child: Text("Evet"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 180,
                width: MediaQuery.of(context).size.width,
                child: BottomAppBar(
                  color: Colors.yellowAccent,
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Toplam Hesap: ${toplamHesap}₺",
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepOrange,
                            side: BorderSide(width: 2),
                            fixedSize: Size(320, 70),
                          ),
                          onPressed: () {},
                          child: Text(
                            "Sepeti Onayla",
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
