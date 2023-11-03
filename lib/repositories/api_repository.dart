// ignore_for_file: constant_identifier_names

abstract class ApiRepository {
  static const BASE = 'http://10.0.2.2:8080/';

  static const PHYSICAL_PERSONS = '${BASE}physical_persons';

  static const LEGAL_PERSONS = '${BASE}legal_persons';
}
