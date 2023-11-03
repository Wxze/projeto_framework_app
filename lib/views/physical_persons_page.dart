import 'package:flutter/material.dart';
import 'package:projeto_framework_app/models/physical_person.dart';
import 'package:projeto_framework_app/repositories/physical_person_repository.dart';
import 'package:projeto_framework_app/views/widgets/physical_person_list_tile.dart';

import '../widgets/default_card_message.dart';

class PhysicalPersonsPage extends StatefulWidget {
  const PhysicalPersonsPage({super.key});

  @override
  State<PhysicalPersonsPage> createState() => _PhysicalPersonsPageState();
}

class _PhysicalPersonsPageState extends State<PhysicalPersonsPage> {
  late List<PhysicalPerson> persons;

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
                      onPressed: () async {
                        List<PhysicalPerson> persons =
                            await PhysicalPersonRepository().getAll();
                        print(persons);
                      },
                      child: const Icon(
                        Icons.add,
                      )),
                ],
              ),
              const SizedBox(height: 24),
              FutureBuilder<List<PhysicalPerson>>(
                future: PhysicalPersonRepository().getAll(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  } else if (!snapshot.hasData) {
                    return const DefaultCardMessage(
                        message: 'Não há pessoas físicas cadastradas.');
                  } else {
                    persons = snapshot.data!;
                    if (persons.isNotEmpty) {
                      return ListView.separated(
                        itemCount: persons.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return PhysicalPersonListTile(
                            person: persons[index],
                            resetPersonsListState: () {
                              setState(() {
                                persons = persons;
                              });
                            },
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(
                            height: 16,
                          );
                        },
                      );
                    } else {
                      return const DefaultCardMessage(
                          message: 'Não há pessoas físicas cadastradas.');
                    }
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pullRefresh() async {
    setState(() {
      persons = persons;
    });
  }
}
