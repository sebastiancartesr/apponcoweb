import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
class AlertaFunction {
      Future<List> Getalerta(String idpac) async {
    final response = await http.post("http://192.168.1.27/demo1/veralertaunpaciente.php", body:{
      "IdPaciente":idpac,
    }); 
    var datauser = json.decode(response.body);
    return json.decode(response.body);  
  }
}