import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jsonvericekme/personmodels.dart';

void main(List<String> args) {
  runApp(MaterialApp(home: jsonimport()));
}

Future<List<Person>> _loadjson() async {
  try {
    var jsonstring = await rootBundle.loadString("assets/person.json");
    // debugPrint(jsonstring);

    Map<String, dynamic> jsonmap = json.decode(jsonstring);
    debugPrint(jsonmap["persons"][0]["sevdigirenkler"].toString());

    List<dynamic> jsonList = jsonmap["persons"];
    List<Person> kisiler = jsonList
        .map((eleman) => Person.fromJson(eleman))
        .toList();

    for (var kisi in kisiler) {
      debugPrint(kisi.isim);
    }
    return kisiler;
  } catch (e) {
    debugPrint(e.toString());
    return Future.error(e);
  }
}

class jsonimport extends StatelessWidget {
  const jsonimport({super.key});

  @override
  Widget build(BuildContext context) {
    //_loadjson();
    return Scaffold(
      body: FutureBuilder<List<Person>>(
        future: _loadjson(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var mypersonlist = snapshot.data!;
            return ListView.builder(
              itemCount: mypersonlist.length,
              itemBuilder: (context, index) {
                var Tekperson = mypersonlist[index];
                return ListTile(title: Text(Tekperson.isim));
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("Hata"));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
