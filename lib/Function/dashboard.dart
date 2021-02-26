import 'package:demo1/controllers/usuario.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class FunctionDasboard {
    Future<List> GetData(Usuario _usuario) async {
    final response =
        await http.post("http://192.168.1.27/demo1/verpacalertas.php", body: {
      "IdMedico": _usuario.id.toString(),
      "DataIni":
          '${DateTime.now().year.toString()}-${DateTime.now().month.toString()}-${DateTime.now().day.toString()}'
    });
    return json.decode(response.body);
  }

  Future<List> GetData2(Usuario _usuario) async {
    final response =
        await http.post("http://192.168.1.27/demo1/vermaxfiebre.php", body: {
      "IdMedico": _usuario.id.toString(),
      "DataIni":
          '${DateTime.now().year.toString()}-${DateTime.now().month.toString()}-${DateTime.now().day.toString()}'
    });
    return json.decode(response.body);
  }

  Future<List> GetData3(Usuario _usuario) async {
    final response =
        await http.post("http://192.168.1.27/demo1/notbitacora.php", body: {
      "IdMedico": _usuario.id.toString(),
      "DataIni":
          '${DateTime.now().year.toString()}-${DateTime.now().month.toString()}-${DateTime.now().day.toString()}'
    });
    return json.decode(response.body);
  }

  Future<List> GetData4(Usuario _usuario) async {
    final response =
        await http.post("http://192.168.1.27/demo1/pacdiarrea.php", body: {
      "IdMedico": _usuario.id.toString(),
      "DataIni":
          '${DateTime.now().year.toString()}-${DateTime.now().month.toString()}-${DateTime.now().day.toString()}'
    });
    return json.decode(response.body);
  }

  Future<List> GetData5(Usuario _usuario) async {
    final response =
        await http.post("http://192.168.1.27/demo1/contador1.php", body: {
      "IdMedico": _usuario.id.toString(),
      "DataIni":
          '${DateTime.now().year.toString()}-${DateTime.now().month.toString()}-${DateTime.now().day.toString()}'
    });
    return json.decode(response.body);
  }

  Future<List> GetData6(Usuario _usuario) async {
    final response =
        await http.post("http://192.168.1.27/demo1/contador2.php", body: {
      "IdMedico": _usuario.id.toString(),
      "DataIni":
          '${DateTime.now().year.toString()}-${DateTime.now().month.toString()}-${DateTime.now().day.toString()}'
    });
    return json.decode(response.body);
  }
  
}