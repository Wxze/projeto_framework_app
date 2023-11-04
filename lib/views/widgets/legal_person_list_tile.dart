import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../models/legal_person.dart';
import '../../repositories/legal_person_repository.dart';
import '../../utils/regex.dart';
import 'default_text_field.dart';
import 'masked_text_field.dart';

class LegalPersonListTile extends StatefulWidget {
  const LegalPersonListTile({super.key, required this.person, required this.resetPersonsListState});
  final LegalPerson person;
  final Function resetPersonsListState;

  @override
  State<LegalPersonListTile> createState() => _LegalPersonListTileState();
}

class _LegalPersonListTileState extends State<LegalPersonListTile> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cnpjController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _nameController.text = widget.person.name;
    _cnpjController.text = widget.person.cnpj;
    _salaryController.text = widget.person.salary;

    return GestureDetector(
      onTap: () {
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
                                  'Atualizar pessoa jurídica',
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
                                text: '36.230.387/0001-10',
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
                                        Response resp = await LegalPersonRepository()
                                            .updatePerson(widget.person.id, _nameController.text, _cnpjController.text, _salaryController.text);

                                        if (resp.statusCode == 200) {
                                          _redirectUser();
                                          showSnackBar('Pessoa atualizada com sucesso!');
                                          widget.resetPersonsListState();
                                        }
                                      }
                                    },
                                    child: const Text(
                                      'Atualizar',
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Card(
          elevation: 2,
          child: Container(
            decoration: const BoxDecoration(
              border: Border(
                left: BorderSide(color: Color(0xFF1d4491), width: 6),
              ),
            ),
            child: ListTile(
              tileColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              leading: const Column(
                children: [
                  Expanded(
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: Color(0xFFd2dae9),
                      child: Icon(
                        Icons.domain,
                        color: Color(0xFF0f2249),
                      ),
                    ),
                  ),
                ],
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.person.name,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color(0xFF0f2249),
                                fontWeight: FontWeight.w600,
                              ),
                              // overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'CNPJ: ${widget.person.cnpj}',
                              style: const TextStyle(fontSize: 14, color: Color(0xFF1a3d83)),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              'Salário: R\$ ${widget.person.salary}',
                              style: const TextStyle(fontSize: 14, color: Color(0xFF1a3d83)),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              'Gastos totais: R\$ ${widget.person.expense}',
                              style: const TextStyle(fontSize: 14, color: Color(0xFF1a3d83)),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: IconButton(
                            onPressed: () async {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(
                                                    height: 50,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Flexible(
                                                          child: Text(
                                                            'Deseja excluir a pessoa selecionada?',
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(color: Color(0xFF0f2249), fontSize: 19, fontWeight: FontWeight.bold),
                                                          ),
                                                        ),
                                                      ],
                                                    )),
                                                const SizedBox(height: 24),
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
                                                          Response resp = await LegalPersonRepository().deletePerson(widget.person.id);

                                                          if (resp.statusCode == 200) {
                                                            _redirectUser();
                                                            showSnackBar('Pessoa excluída com sucesso!');
                                                            widget.resetPersonsListState();
                                                          }
                                                        },
                                                        child: const Text(
                                                          'Excluir',
                                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Color(0xFFC45454),
                            )),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void redirectUser() {
    Navigator.of(context).pop();
  }

  void showSnackBar(String message) {
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

  void _redirectUser() {
    Navigator.of(context).pop();
  }
}
