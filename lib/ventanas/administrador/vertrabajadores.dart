import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:demo1/controllers/usuario.dart';


class VerTrabajadores extends StatelessWidget {
  final Usuario _usuario = new Usuario();
     
    Future<List> GetTrabajadores() async {
    final response = await http.post("http://192.168.1.27/demo1/vertrabajadores.php", body:{
    }); 
    return json.decode(response.body);  
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
 
      body: new FutureBuilder<List>(
        future: GetTrabajadores(),
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
                      builder: (BuildContext context) => new Detail(
                            list: list,
                            index: i,
                          )),
                ),
            child: new Card(
              child: new ListTile(
                title: new Text(
                  "Trabajador: ${list[i]['PrimerNombre']} ${list[i]['PrimerApellido']}",
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

class Detail extends StatefulWidget {
  List list;
  int index;
  Detail({this.index,this.list});
  @override
  _DetailState createState() => new _DetailState();
}

class _DetailState extends State<Detail> {
  final Usuario _usuario = new Usuario();
  String _password;
  String _phoneNumber;
  String _direccion;
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    Widget _buildPassword() {
    return TextFormField(
      initialValue : widget.list[widget.index]['Clave'],
      decoration: InputDecoration(labelText: 'Contraseña'),
      keyboardType: TextInputType.visiblePassword,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Contraseña requerida';
        }

        return null;
      },
      onSaved: (String value) {
        _password = value;
      },
    );
  }

    Widget _buildPhoneNumber() {
    return TextFormField(
      initialValue : widget.list[widget.index]['Telefono'],
      decoration: InputDecoration(labelText: 'Numero de telefono'),
      keyboardType: TextInputType.phone,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Numero de telefono requerido';
        }

        return null;
      },
      onSaved: (String value) {
        _phoneNumber = value;
      },
    );
  }
    Widget _buildDireccion() {
    return TextFormField(
      initialValue : widget.list[widget.index]['Direccion'],
      decoration: InputDecoration(labelText: 'Direccion'),
      maxLength: 35,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Direccion requerida';
        }

        return null;
      },
      onSaved: (String value) {
        _direccion = value;
      },
    );
  }
      Future <List> actualizardatos() async{
      
      final response = await http.post("http://192.168.1.27/demo1/editardatostrabajador.php", body:{
      "Telefono":_phoneNumber,
      "Clave":_password,
      "Direccion":_direccion,
      "IdPersona":widget.list[widget.index]['IdPersona'],
      });
      Navigator.of(context).pop();    
    }


  @override
  Widget build(BuildContext context) {
    String nombre= _usuario.nombre;
    return new Scaffold(
      appBar: new AppBar(title: new Text("${widget.list[widget.index]['Rut']}")),
      body: new Container(
        //height: 270.0, 
        padding: const EdgeInsets.all(20.0),
        child: new Form(
          key: _formKey,
          //child: new Center(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("${widget.list[widget.index]['PrimerNombre']} ${widget.list[widget.index]['PrimerApellido']}", style: TextStyle(color: Colors.black, fontSize: 20) ),
              _buildPassword(),
              _buildPhoneNumber(),
              _buildDireccion(),
              //SizedBox(height: 200),
              RaisedButton(
                child: Text(
                  'Actualizar',
                  style: TextStyle(color: Colors.blue, fontSize: 16),
                ),
                onPressed: () {
                  if (!_formKey.currentState.validate()) {
                    return;
                  }

                  _formKey.currentState.save();
                  actualizardatos();
                  //Navigator.of(context).pop();
                  //Navigator.popAndPushNamed(context, '/menutrabajador');
                },
              )
            ],
                )
  
          //),
        ),
      ),
    );
  }
}