import 'package:flutter/material.dart';
import 'package:havadurumu/listwievkullanimi.dart';

double a = 10;

class Gridiev extends StatelessWidget {
  Gridiev({super.key});

  List<Ogrenci> ogrenciler = List.generate(500, (index) {
    return Ogrenci(
      id: (index + 1),
      isim: "ogrenci ${index + 1}",
      erkekmi: index % 2 == 0,
    );
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 2,
        childAspectRatio: MediaQuery.of(context).size.width > 600 ? 1.5 : 1,
      ),
      itemBuilder: (context, index) {
        return Container(
          color: Colors.orange[index % 10 * 100],
          child: Text(ogrenciler[index].toString()),
        );
      },
    );
  }

  GridView gridviewezcent() {
    return GridView.extent(
      maxCrossAxisExtent: 300,
      children: createContainers(20),
      padding: EdgeInsets.all(10),
      mainAxisSpacing: 10,
      reverse: true,
      primary: true,
      crossAxisSpacing: 10,
      scrollDirection: Axis.vertical,
    );
  }
}

List<Widget> createContainers(int length) {
  return List.generate(length, (index) {
    var renkshade = 100 * ((index + 1) % 10);
    var sonshade = renkshade == 0 ? 100 : renkshade;
    return Container(
      alignment: Alignment.center,
      color: Colors.purple[sonshade],
      child: Text(
        "CONTAİNER $sonshade",
        style: TextStyle(fontSize: 20),
        textAlign: TextAlign.center,
      ),
    );
  });
}
