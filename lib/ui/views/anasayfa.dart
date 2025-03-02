import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tikladoy/data/entity/yemekler.dart';
import 'package:tikladoy/ui/cubit/anasayfacubit.dart';
import 'package:tikladoy/ui/views/detaysayfa.dart';
import 'package:tikladoy/ui/views/sepetsayfa.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<Anasayfacubit>().yemekListele();
  }

  @override
  Widget build(BuildContext context) {
    var ekranBilgisi = MediaQuery.of(context).size;
    var ekranGenislik = ekranBilgisi.width;
    var ekranYukseklik = ekranBilgisi.height;
    print("ekran genişlik:$ekranGenislik");
    print("ekran yukseklik:$ekranYukseklik");
    var tfKontrol = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: ekranYukseklik / 12,
        leading: Padding(
          padding: const EdgeInsets.only(left: 4, top: 3),
          child: Transform.scale(
            scale: 1.8,
            child: ClipOval(
              child: SizedBox(
                height: ekranYukseklik / 30,
                width: ekranGenislik / 15,
                child: Image.asset(
                  "lib/data/resimler/tikladoyresim.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hoşgeldin",
              style: TextStyle(
                color: const Color.fromARGB(255, 2, 61, 109),
                fontSize: 20,
              ),
            ),
            Text(
              "TıklaDoy İle Doyma Zamanı",
              style: TextStyle(
                color: const Color.fromARGB(255, 2, 61, 109),
                fontSize: 13,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 6.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white12,
                    iconSize: 35,
                  ),
                  icon: Icon(
                    Icons.home,
                    color: const Color.fromARGB(255, 2, 59, 86),
                  ),
                  onPressed: () {},
                ),
                Text(
                  "Evim",
                  style: TextStyle(
                    fontSize: 20,
                    color: const Color.fromARGB(255, 2, 61, 109),
                  ),
                ),
              ],
            ),
          ),
        ],
        backgroundColor: Colors.yellow,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 13,
              left: 12,
              right: 13,
              bottom: 12,
            ),
            child: TextField(
              controller: tfKontrol,
              onChanged: (value) {
                context.read<Anasayfacubit>().arama(value);
              },
              decoration: InputDecoration(
                fillColor: Colors.white, // Arka plan rengi
                filled: true, // Arka plan rengi aktif olsun
                hintText: "Ne yemek istersin?",
                prefixIcon: Icon(
                  size: 30,
                  Icons.search,
                ), // prefix yerine prefixIcon kullanmak daha yaygın
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<Anasayfacubit, List<Yemekler>>(
              builder: (context, yemekListe) {
                if (yemekListe.isNotEmpty) {
                  return GridView.builder(
                    itemCount: yemekListe.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.9,
                    ),
                    itemBuilder: (context, index) {
                      var yemek = yemekListe[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return DetaySayfa(yemek: yemek);
                              },
                            ),
                          ).then((value) {
                            context.read<Anasayfacubit>().yemekListele();
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Card(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: ekranYukseklik / 7,
                                  width: ekranGenislik / 3,
                                  child: Image.network(
                                    "http://kasimadalan.pe.hu/yemekler/resimler/${yemek.yemek_resim_adi}",
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 2),
                                  child: Text(
                                    yemek.yemek_adi,
                                    style: TextStyle(
                                      color: Colors.deepOrangeAccent,
                                      fontSize: ekranYukseklik / 38,
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        "${yemek.yemek_fiyat}₺",
                                        style: TextStyle(
                                          color: Colors.deepOrangeAccent,
                                          fontSize: ekranGenislik / 28,
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 2),
                                      child: IconButton(
                                        color: Colors.deepOrange,
                                        iconSize: ekranGenislik / 16,
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return DetaySayfa(yemek: yemek);
                                              },
                                            ),
                                          ).then((value) {
                                            context
                                                .read<Anasayfacubit>()
                                                .yemekListele();
                                          });
                                        },
                                        icon: Icon(Icons.add),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(child: Text("Yemekler yükleniyor..."));
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Sepetsayfa()),
          );
        },
        backgroundColor: Colors.white,
        child: Icon(Icons.shopping_basket, size: 30, color: Colors.deepOrange),
      ),
    );
  }
}
