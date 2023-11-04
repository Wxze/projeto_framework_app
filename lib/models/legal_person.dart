class LegalPerson {
  final int id;
  final String name;
  final String cnpj;
  final String salary;
  final String expense;

  LegalPerson({required this.id, required this.name, required this.cnpj, required this.salary, required this.expense});

  factory LegalPerson.fromJson(Map<String, dynamic> json) {
    double salaryToDouble = json['salary'];
    double expenseToDouble = json['expense'];

    String salaryString = salaryToDouble.toStringAsFixed(2);
    salaryString = salaryString.replaceAll(".", ",");
    String expenseString = expenseToDouble.toStringAsFixed(2);
    expenseString = expenseString.replaceAll(".", ",");

    return LegalPerson(
      id: json['id'],
      name: json['name'],
      cnpj: json['cnpj'],
      salary: salaryString,
      expense: expenseString,
    );
  }
}
