import 'dart:convert' show json;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jsonvericekme/personmodels.dart';

void main(List<String> args) {
  runApp(MaterialApp(home: jsonimport()));
}

Future<List<Person>> _loadjson() async {
  try {
    var jsonstring = await rootBundle.loadString("assets/person.json");

    Map<String, dynamic> jsonmap = json.decode(jsonstring);
    debugPrint(jsonmap["persons"][0]["sevdigirenkler"].toString());

    List<dynamic> jsonlist = jsonmap["persons"];
    List<Person> kisiler = jsonlist
        .map((eleman) => Person.fromJson(eleman))
        .toList();

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
    return Scaffold(
      body: FutureBuilder<List<Person>>(
        future: _loadjson(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var mypersonlist = snapshot.data!;
            return ListView.builder(
              itemCount: mypersonlist.length,
              itemBuilder: (context, index) {
                var tekperson = mypersonlist[index];
                return ListTile(title: Text(tekperson.isim));
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("HATA"));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
