import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:havadurumu/teksatirlikwidget.dart';

class Listwievkullanimi extends StatelessWidget {
  Listwievkullanimi({super.key});

  List<Ogrenci> tumogrenciler = List.generate(
    100,
    (index) => Ogrenci(
      id: index + 1,
      isim: "Ogrenci adı ${index + 1}",
      erkekmi: index % 2 == 0,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => GestureDetector(
        onLongPress: () {
          debugPrint("Card widget tıklanıldı ${tumogrenciler[index].isim}");
        },
        child: Card(
          color: tumogrenciler[index].erkekmi ? Colors.blue : Colors.pink,
          child: ListTile(
            onTap: () {
              SmartDialog.show(
                builder: (context) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width * 0.5,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Listtile widget tıklanıldı ${tumogrenciler[index].isim}",
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                },
              );
              debugPrint(
                "Listtile widget tıklanıldı ${tumogrenciler[index].isim}",
              );
            },
            title: Text(tumogrenciler[index].isim),
            leading: CircleAvatar(child: Text((index + 1).toString())),
          ),
        ),
      ),
    );
  }

  ListView listview() =>
      ListView(children: [teksatatirliklistlie(), teksatatirliklistlie()]);

  SingleChildScrollView singlechild() =>
      SingleChildScrollView(child: teksatatirliklistlie());
}

class Ogrenci {
  final int id;
  final String isim;
  final bool erkekmi;

  Ogrenci({required this.id, required this.isim, required this.erkekmi});

  @override
  String toString() {
    return "$isim ";
  }
}
