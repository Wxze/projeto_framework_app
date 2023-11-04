import 'dart:convert';

import 'package:http/http.dart';
import 'package:projeto_framework_app/repositories/api_repository.dart';

import '../models/legal_person.dart';

class LegalPersonRepository {
  Future<List<LegalPerson>> getAll() async {
    var resp = await get(Uri.parse(ApiRepository.LEGAL_PERSONS));

    List<LegalPerson> persons = [];
    if (resp.statusCode == 200) {
      final data = await json.decode(utf8.decode(resp.bodyBytes));

      if (data == null) {
        return persons;
      }

      for (var item in data) {
        persons.add(LegalPerson.fromJson(item));
      }
    } else {
      throw Exception("Não foi possivel se conectar com o servidor");
    }

    return persons;
  }

  Future<Response> addPerson(String name, String cnpj, String salary) async {
    salary = salary.replaceAll(".", "");
    salary = salary.replaceAll(",", ".");
    double salaryDouble = double.parse(salary);

    Map body = {"name": name, "cnpj": cnpj, "salary": salaryDouble};

    var resp = await post(
      Uri.parse(ApiRepository.LEGAL_PERSONS),
      headers: <String, String>{'Content-Type': 'application/json;charset=UTF-8'},
      body: json.encode(body),
    );

    return resp;
  }

    Future<Response> updatePerson(int id, String name, String cnpj, String salary) async {
    salary = salary.replaceAll(".", "");
    salary = salary.replaceAll(",", ".");
    double salaryDouble = double.parse(salary);

    Map body = {"name": name, "cnpj": cnpj, "salary": salaryDouble};

    var resp = await put(
      Uri.parse('${ApiRepository.LEGAL_PERSONS}/$id'),
      headers: <String, String>{'Content-Type': 'application/json;charset=UTF-8'},
      body: json.encode(body),
    );

    return resp;
  }

  Future<Response> deletePerson(int id) async {
    var resp = await delete(Uri.parse('${ApiRepository.LEGAL_PERSONS}/$id'));

    return resp;
  }
}
