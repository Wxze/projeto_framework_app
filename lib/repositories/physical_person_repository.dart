import 'dart:convert';

import 'package:http/http.dart';
import 'package:projeto_framework_app/repositories/api_repository.dart';

import '../models/physical_person.dart';

class PhysicalPersonRepository {
  Future<List<PhysicalPerson>> getAll() async {
    var resp = await get(Uri.parse(ApiRepository.PHYSICAL_PERSONS));

    List<PhysicalPerson> persons = [];
    if (resp.statusCode == 200) {
      final data = await json.decode(utf8.decode(resp.bodyBytes));

      if (data == null) {
        return persons;
      }

      for (var item in data) {
        persons.add(PhysicalPerson.fromJson(item));
      }
    } else {
      throw Exception("Não foi possivel se conectar com o servidor");
    }

    return persons;
  }

  Future<Response> deletePerson(int id) async {
    var resp = await delete(Uri.parse('${ApiRepository.PHYSICAL_PERSONS}/$id'));

    return resp;
  }
}
