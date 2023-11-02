import 'package:flutter/material.dart';
import 'package:projeto_framework_app/views/main_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SymPay',
      theme: ThemeData(
        colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: const Color(0xFF1d4491),
            ),
      ),
      debugShowCheckedModeBanner: false,
      home: const MainView(),
    );
  }
}
