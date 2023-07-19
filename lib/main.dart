import 'package:flutter/material.dart';
import 'package:vegetables/screens/vegi_list_screen/vege_list_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: const VegeListScreen(),
    );
  }
}
