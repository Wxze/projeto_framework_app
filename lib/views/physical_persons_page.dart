import 'package:flutter/material.dart';
import 'package:projeto_framework_app/models/physical_person.dart';
import 'package:projeto_framework_app/views/widgets/physical_person_list_tile.dart';

class PhysicalPersonsPage extends StatefulWidget {
  const PhysicalPersonsPage({super.key});

  @override
  State<PhysicalPersonsPage> createState() => _PhysicalPersonsPageState();
}

class _PhysicalPersonsPageState extends State<PhysicalPersonsPage> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _pullRefresh,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Pessoas Físicas',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0f2249)),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        print('pressionado');
                      },
                      child: const Icon(
                        Icons.add,
                      )),
                ],
              ),
              const SizedBox(height: 24),
              ListView.separated(
                itemCount: 10,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return PhysicalPersonListTile(
                      person: PhysicalPerson(
                    id: 1,
                    name: 'Ranniery Lucas',
                    cpf: '12315647876',
                    salary: '1230,78',
                    expense: '2650,87',
                  ));
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    height: 10,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> _pullRefresh() async {
  print('Refreshed');
}
