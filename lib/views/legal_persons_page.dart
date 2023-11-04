import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:projeto_framework_app/models/legal_person.dart';
import 'package:projeto_framework_app/repositories/legal_person_repository.dart';
import 'package:projeto_framework_app/views/widgets/default_text_field.dart';
import 'package:projeto_framework_app/views/widgets/legal_person_list_tile.dart';
import 'package:projeto_framework_app/views/widgets/masked_text_field.dart';

import '../utils/regex.dart';
import '../widgets/default_card_message.dart';

class LegalPersonsPage extends StatefulWidget {
  const LegalPersonsPage({super.key});

  @override
  State<LegalPersonsPage> createState() => _LegalPersonsPageState();
}

class _LegalPersonsPageState extends State<LegalPersonsPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late List<LegalPerson> persons;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cnpjController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();

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
                    'Pessoas Jurídicas',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF0f2249)),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        _nameController.text = '';
                        _cnpjController.text = '';
                        _salaryController.text = '';
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                                      child: Form(
                                        key: formKey,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Adicionar pessoa jurídica',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    color: Color(0xFF0f2249),
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            const Row(
                                              children: [
                                                SizedBox(
                                                  width: 12,
                                                ),
                                                Text(
                                                  'Nome',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Color(0xFF0f2249),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            SizedBox(
                                              child: DefaultTextField(
                                                formController: _nameController,
                                                icon: Icons.domain,
                                                validator: (value) {
                                                  if (value == null || value.isEmpty) {
                                                    return 'Preencha este campo';
                                                  }
                                                  return null;
                                                },
                                                hintText: 'Gabriel Jose da Silva dos Santos',
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 16,
                                            ),
                                            const Row(
                                              children: [
                                                SizedBox(
                                                  width: 12,
                                                ),
                                                Text(
                                                  'CNPJ',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Color(0xFF0f2249),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 7,
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            SizedBox(
                                              child: MaskedTextField(
                                                controller: _cnpjController,
                                                text: '998.303.090-02',
                                                icon: Icons.pin,
                                                keyboardType: TextInputType.number,
                                                maskFormatter: MaskTextInputFormatter(
                                                  mask: '##.###.###/####-##',
                                                  filter: {"#": RegExp(r'[0-9]')},
                                                  type: MaskAutoCompletionType.lazy,
                                                ),
                                                validator: (value) {
                                                  if (value == null || value.isEmpty) {
                                                    return 'Preencha este campo';
                                                  }
                                                  if (!RegExp(Regex.cnpj).hasMatch(value)) {
                                                    return 'CNPJ incompleto';
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                            const SizedBox(height: 16),
                                            const Row(
                                              children: [
                                                SizedBox(
                                                  width: 12,
                                                ),
                                                Text(
                                                  'Salário',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Color(0xFF0f2249),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            SizedBox(
                                              child: DefaultTextField(
                                                formController: _salaryController,
                                                icon: Icons.attach_money,
                                                keyboardType: TextInputType.number,
                                                validator: (value) {
                                                  if (value == null || value.isEmpty) {
                                                    return 'Preencha este campo';
                                                  }
                                                  return null;
                                                },
                                                hintText: '3000,00',
                                              ),
                                            ),
                                            const SizedBox(height: 30),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: ElevatedButton(
                                                    style: ButtonStyle(
                                                      side: MaterialStateProperty.all(
                                                        const BorderSide(
                                                          color: Color(0xFF1d4491),
                                                        ),
                                                      ),
                                                      backgroundColor: MaterialStateProperty.all(
                                                        const Color(0xFFFFFFFF),
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                    },
                                                    child: const Text(
                                                      'Cancelar',
                                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF1d4491)),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Expanded(
                                                  child: ElevatedButton(
                                                    onPressed: () async {
                                                      if (formKey.currentState!.validate()) {
                                                        Response resp =
                                                            await LegalPersonRepository().addPerson(_nameController.text, _cnpjController.text, _salaryController.text);

                                                        if (resp.statusCode == 200) {
                                                          showSucessSnackBar('Pessoa cadastrada com sucesso!');
                                                          _pullRefresh();
                                                          redirectUser();
                                                        }
                                                      }
                                                    },
                                                    child: const Text(
                                                      'Adicionar',
                                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: const Icon(
                        Icons.add,
                      )),
                ],
              ),
              const SizedBox(height: 24),
              FutureBuilder<List<LegalPerson>>(
                future: LegalPersonRepository().getAll(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  } else if (!snapshot.hasData) {
                    return const DefaultCardMessage(message: 'Não há pessoas jurídicas cadastradas.');
                  } else {
                    persons = snapshot.data!;
                    if (persons.isNotEmpty) {
                      return ListView.separated(
                        itemCount: persons.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return LegalPersonListTile(
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
                      return const DefaultCardMessage(message: 'Não há pessoas jurídicas cadastradas.');
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

  void redirectUser() {
    Navigator.of(context).pop();
  }

  void showSucessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 3),
      content: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        const Icon(
          Icons.check_circle,
          color: Colors.white,
        ),
        const SizedBox(width: 10),
        Flexible(child: Text(message))
      ]),
      backgroundColor: const Color(0xFF44A33C),
    ));
  }
}
