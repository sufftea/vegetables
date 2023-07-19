import 'package:flutter/material.dart';
import 'package:vegitables/screens/vegi_list_screen/vegi_list_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: const VegiListScreen(),
    );
  }
}
