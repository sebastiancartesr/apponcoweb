import 'package:demo1/Function/alertas_function.dart';
import 'package:demo1/Function/bitacoras_function.dart';
import 'package:demo1/Function/dashboard.dart';
import 'package:demo1/controllers/usuario.dart';
import 'package:demo1/ventanas/administrador/vertrabajadores.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:demo1/main.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'dart:convert';
import 'package:demo1/controllers/login_bloc.dart';

void main() {
  test('validar funcionamiento login', () async {
    final LoginBloc data = new LoginBloc();
    data.changeEmail('sebacartes35@gmail.com');
    data.changeClave('123456');
    final login = LoginPage();
    final result = await login.Loginmedico(data);
    final List resultado_esperado = [
      {
        'IdPersona': '1',
        'Rut': '199287915',
        'Correo': 'sebacartes35@gmail.com',
        'Clave': '123456',
        'PrimerNombre': 'Sebastian',
        'SegundoNombre': 'Daniel',
        'PrimerApellido': 'Cartes',
        'SegundoApellido': 'Rosales',
        'Telefono': '226247444',
        'Direccion': 'los diaguitas',
        'IdCetrooncologico': '123'
      }
    ];
    expect(result, resultado_esperado);
  });
  test('validar funcionamiento login admin', () async {
    final LoginBloc data = new LoginBloc();
    data.changeEmail('admin@gmail.com');
    data.changeClave('111111');
    final login = LoginPage();
    final result = await login.Loginmedico(data);
    final List resultado_esperado = [
      {
        'IdPersona': '5',
        'Rut': '199287916',
        'Correo': 'admin@gmail.com',
        'Clave': '111111',
        'PrimerNombre': 'sebastian',
        'SegundoNombre': 'daniel',
        'PrimerApellido': 'cartes',
        'SegundoApellido': 'rosales',
        'Telefono': '1231512',
        'Direccion': 'casa',
        'IdCetrooncologico': '123'
      }
    ];
    expect(result, resultado_esperado);
  });

  test('validar datos dashboard 1', () async {
    final Usuario user = new Usuario();
    user.id = 0;
    final dash = FunctionDasboard();
    final resultad = await dash.GetData(user);
    final resultado_getdata = [];
    expect(resultad, resultado_getdata);
  });
  test('validar datos dashboard 2', () async {
    final Usuario user = new Usuario();
    user.id = 0;
    final dash = FunctionDasboard();
    final resultad = await dash.GetData2(user);
    final resultado_getdata = [];
    expect(resultad, resultado_getdata);
  });
  test('validar datos dashboard 3', () async {
    final Usuario user = new Usuario();
    user.id = 0;
    final dash = FunctionDasboard();
    final resultad = await dash.GetData3(user);
    final resultado_getdata = [];
    expect(resultad, resultado_getdata);
  });
  test('validar datos dashboard 4', () async {
    final Usuario user = new Usuario();
    user.id = 0;
    final dash = FunctionDasboard();
    final resultad = await dash.GetData4(user);
    final resultado_getdata = [];
    expect(resultad, resultado_getdata);
  });
  test('validar datos dashboard 5', () async {
    final Usuario user = new Usuario();
    user.id = 0;
    final dash = FunctionDasboard();
    final resultad = await dash.GetData5(user);
    final resultado_getdata = [
      {'CountAlertas': '0', 'CountPaciente': '0'}
    ];
    expect(resultad, resultado_getdata);
  });
  test('validar datos dashboard 6', () async {
    final Usuario user = new Usuario();
    user.id = 0;
    final dash = FunctionDasboard();
    final resultad = await dash.GetData6(user);
    final resultado_getdata = [
      {'CountAlertas': '0', 'CountBitacoras': '0'}
    ];
    expect(resultad, resultado_getdata);
  });
  test('validar traer bitacora', () async {
    String user = "116";
    String date = "2021-02-24";
    final bita = FunctionBitacora();
    final resultad = await bita.verBitacora(user, date);
    final resultado_getdata = [
      {
        'IdBitacora': '122',
        'FechaHora': '2021-02-24 07:15:39',
        'Nauseas': '0',
        'Vomitos': '0',
        'Diarrea': '0',
        'Constipacion': '0',
        'Dolor': '4',
        'Fatiga': '0',
        'PerdidaApetito': '0',
        'Fiebre': '40.0',
        'SintomasResfrio': '0',
        'SintomasUnitarios': '4',
        'ValorICG': '0',
        'IdPaciente': '116'
      }
    ];

    expect(resultad, resultado_getdata);
  });
  test('validar traer pacientes', () async {
    final Usuario user = new Usuario();
    user.id = 0;
    final bita = FunctionBitacora();
    final resultad = await bita.getData(user);
    final resultado_getdata = [];
    expect(resultad, resultado_getdata);
  });
  test('validar traer alertas', () async {
    final alert = AlertaFunction();
    String user = "0";
    final resultad = await alert.Getalerta(user);
    final resultado_getdata = [];
    expect(resultad, resultado_getdata);
  });
  test('validar traer funcionarios', () async {
    final trabajadores = VerTrabajadores();
    final resultad = await trabajadores.GetTrabajadores();
    final resultado_getdata = [
      {
        'IdPersona': '1',
        'Rut': '199287915',
        'Correo': 'sebacartes35@gmail.com',
        'Clave': '123456',
        'PrimerNombre': 'Sebastian',
        'SegundoNombre': 'Daniel',
        'PrimerApellido': 'Cartes',
        'SegundoApellido': 'Rosales',
        'Telefono': '226247444',
        'Direccion': 'los diaguitas',
        'IdCetrooncologico': '123'
      },
      {
        'IdPersona': '2',
        'Rut': '196684360',
        'Correo': 'asfo.2009@gmail.com',
        'Clave': '5557',
        'PrimerNombre': 'andree',
        'SegundoNombre': 'simon',
        'PrimerApellido': 'figueroa',
        'SegundoApellido': 'olivares',
        'Telefono': '125125',
        'Direccion': 'casa andree',
        'IdCetrooncologico': '123'
      },
      {
        'IdPersona': '5',
        'Rut': '199287916',
        'Correo': 'admin@gmail.com',
        'Clave': '111111',
        'PrimerNombre': 'sebastian',
        'SegundoNombre': 'daniel',
        'PrimerApellido': 'cartes',
        'SegundoApellido': 'rosales',
        'Telefono': '1231512',
        'Direccion': 'casa',
        'IdCetrooncologico': '123'
      }
    ];
    expect(resultad, resultado_getdata);
  });
}
