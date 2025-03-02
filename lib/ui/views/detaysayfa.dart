import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tikladoy/data/entity/yemekler.dart';
import 'package:tikladoy/ui/cubit/sepetsayfacubit.dart';
import 'package:tikladoy/ui/views/sepetsayfa.dart';

class DetaySayfa extends StatefulWidget {
  Yemekler yemek;
  DetaySayfa({required this.yemek});

  @override
  State<DetaySayfa> createState() => _DetaySayfaState();
}

class _DetaySayfaState extends State<DetaySayfa> {
  @override
  var toplam = 1;
  int toplamfiyat = 0;
  int toplamHesap = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    toplamfiyat += int.parse(widget.yemek.yemek_fiyat);
    toplamHesap = int.parse(widget.yemek.yemek_fiyat);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.clear, size: 35, color: Colors.deepOrange),
        ),
        title: Text(
          "Ürün Detayı",
          style: TextStyle(
            color: Colors.deepOrangeAccent,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Sepetsayfa()),
              );
            },
            icon: Icon(
              Icons.shopping_basket,
              size: 33,
              color: Colors.deepOrange,
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 220,
                      child: Image.network(
                        "http://kasimadalan.pe.hu/yemekler/resimler/${widget.yemek.yemek_resim_adi}",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.yemek.yemek_adi,
                      style: TextStyle(
                        color: Colors.deepOrangeAccent,
                        fontSize: 45,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${widget.yemek.yemek_fiyat}₺",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.deepOrangeAccent,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          iconSize: 50,
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.deepOrange,
                            shape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                          onPressed: () {
                            if (toplam > 1) {
                              setState(() {
                                toplam--;
                                toplamHesap = toplam * toplamfiyat;
                              });
                            }
                          },
                          icon: Icon(Icons.remove, color: Colors.black),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 12,
                            right: 20,
                            left: 20,
                          ),
                          child: Text(
                            "$toplam",
                            style: TextStyle(fontSize: 40),
                          ),
                        ),
                        IconButton(
                          iconSize: 45,
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.deepOrange,
                            shape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              toplam += 1;
                              toplamHesap = toplam * toplamfiyat;
                            });
                          },
                          icon: Icon(Icons.add, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 85,
        child: BottomAppBar(
          color: Colors.yellow,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 11),
                child: Text("$toplamHesap₺", style: TextStyle(fontSize: 30)),
              ),
              Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  fixedSize: Size(235, 75),
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    side: BorderSide(width: 1),
                  ),
                ),
                onPressed: () {
                  context
                      .read<Sepetsayfacubit>()
                      .kaydet(
                        widget.yemek.yemek_adi,
                        widget.yemek.yemek_resim_adi,
                        int.parse(widget.yemek.yemek_fiyat),
                        toplam,
                        "Berzan",
                      )
                      .then((_) {
                        print("Sepete ekleme işlemi tamamlandı!");
                        context.read<Sepetsayfacubit>().sepetim("Berzan");
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "${widget.yemek.yemek_adi} sepete eklendi!",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                              ),
                            ),
                            duration: Duration(seconds: 1),
                            backgroundColor: Colors.deepOrange,
                          ),
                        );
                      });
                },
                child: Text(
                  "Sepete Ekle",
                  style: TextStyle(color: Colors.black, fontSize: 21),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
