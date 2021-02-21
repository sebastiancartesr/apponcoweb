import 'package:demo1/controllers/calendariocontroll.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Perfil extends StatefulWidget {
  Perfil({Key key}) : super(key: key);

  @override
  _PerfilState createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  final CalendarioAux _auxcalendar = new CalendarioAux();
  DateTime _hoy = DateTime.now();
  DateTime aux;
  List<DateTime> _semana = [];


  //---------------------------------
  void _agregarFechas() {
    for (int i = 0; i < 7; i++) {
      aux = _hoy.subtract(Duration(days: i));
      String x = _splitter(aux.toString());
    }
    setState(() {
      _auxcalendar.listadias = _semana;
    });
    //print('duda');
    print(_semana);

    VerBitacorasemana();
  }

//----------------------------------------------
  String _splitter(String _sfecha) {
    try {
      List a = (_sfecha.split(" "));
      String auxC = a[0];
      List b = (auxC.split("-"));
      String fecha = (b[0] + "," + b[1] + "," + b[2]).toString();
      //DateTime(b[0], b[1], b[2]);
      _semana.add(DateTime(int.parse(b[0]), int.parse(b[1]), int.parse(b[2])));

      //<{'','',''}>
      // print(fecha);
      return auxC;
    } catch (e) {
      print(e);
    }
  }
//----------------------------------------------

  Future<List> VerBitacorasemana() async {
    final response = await http
        .post("http://192.168.1.27/demo1/verbitacorasemana.php", body: {
      "IdPaciente": '112',
      //"DataIni": _splitter(_auxcalendar.tiempoxd.toString()),
      "DataIni": '2021/02/01',
      "DataFin": '2021/02/07',
    });

    var datauser = json.decode(response.body);
    print('no seeeeeeeeee');
    print(datauser);
    print('salir del rest');
    //-------------------------------------------------------------------------------------------------
    for (int i = 0; i < datauser.length; i++) {
      if (_splitter(datauser[i]['FechaHora']) ==
          _splitter(_auxcalendar.listadias[6].toString())) {
        setState(() {
          _auxcalendar.dia1 = true;
        });
      }
    }
    //-------------------------------------------------------------------------------------------------
    for (int i = 0; i < datauser.length; i++) {
      if (_splitter(datauser[i]['FechaHora']) ==
          _splitter(_auxcalendar.listadias[5].toString())) {
        setState(() {
          _auxcalendar.dia2 = true;
        });
      }
    }
    //-------------------------------------------------------------------------------------------------
    for (int i = 0; i < datauser.length; i++) {
      if (_splitter(datauser[i]['FechaHora']) ==
          _splitter(_auxcalendar.listadias[4].toString())) {
        setState(() {
          _auxcalendar.dia3 = true;
        });
      }
    }
    //-------------------------------------------------------------------------------------------------
    for (int i = 0; i < datauser.length; i++) {
      if (_splitter(datauser[i]['FechaHora']) ==
          _splitter(_auxcalendar.listadias[3].toString())) {
        setState(() {
          _auxcalendar.dia4 = true;
        });
      }
    }
    //-------------------------------------------------------------------------------------------------
    for (int i = 0; i < datauser.length; i++) {
      if (_splitter(datauser[i]['FechaHora']) ==
          _splitter(_auxcalendar.listadias[2].toString())) {
        setState(() {
          _auxcalendar.dia5 = true;
        });
      }
    }
    //-------------------------------------------------------------------------------------------------
    for (int i = 0; i < datauser.length; i++) {
      if (_splitter(datauser[i]['FechaHora']) ==
          _splitter(_auxcalendar.listadias[1].toString())) {
        setState(() {
          _auxcalendar.dia6 = true;
        });
      }
    }
    //-------------------------------------------------------------------------------------------------
    for (int i = 0; i < datauser.length; i++) {
      if (_splitter(datauser[i]['FechaHora']) ==
          _splitter(_auxcalendar.listadias[0].toString())) {
        setState(() {
          _auxcalendar.dia7 = true;
        });
      }
    }
    //-------------------------------------------------------------------------------------------------
    return json.decode(response.body);
  }

//----------------------------------------------

  TextEditingController _correo;
  TextEditingController _edad;
  TextEditingController _telefono;
  TextEditingController _direccion;
  TextEditingController _clave;
  bool _activar = false;
  @override
  void initState() {
    _correo = new TextEditingController(text: 'prueba texto');
    _direccion = new TextEditingController(text: 'prueba texto');
    _edad = new TextEditingController(text: 'prueba texto');
    _telefono = new TextEditingController(text: 'prueba texto');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
      ),
      body: Stack(
        children: <Widget>[
          _Fondo(context),
          _body(context),
        ],
      ),
    );
  }

  Widget _Fondo(context) {
    final size = MediaQuery.of(context).size;
    final fondoarriba = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(color: Color.fromRGBO(189, 219, 255, 1)),
    );
    return Stack(
      children: <Widget>[
        fondoarriba,
        Container(
          decoration: BoxDecoration(color: Color.fromRGBO(189, 219, 255, 1)),
          padding: EdgeInsets.only(top: 20.0),
          child: Column(
            children: <Widget>[
              Image.asset(
                'images/medico.png',
                width: 100,
                height: 100,
              ),
              SizedBox(
                height: 10.0,
                width: double.infinity,
              ),
              Text(
                'Nombre',
                style: TextStyle(color: Colors.black, fontSize: 25.0),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _body(context) {
    return Column(
      children: <Widget>[
        SafeArea(
          child: Container(
            height: 150.0,
          ),
        ),
        Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          height: MediaQuery.of(context).size.height * .70,
          width: MediaQuery.of(context).size.height * .85,
          margin: EdgeInsets.symmetric(vertical: 20.0),
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            children: <Widget>[
              Text(
                'rut',
                style: TextStyle(fontSize: 20.0),
              ),
              SizedBox(height: 0.0),
              _botones(context),
              SizedBox(height: 30.0),
              _email(),
              SizedBox(height: 30.0),
              _edadd(),
              SizedBox(height: 30.0),
              _telefonoo(),
              SizedBox(height: 30.0),
              _direccioon(),
              SizedBox(height: 30.0),
              _clavee(),
              SizedBox(height: 30.0),
              _botonguardar(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _botones(context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      _botonbitacora(),
      SizedBox(width: 30.0),
      _botoneditar(),
      SizedBox(width: 30.0),
      _botonalertas()
    ]);
  }

  _cambiar() {
    if (_activar == true) {
      setState(() {
        _activar = false;
      });
    } else {
      setState(() {
        _activar = true;
      });
    }
  }

  Widget _botoneditar() {
    return RaisedButton(
      onPressed: () => {_cambiar()},
      color: Colors.black.withOpacity(0.0),
      elevation: 0.0,
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[Icon(Icons.edit), Text("Editar datos")],
      ),
    );
  }

  Widget _botonbitacora() {
    return RaisedButton(
      onPressed: () {
        _agregarFechas();
      },
      elevation: 0.0,
      color: Colors.black.withOpacity(0.0),
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[Icon(Icons.assignment), Text("Ver bitacoras")],
      ),
    );
  }

  Widget _botonalertas() {
    return RaisedButton(
      onPressed: () => {Navigator.pushNamed(context, '/calendario')},
      elevation: 0.0,
      color: Colors.black.withOpacity(0.0),
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Icon(Icons.assignment_late_outlined),
          Text("Ver alertas")
        ],
      ),
    );
  }

//-------------------------------------------
  Widget _email() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        enabled: false,
        controller: _correo,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          icon: Icon(
            Icons.email_outlined,
            color: Colors.black,
          ),
          hintText: 'ejemplo@correo.com',
          labelText: 'Correo electronico',
        ),
      ),
    );
  }

  Widget _edadd() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        enabled: _activar,
        controller: _edad,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          icon: Icon(
            Icons.calendar_today_rounded,
            color: Colors.black,
          ),
          hintText: 'ejemplo@correo.com',
          labelText: 'Correo electronico',
        ),
      ),
    );
  }

  Widget _telefonoo() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        enabled: _activar,
        controller: _correo,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          icon: Icon(
            Icons.phone_android_outlined,
            color: Colors.black,
          ),
          hintText: 'ejemplo@correo.com',
          labelText: 'Correo electronico',
        ),
      ),
    );
  }

  Widget _direccioon() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        enabled: _activar,
        controller: _direccion,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          icon: Icon(
            Icons.home_outlined,
            color: Colors.black,
          ),
          hintText: 'Calle numero, comuna, región',
          labelText: 'Dirección',
        ),
      ),
    );
  }

  Widget _clavee() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        enabled: _activar,
        controller: _clave,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          icon: Icon(
            Icons.lock_outlined,
            color: Colors.black,
          ),
          hintText: 'Contraseña',
          labelText: 'Contraseña',
        ),
      ),
    );
  }

  Widget _botonguardar() {
    return RaisedButton(
      onPressed: () => {_cambiar()},
      color: Colors.grey.withOpacity(1.0),
      elevation: 0.0,
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[Text("guardar")],
      ),
    );
  }
}
