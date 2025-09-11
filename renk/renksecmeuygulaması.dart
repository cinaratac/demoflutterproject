import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: ThemeData(), home: Colorpickerpage());
  }
}

class Colorpickerpage extends StatefulWidget {
  const Colorpickerpage({super.key});

  @override
  State<Colorpickerpage> createState() => _ColorpickerpageState();
}

class _ColorpickerpageState extends State<Colorpickerpage> {
  Color secilenrenk = Colors.red;
  bool iscircle = false;
  bool isshowcolorname = true;

  void _rastgelerenksec() {
    final colors = renkler.keys.toList();
    final randomcolor = colors[Random().nextInt(colors.length)];
    setState(() {
      secilenrenk = randomcolor;
      debugPrint(randomcolor.toString());
    });
  }

  void _yuvarlakyap() {
    setState(() {
      iscircle = !iscircle;
    });
  }

  void _renginkodunugoster() {
    Fluttertoast.showToast(
      msg:
          "RGB : (${secilenrenk.red},${secilenrenk.green},${secilenrenk.blue})",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: secilenrenk,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  final Map<Color, String> renkler = {
    Colors.red: "Kırmızı",
    Colors.blue: "Mavi",
    Colors.green: "Yeşil",
    Colors.yellow: "Sarı",
    Colors.purple: "Mor",
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                isshowcolorname = !isshowcolorname;
              });
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: 'a',
                  child: Row(children: [Text("Renk adını göster / gizle")]),
                ),
              ];
            },
            icon: Icon(Icons.more_vert),
          ),
        ],
        title: Text("Renk seçici"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 50),
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: secilenrenk,
                borderRadius: BorderRadius.circular(iscircle ? 100 : 20),
                boxShadow: [
                  BoxShadow(
                    color: secilenrenk.withOpacity(0.5),
                    blurRadius: 20,
                    spreadRadius: 10,
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            isshowcolorname
                ? Text(renkler[secilenrenk] ?? "Seçilen renk")
                : SizedBox(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  DropdownButton<Color>(
                    value: secilenrenk,
                    items: renkler.entries.map((entry) {
                      return DropdownMenuItem(
                        value: entry.key,
                        child: Row(
                          children: [
                            Container(width: 20, height: 20, color: entry.key),
                            SizedBox(width: 5),
                            Text(entry.value),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        secilenrenk = value!;
                      });
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _rastgelerenksec();
                    },
                    child: Text(
                      "Rastgele",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  IconButton(
                    onPressed: _renginkodunugoster,
                    icon: Icon(Icons.info),
                  ),
                  IconButton(
                    onPressed: () {
                      _yuvarlakyap();
                    },
                    icon: Icon(
                      iscircle
                          ? Icons.circle_outlined
                          : Icons.crop_square_outlined,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
