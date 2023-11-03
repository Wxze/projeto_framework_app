class PhysicalPerson {
  final int id;
  final String name;
  final String cpf;
  final String salary;
  final String expense;

  PhysicalPerson({required this.id, required this.name, required this.cpf, required this.salary, required this.expense});

  factory PhysicalPerson.fromJson(Map<String, dynamic> json) {
    double salaryToDouble = json['salary'];
    double expenseToDouble = json['expense'];

    String salaryString = salaryToDouble.toStringAsFixed(2);
    salaryString = salaryString.replaceAll(".", ",");
    String expenseString = expenseToDouble.toStringAsFixed(2);
    expenseString = expenseString.replaceAll(".", ",");

    return PhysicalPerson(
      id: json['id'],
      name: json['name'],
      cpf: json['cpf'],
      salary: salaryString,
      expense: expenseString,
    );
  }
}
