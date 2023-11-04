abstract class Regex {
  static const String cpf = r"^([0-9]){3}\.([0-9]){3}\.([0-9]){3}-([0-9]){2}$";
  static const String cnpj = r"^\d{2}\.\d{3}\.\d{3}\/\d{4}-\d{2}$";
}
