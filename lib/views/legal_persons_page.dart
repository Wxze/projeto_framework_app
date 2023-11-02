import 'package:flutter/material.dart';

class LegalPersonsPage extends StatefulWidget {
  const LegalPersonsPage({super.key});

  @override
  State<LegalPersonsPage> createState() => _LegalPersonsPageState();
}

class _LegalPersonsPageState extends State<LegalPersonsPage> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 24, horizontal: 14),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Pessoas Jurídicas'),
            ],
          ),
        ],
      ),
    );
  }
}
