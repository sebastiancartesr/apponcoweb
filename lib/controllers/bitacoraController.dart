class BitacoraController {
  static final BitacoraController _singleton = new BitacoraController._internal();
  BitacoraController._internal();
  factory BitacoraController() => _singleton;
  String _nauseas= '';
  String _vomito='';
  String _diarrea='';
  String _constipacion='';
  String _dolor='';
  String _fatiga='';
  String _perdidaapetito='';
  String _fiebre=''; 
  String _sintomaresfrio='';
  String _sintomasunitarios='';
  String _valoricg='';

  String get nauseas => _nauseas;
  String get vomito => _vomito;
  String get diarrea => _diarrea;
  String get constipacion => _constipacion;
  String get dolor => _dolor;
  String get fatiga => _fatiga;
  String get perdidaapetito => _perdidaapetito;
  String get fiebre => _fiebre;
  String get sintomaresfrio => _sintomaresfrio;
  String get sintomasunitarios => _sintomasunitarios;
  String get valoricg => _valoricg;

  set nauseas(String value) => _nauseas = value;
  set vomito(String value) => _vomito = value;
  set diarrea(String value) => _diarrea = value;
  set constipacion(String value) => _constipacion = value;
  set dolor(String value) => _dolor = value;
  set fatiga(String value) => _fatiga = value;
  set perdidaapetito(String value) => _perdidaapetito = value;
  set fiebre(String value) => _fiebre = value;
  set sintomaresfrio(String value) => _sintomaresfrio = value;
  set sintomasunitarios(String value) => _sintomasunitarios = value;
  set valoricg(String value) => _valoricg = value;
}