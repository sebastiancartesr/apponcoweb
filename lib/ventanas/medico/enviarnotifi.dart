import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:demo1/controllers/usuario.dart';
import 'package:demo1/controllers/bitacoraController.dart';
import 'package:demo1/controllers/auxpaciente.dart';

class EnviarNotificacion extends StatelessWidget {

  final Usuario _usuario = new Usuario();
     
    Future<List> getData() async {
    final response = await http.post("http://192.168.1.108/demo1/verpacientes.php", body:{
      "IdMedico":_usuario.id.toString(),
    }); 
    return json.decode(response.body);  
  }

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
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return new Container(
          padding: const EdgeInsets.all(10.0),
          child: new GestureDetector(
            onTap: () => Navigator.of(context).push(            
                  new MaterialPageRoute(                                 
                      builder: (BuildContext context) => new FormScreennotifi(
                           list: list,
                            index: i,
                          )),
                ),
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
/*
class EnviarNotifi extends StatefulWidget {
  List list;
  int index;
  
  EnviarNotifi({this.index,this.list});

  @override
  _EnviarNotifi createState() => _EnviarNotifi();
}
class _EnviarNotifi extends State<EnviarNotifi> { 
  TextEditingController titulo = new TextEditingController();
  TextEditingController remitente = new TextEditingController();
  TextEditingController mensaje = new TextEditingController();
  DateTime now= new DateTime.now();
    void enviaralertaphp() {
    var url = "http://192.168.1.108/demo1/adalerta.php";

    http.post(url, body: {
      "TipoNotificacion": '1',
      "FechaNotificacion": now.toString(),
      "Titulo": titulo.toString(),
      "Remitente":remitente.toString(),
      "Mensaje":mensaje.toString(),
      "IdPaciente":widget.list[widget.index]['IdPaciente'].toString(),
    });
  }
  @override
  Widget build(BuildContext context) {
        return Scaffold(
      appBar: AppBar(title: Text("Agregar paciente")),
      body: Container(
        margin: EdgeInsets.all(24),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child:TextFormField(
                controller: titulo,
                decoration: InputDecoration(
                  hintText: "Titulo del mensaje"
                )
              )
              ),
              Container(
                child:TextFormField(
                controller: remitente,
                decoration: InputDecoration(
                  hintText: "Remitente"
                )
              )
              ),
              Container(
                child:TextFormField(
                controller: mensaje,
                decoration: InputDecoration(
                  hintText: "Mensaje"
                )
              )
              ),
              Container(
                child:RaisedButton(
                  child: new Text('Enviar'),
                  onPressed:(){
                    enviaralertaphp();
                }
                )
              ),

            ],
          ),
        ),
      ),
    );

  }
}*/

class FormScreennotifi extends StatefulWidget {
  List list;
  int index;
  
  FormScreennotifi({this.index,this.list});
  @override
  State<StatefulWidget> createState() {
    return FormScreennotifiState();
  }
}

class FormScreennotifiState extends State<FormScreennotifi> {
  String _titulo;
  String _remitente;
  String _mensaje;
  DateTime now= new DateTime.now();
  

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    Widget _builTitulo() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Titulo'),
      maxLength: 25,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Titulo es requerido';
        }

        return null;
      },
      onSaved: (String value) {
        _titulo = value;
      },
    );
  }
      Widget _builRemitente() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Remitente'),
      maxLength: 25,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Remitente es requerido';
        }

        return null;
      },
      onSaved: (String value) {
        _remitente = value;
      },
    );
  }

    Widget _buildMensaje() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Mensaje'),
      maxLength: 50,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Mensaje requerido';
        }

        return null;
      },
      onSaved: (String value) {
        _mensaje = value;
      },
    );
  }
    void enviaralertaphp() {
    var url = "http://192.168.1.108/demo1/adalerta.php";

    http.post(url, body: {
      "TipoNotificacion": '1',
      "FechaNotificacion": now.toString(),
      "Titulo": _titulo,
      "Remitente":_remitente,
      "Mensaje":_mensaje,
      "IdPaciente":widget.list[widget.index]['IdPaciente'].toString(),
    });
  }
  


  @override
  
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Agregar paciente")),
      body: Container(
        margin: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _builTitulo(),
              _builRemitente(),
              _buildMensaje(),

              SizedBox(height: 50),
              RaisedButton(
                child: Text(
                  'Enviar',
                  style: TextStyle(color: Colors.blue, fontSize: 16),
                ),
                onPressed: () {
                  if (!_formKey.currentState.validate()) {
                    return;
                  }
                  _formKey.currentState.save();
                  enviaralertaphp();
                  Navigator.of(context).pop();
                  //Navigator.popAndPushNamed(context, '/menutrabajador');
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}