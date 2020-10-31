import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:demo1/controllers/usuario.dart';
import 'package:demo1/controllers/bitacoraController.dart';
import 'package:demo1/controllers/auxpaciente.dart';

class VerPacienteBorrar extends StatelessWidget {

  final Usuario _usuario = new Usuario();
     
    Future<List> getData() async {
    final response = await http.post("http://192.168.1.108/demo1/verpacientes.php", body:{
      "IdMedico":_usuario.id.toString(),
    }); 
    return json.decode(response.body);  
  }
 /*
    Future <List> borrarpaciente() async{
      
      final response = await http.post("http://192.168.1.108/demo1/borrarpaciente.php", body:{
      "IdPersona":_borrar,
      });

    
    }
    */

  @override
  
   Widget build(BuildContext context) {
    return new Scaffold(
      body: new FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? new ItemList(
                  list: snapshot.data,
                )
              : new Center(
                  child: new CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List list;
  ItemList({this.list});
  final Paciente _paciente = new Paciente();
  String _borrar='';
  @override
  
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return new Container(
          padding: const EdgeInsets.all(10.0),
          child: new GestureDetector(
            onTap: () {
              _borrar=list[i]['Rut'];
              print(_borrar);


            },
            /*
            => Navigator.of(context).push(            
                  new MaterialPageRoute(                                 
                      builder: (BuildContext context) => new borrarpaciente(
                           list: list,
                            index: i,
                          )),
                ),*/
            child: new Card(
              child: new ListTile(
                title: new Text(
                  list[i]['PrimerNombre']+' '+list[i]['PrimerApellido'],
                  style: TextStyle(fontSize: 25.0, color: Colors.orangeAccent),
                ),
                leading: new Icon(
                  Icons.person,
                  size: 55.0,
                  color: Colors.orangeAccent,
                ),
                subtitle: new Text(
                  "Rut: ${list[i]['Rut']}",
                  style: TextStyle(fontSize: 20.0, color: Colors.black),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
//----------------------------------------------------------
