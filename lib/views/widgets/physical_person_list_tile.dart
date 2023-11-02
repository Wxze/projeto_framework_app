import 'package:flutter/material.dart';

import '../../models/physical_person.dart';

class PhysicalPersonListTile extends StatefulWidget {
  const PhysicalPersonListTile({super.key, required this.person});
  final PhysicalPerson person;

  @override
  State<PhysicalPersonListTile> createState() => _PhysicalPersonListTileState();
}

class _PhysicalPersonListTileState extends State<PhysicalPersonListTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        tileColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: const Column(
          children: [
            Expanded(
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Color(0xFFd2dae9),
                child: Icon(
                  Icons.person,
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
                        'CPF: ${widget.person.cpf}',
                        style: const TextStyle(
                            fontSize: 14, color: Color(0xFF1a3d83)),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        'Salário: R\$ ${widget.person.salary}',
                        style: const TextStyle(
                            fontSize: 14, color: Color(0xFF1a3d83)),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        'Gastos totais: R\$ ${widget.person.expense}',
                        style: const TextStyle(
                            fontSize: 14, color: Color(0xFF1a3d83)),
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
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 30),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                              height: 50,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      'Deseja excluir a pessoa selecionada?',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xFF0f2249),
                                                          fontSize: 19,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                          const SizedBox(height: 24),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: ElevatedButton(
                                                  style: ButtonStyle(
                                                    side: MaterialStateProperty
                                                        .all(
                                                      const BorderSide(
                                                        color:
                                                            Color(0xFF1d4491),
                                                      ),
                                                    ),
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(
                                                      const Color(0xFFFFFFFF),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text(
                                                    'Cancelar',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16,
                                                        color:
                                                            Color(0xFF1d4491)),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Expanded(
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    print(
                                                        'Excluir cadastro da pessoa');
                                                  },
                                                  child: const Text(
                                                    'Excluir',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16),
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
    );
  }
}
