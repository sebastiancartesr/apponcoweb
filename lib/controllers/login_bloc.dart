import 'dart:async';
import 'package:demo1/controllers/validator.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators{

  final _emailController = BehaviorSubject<String>();
  final _claveController = BehaviorSubject<String>();
  //-----------validar datos---------
  Stream<String> get emailStream => _emailController.stream.transform(validaEmail);
  Stream<String> get claveStream => _claveController.stream.transform(validarClave);
  Stream<bool> get formValidStream =>
       Rx.combineLatest2(emailStream, claveStream, (e, p) => true);
  //-------------get-----------------
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changeClave => _claveController.sink.add;
  //------------set------------------
  String get email => _emailController.value;
  String get clave => _claveController.value;
  
  dispose(){
    _emailController?.close();
    _claveController?.close();
  }
}