import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:demo1/controllers/auxpaciente.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class FormScreen5 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormScreen5State();
  }
}

class FormScreen5State extends State<FormScreen5> {
  final Paciente _paciente = new Paciente();
  String _password;
  String _phoneNumber;
  String _direccion;
  

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    Widget _buildPassword() {
    return TextFormField(
      initialValue : _paciente.clave,
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
      initialValue : _paciente.numerodetelefono,
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
      initialValue : _paciente.direccion,
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
  // Funcion para actualizar los datos personales de los pacientes
      Future <List> actualizardatos() async{
      
      final response = await http.post("http://192.168.1.27/demo1/editardatospaciente.php", body:{
      "Telefono":_phoneNumber,
      "Clave":_password,
      "Direccion":_direccion,
      "IdPaciente":_paciente.idd,
      });
      Navigator.of(context).pop();    
    }

  

  @override
  
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Editar datos de paciente")),
      body: Container(
        margin: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(_paciente.nombre, style: TextStyle(color: Colors.black, fontSize: 20) ),
              _buildPassword(),
              _buildPhoneNumber(),
              _buildDireccion(),
              SizedBox(height: 50),
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
                  print(_paciente.idd);
                  actualizardatos();
                  //Navigator.of(context).pop();
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