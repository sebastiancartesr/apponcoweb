class Persona {
  static final Persona _singleton = new Persona._internal();
  Persona._internal();
  factory Persona() => _singleton;

  String _rol = '0';
  String _iddd= '0';
  String _idrol='0';


  String get rol => _rol;
  String get iddd => _iddd;
  String get idrol => _idrol;

  set rol(String value) => _rol = value;
  set iddd (String value) => _iddd = value;
  set idrol (String value) => _idrol = value;
}