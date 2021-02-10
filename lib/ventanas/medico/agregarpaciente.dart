import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:demo1/controllers/usuario.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class FormScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormScreenState();
  }
}

class FormScreenState extends State<FormScreen> {
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
    String _idmedico=_usuario.idMedico;
// Funcion para agregar pacientes.
    void addPaciente() {
      var url = "http://192.168.42.49/demo1/agregarpaciente.php";

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
        "IdMedico":_idmedico,
    }
    
    );
  }
    return Scaffold(
      appBar: AppBar(title: Text("Agregar paciente")),
      body: Container(
        margin: EdgeInsets.all(24),
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

              SizedBox(height: 50),
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
                  addPaciente();
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