class Paciente {
  static final Paciente _singleton = new Paciente._internal();
  Paciente._internal();
  factory Paciente() => _singleton;

  String _idd = '0';
  String _fechabitacora='';
  String _correo='';
  String _clave='';
  String _numerodetelefono='';
  String _direccion='';
  String _nombre='';

  String get idd => _idd;
  String get fechabitacora => _fechabitacora;
  String get correo =>_correo;
  String get clave =>_clave;
  String get numerodetelefono =>_numerodetelefono;
  String get direccion =>_direccion;
  String get nombre =>_nombre;

  set idd(String value) => _idd = value;
  set fechabitacora(String value) => _fechabitacora = value;
  set correo(String value) => _correo = value;
  set clave(String value) => _clave = value;
  set numerodetelefono(String value) => _numerodetelefono = value;
  set direccion(String value) => _direccion = value;
  set nombre(String value) => _nombre = value;
}