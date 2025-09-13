import 'package:flutter/material.dart';

class cardlisttilekullanimi extends StatelessWidget {
  const cardlisttilekullanimi({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: Colors.green,
        shadowColor: Colors.greenAccent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 12,
        child: Column(children: [Expanded(child: teksatir())]),
      ),
    );
  }

  Column teksatir() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ListTile(
          trailing: CircleAvatar(child: Icon(Icons.av_timer)),
          leading: CircleAvatar(child: Icon(Icons.add)),
          title: Text("cnar atakul"),
          subtitle: Text("gELİŞTİRİCİ"),
        ),
        Divider(thickness: 2, indent: 10, color: Colors.pink),
      ],
    );
  }
}
