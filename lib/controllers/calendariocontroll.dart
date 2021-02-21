class CalendarioAux {
  static final CalendarioAux _singleton = new CalendarioAux._internal();
  CalendarioAux._internal();
  factory CalendarioAux() => _singleton;

  List<DateTime> _listadias;
  DateTime _tiempoxd;
  List<DateTime> get listadias => _listadias;
  DateTime get tiempoxd => _tiempoxd;
  set listadias(List<DateTime> value) => _listadias = value;
  set tiempoxd(DateTime value) => _tiempoxd = value;

  //
  bool _dia1=false;
  bool get dia1 => _dia1;
  set dia1(bool value) => _dia1 = value;
  //
  bool _dia2=false;
  bool get dia2 => _dia2;
  set dia2(bool value) => _dia2 = value;
  //
  bool _dia3=false;
  bool get dia3 => _dia3;
  set dia3(bool value) => _dia3 = value;
  //
  bool _dia4=false;
  bool get dia4 => _dia4;
  set dia4(bool value) => _dia4 = value;
  //
  bool _dia5=false;
  bool get dia5 => _dia5;
  set dia5(bool value) => _dia5 = value;
  //
  bool _dia6=false;
  bool get dia6 => _dia6;
  set dia6(bool value) => _dia6 = value;
  //
  bool _dia7=false;
  bool get dia7 => _dia7;
  set dia7(bool value) => _dia7 = value;
  //
  int _bitacorast;
  int get bitacorast => _bitacorast;
  set bitacorast(int value) => _bitacorast = value;
    //
  int _alertast;
  int get alertast => _alertast;
  set alertast(int value) => _alertast = value;
}
