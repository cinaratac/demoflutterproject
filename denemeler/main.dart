import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:havadurumu/card_lisstle.dart';
import 'package:havadurumu/gridiev.dart';
import 'package:havadurumu/listwievkullanimi.dart';
import 'package:havadurumu/teksatirlikwidget.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [FlutterSmartDialog.observer],
      // here
      builder: FlutterSmartDialog.init(),
      title: "material app",
      home: Scaffold(
        appBar: AppBar(title: const Text("Liste Ve Veri İşlmeleri")),
        body: Gridiev(),
      ),
    );
  }
}
