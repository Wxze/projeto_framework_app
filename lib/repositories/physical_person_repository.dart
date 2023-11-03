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

  Future<Response> addPerson(String name, String cpf, String salary) async {
    salary = salary.replaceAll(".", "");
    salary = salary.replaceAll(",", ".");
    double salaryDouble = double.parse(salary);

    Map body = {"name": name, "cpf": cpf, "salary": salaryDouble};

    var resp = await post(
      Uri.parse(ApiRepository.PHYSICAL_PERSONS),
      headers: <String, String>{'Content-Type': 'application/json;charset=UTF-8'},
      body: json.encode(body),
    );

    return resp;
  }

    Future<Response> updatePerson(int id, String name, String cpf, String salary) async {
    salary = salary.replaceAll(".", "");
    salary = salary.replaceAll(",", ".");
    double salaryDouble = double.parse(salary);

    Map body = {"name": name, "cpf": cpf, "salary": salaryDouble};

    var resp = await put(
      Uri.parse('${ApiRepository.PHYSICAL_PERSONS}/$id'),
      headers: <String, String>{'Content-Type': 'application/json;charset=UTF-8'},
      body: json.encode(body),
    );

    return resp;
  }

  Future<Response> deletePerson(int id) async {
    var resp = await delete(Uri.parse('${ApiRepository.PHYSICAL_PERSONS}/$id'));

    return resp;
  }
}
