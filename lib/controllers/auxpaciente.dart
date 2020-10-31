class Paciente {
  static final Paciente _singleton = new Paciente._internal();
  Paciente._internal();
  factory Paciente() => _singleton;

  String _idd = '0';
  String _fechabitacora='';

  String get idd => _idd;
  String get fechabitacora => _fechabitacora;

  set idd(String value) => _idd = value;
  set fechabitacora(String value) => _fechabitacora = value;
}