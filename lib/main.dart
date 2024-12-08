import 'package:flutter/material.dart';

import 'calcurator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calcurator App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CalcuratorHomePage(), //수정할 부분
    );
  }
}
