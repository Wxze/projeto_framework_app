import 'package:intl/intl.dart';

class PhysicalPerson {
  final int id;
  final String name;
  final String cpf;
  final String salary;
  final String expense;

  PhysicalPerson(
      {required this.id,
      required this.name,
      required this.cpf,
      required this.salary,
      required this.expense});

  factory PhysicalPerson.fromJson(Map<String, dynamic> json) {
    double salaryToDouble = json['salary'];
    double expenseToDouble = json['expense'];
    NumberFormat formatoComVirgula = NumberFormat.decimalPattern('pt_BR');

    String salaryDouble = formatoComVirgula.format(salaryToDouble);
    String expenseDouble = formatoComVirgula.format(expenseToDouble);

    return PhysicalPerson(
      id: json['id'],
      name: json['name'],
      cpf: json['cpf'],
      salary: salaryDouble,
      expense: expenseDouble,
    );
  }
}
