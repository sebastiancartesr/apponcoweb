class Usuario {
  static final Usuario _singleton = new Usuario._internal();
  Usuario._internal();
  factory Usuario() => _singleton;
  int _id = 0;
  String _nombre ='';
  String _telefono ='';
  String _clave='';
  String _idMedico='';
  String _centro='';


  int get id => _id;
  String get nombre => _nombre;
  String get telefono => _telefono;
  String get clave => _clave;
  String get idMedico => _idMedico;
  String get centro => _centro;

  set id(int value) => _id = value;
  set nombre(String value) => _nombre = value;
  set telefono(String value) => _telefono = value;
  set clave(String value) => _clave = value;
  set idMedico(String value) => _idMedico = value;
  set centro(String value) => _centro = value;


}