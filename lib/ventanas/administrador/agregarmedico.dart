import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:demo1/controllers/usuario.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:demo1/controllers/auxpersona.dart';

class FormScreen2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormScreen2State();
  }
}

class FormScreen2State extends State<FormScreen2> {
  String mensaje='';
  final Usuario _usuario = new Usuario();
  String _rut;
  String _email;
  String _password;
  String _primnombre;
  String _segundnombre;
  String _primapellido;
  String _segundapellido;
  String _phoneNumber;
  String _direccion;
  String _centro;
  

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    Widget _builRut() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Rut'),
      maxLength: 9,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Rut es requerido';
        }

        return null;
      },
      onSaved: (String value) {
        _rut = value;
      },
    );
  }
    Widget _buildEmail() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Email'),
      maxLength: 40,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Correo requerido';
        }

        if (!RegExp(
                r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value)) {
          return 'Ingrese un correo valido';
        }

        return null;
      },
      onSaved: (String value) {
        _email = value;
      },
    );
  }
    Widget _buildPassword() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Contraseña'),
      maxLength: 10,
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
    Widget _buildName() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Primer nombre'),
      maxLength: 10,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Primer nombre requerido';
        }

        return null;
      },
      onSaved: (String value) {
        _primnombre = value;
      },
    );
  }
    Widget _buildSecondName() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Segundo nombre'),
      maxLength: 10,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Segundo nombre requerido';
        }

        return null;
      },
      onSaved: (String value) {
        _segundnombre = value;
      },
    );
  }
    Widget _buildApellido() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Primer apellido'),
      maxLength: 10,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Primer apellido requerido';
        }

        return null;
      },
      onSaved: (String value) {
        _primapellido = value;
      },
    );
  }
    Widget _buildSegundoApellido() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Segundo apellido'),
      maxLength: 10,
      validator: (String value) {
        if (value.isEmpty) {
          return 'segundo apellido requerido';
        }

        return null;
      },
      onSaved: (String value) {
        _segundapellido = value;
      },
    );
  }
    Widget _buildPhoneNumber() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Numero de telefono'),
      maxLength: 9,
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

  


  @override
  
  Widget build(BuildContext context) {
    final Persona _persona = new Persona();

    String _centro=_usuario.centro;
//--------------------------------------------------------------------------
    void addTrabajador(){
      var url = "http://192.168.1.30/demo1/creartrabajador.php";
      http.post(url, body: {
        "IdPersona": _persona.iddd,
        "IdRol": _persona.idrol,

    }

    
    
    );
  Navigator.of(context).pop();
    }

//----------------------------------------------------------------------------
  Future <List> getidrol() async{
    final response = await http.post("http://192.168.1.30/demo1/idrol.php", body:{
      "NombreRol":_persona.rol,
    });
    var datauser = json.decode(response.body);
    print(datauser[0]);

    if(datauser.length == 0){
      print('error2');
    }else{
      setState(() {
        
          _persona.idrol= datauser[0]['IdRol'];
          
          print(_persona.idrol);
          print('----------');
      });    

    }
    addTrabajador();
    return datauser;
    }
//---------------------------------------------------------------------------
//-----idpersona agregada no se tiene

   Future <List> getid() async{
    final response = await http.post("http://192.168.1.30/demo1/buscarid.php", body:{
      "Correo":_email,
    });
    var datauser = json.decode(response.body);

    if(datauser.length == 0){
      print('error1');
    }else{
      setState(() {
          _persona.iddd= datauser[0]['IdPersona'];
          print(_persona.iddd);
      });    
      
    }
    print('paso2');
    getidrol();
    print('paso3');
    return datauser;
    }
//----------------------------------------------------------------------------


    void addMedico() {
      var url = "http://192.168.1.30/demo1/agregarpersona.php";

      http.post(url, body: {
        "Rut": _rut,
        "Correo": _email,
        "Clave": _password,
        "PrimerNombre": _primnombre,
        "SegundoNombre": _segundnombre,
        "PrimerApellido": _primapellido,
        "SegundoApellido": _segundapellido,
        "Telefono": _phoneNumber,
        "Direccion": _direccion,
        "IdCetrooncologico":_centro,
    }
    
    );
    print('paso1');
    getid();

  }
  //validar rut
       Future <List> verificardatos() async{
      
      final response = await http.post("http://192.168.1.30/demo1/verdatospersona.php", body:{
      "Correo":_email,
      "Rut":_rut,
      });
      var datauser = json.decode(response.body);

      if(datauser.length == 0){
        addMedico();
               

      }else{
        showDialog(
          context: context,         
          builder: (context) => AlertDialog(
            title: Text('El rut o correo ya esta registrado'),
            actions:<Widget>[
              FlatButton(onPressed: (){
                Navigator.of(context).pop();
              },
               child: Text('Aceptar'))
            ],),
        ); 


    }

    return datauser;
    }
  

  //----
    return Scaffold(
      appBar: AppBar(
        title: Text("Agregar trabajador"),
                  leading: new IconButton(
            icon: new Icon(Icons.arrow_back_sharp),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _builRut(),
              _buildEmail(),
              _buildPassword(),
              _buildName(),
              _buildSecondName(),
              _buildApellido(),
              _buildSegundoApellido(),
              _buildPhoneNumber(),
              _buildDireccion(),
              DropDown(),

              SizedBox(height: 10),
              RaisedButton(
                child: Text(
                  'Agregar',
                  style: TextStyle(color: Colors.blue, fontSize: 16),
                ),
                onPressed: () {
                  if (!_formKey.currentState.validate()) {
                    return;
                  }

                  _formKey.currentState.save();
                  verificardatos();
                  
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
class DropDown extends StatefulWidget {
  DropDown({Key key}) : super(key: key);

  @override
  _DropDownState createState() => _DropDownState();
}
class _DropDownState extends State<DropDown> {
  String dropdownValue = 'Medico';
    final Persona _persona = new Persona();

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
          _persona.rol= dropdownValue;
          print('pruebarol');
          print(_persona.rol);
        });
      },
      items: <String>['Medico', 'Asistente']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
