import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: TextTheme(
          labelLarge: TextStyle(fontSize: 24, color: Colors.yellow),
        ),
        primarySwatch: Colors.yellow,
        useMaterial3: false,
      ),
      debugShowCheckedModeBanner: false,
      home: homepage(),
    );
  }
}

class homepage extends StatefulWidget {
  homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  var _sayac = 0;

  void _sayaciarttir() {
    setState(() {});
    _sayac++;
  }

  void _sayaciazalt() {
    setState(() {});
    _sayac--;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Renk uygulaması")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "Basılma Sayısı",
              style: TextStyle(
                color: Theme.of(context).textTheme.labelLarge?.color,
                fontSize: Theme.of(context).textTheme.displaySmall?.fontSize,
              ),
            ),
          ),
          SizedBox(height: 4),
          Text(
            _sayac.toString(),
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
              color: _sayac < 0 ? Colors.red : Colors.green,
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              _sayaciarttir();
            },
            child: Icon(Icons.add),
          ),

          SizedBox(height: 4),

          FloatingActionButton(
            onPressed: () {
              _sayaciazalt();
            },
            child: Icon(Icons.remove),
          ),

          SizedBox(height: 4),

          FloatingActionButton(
            onPressed: () {
              setState(() {});
              _sayac = 0;
            },
            child: Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }
}
