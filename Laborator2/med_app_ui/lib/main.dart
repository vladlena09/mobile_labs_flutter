import 'package:flutter/material.dart';
import 'package:med_app_ui/theme.dart';
import 'package:med_app_ui/screens/home_screen.dart';

void main() {
  runApp(const MedAppUI());
}

class MedAppUI extends StatelessWidget {
  const MedAppUI({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medical App UI',
      debugShowCheckedModeBanner: false,
      theme: buildTheme(),
      home: const HomeScreen(),
    );
  }
}
