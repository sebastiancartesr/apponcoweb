import 'package:demo1/controllers/usuario.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
class FunctionBitacora {
    Future<List> getData(Usuario user) async {
    final response =
        await http.post("http://192.168.1.27/demo1/verpacientes.php", body: {
      "IdMedico": user.id.toString(),
    });
    return json.decode(response.body);
  }
    Future<List> verBitacora(String idpaciente, String fecha) async {
    final response =
        await http.post("http://192.168.1.27/demo1/verbitacora.php", body: {
      "IdPaciente": idpaciente,
      "DataIni": fecha,
    });
    var datauser = json.decode(response.body);
    return json.decode(response.body);
  }
  
}