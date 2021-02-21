import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:demo1/controllers/usuario.dart';
import 'package:demo1/controllers/bitacoraController.dart';
import 'package:demo1/controllers/auxpaciente.dart';
import 'package:demo1/controllers/calendariocontroll.dart';

class VerPacientetres extends StatefulWidget {
  VerPacientetres({Key key}) : super(key: key);

  @override
  _VerPacientetresState createState() => _VerPacientetresState();
}

class _VerPacientetresState extends State<VerPacientetres> {
  final Usuario _usuario = new Usuario();

  Future<List> getData() async {
    final response =
        await http.post("http://192.168.1.27/demo1/verpacientes.php", body: {
      "IdMedico": _usuario.id.toString(),
    });
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
              appBar: AppBar(
          title: Text('Pacientes'),
        ),
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
                  builder: (BuildContext context) => new Perfil(
                        listaa: list,
                        auxx: i,
                      )),
            ),
            child: new Card(
              child: new ListTile(
                title: new Text(
                  list[i]['PrimerNombre'] + ' ' + list[i]['PrimerApellido'],
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

class Perfil extends StatefulWidget {
  List listaa;
  int auxx;
  Perfil({this.auxx, this.listaa});

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

    
    CalcularAlertas();
  }
   Future<List> CalcularAlertas() async {
    final response = await http
        .post("http://192.168.1.27/demo1/calcularalertas.php", body: {
      "IdPaciente": widget.listaa[widget.auxx]['IdPaciente'],
      //"DataIni": _splitter(_auxcalendar.tiempoxd.toString()),
      "DataIni": _splitter(_auxcalendar.listadias[6].toString()),
      "DataFin": _splitter(_auxcalendar.listadias[0].toString()),
    }); 
     var datauser = json.decode(response.body);
     print('alertas');
     print(datauser);
     setState(() {
       _auxcalendar.alertast=datauser.length;
     });
     print(datauser.length);
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
    String _splitter2(String _sfecha) {
    try {
      List a = (_sfecha.split(" "));
      String auxC = a[0];
      List b = (auxC.split("-"));
      String fecha = (b[0] + "," + b[1] + "," + b[2]).toString();
      //DateTime(b[0], b[1], b[2]);
      //_semana.add(DateTime(int.parse(b[0]), int.parse(b[1]), int.parse(b[2])));

      //<{'','',''}>
      // print(fecha);
      return auxC;
    } catch (e) {
      print(e);
    }
  }
//----------------------------------------------
      Future <List> _actualizardatos() async{
      
      final response = await http.post("http://192.168.1.27/demo1/editardatospaciente.php", body:{
      "Telefono":_phoneNumber,
      "Clave":_password,
      "Direccion":_direcciooon,
      "IdPaciente":widget.listaa[widget.auxx]['IdPaciente'],
      });
      Navigator.of(context).pop();    
    }
//----------------------------------------------

  Future<List> VerBitacorasemana() async {
    final response = await http
        .post("http://192.168.1.27/demo1/verbitacorasemana.php", body: {
      "IdPaciente": widget.listaa[widget.auxx]['IdPaciente'],
      //"DataIni": _splitter(_auxcalendar.tiempoxd.toString()),
      "DataIni": _splitter(_auxcalendar.listadias[6].toString()),
      "DataFin": _splitter(_auxcalendar.listadias[0].toString()),
    });

    var datauser = json.decode(response.body);
    print('no seeeeeeeeee');
    print(datauser);
    print('salir del rest');
    setState(() {
      _auxcalendar.bitacorast=datauser.length;
    });
    //-------------------------------------------------------------------------------------------------
    for (int i = 0; i < datauser.length; i++) {
      if (_splitter(datauser[i]['FechaHora']) ==
          _splitter(_auxcalendar.listadias[6].toString())) {
        setState(() {
          _auxcalendar.dia1 = true;
        });
        break;
      }else{
        setState(() {
          _auxcalendar.dia1 = false;
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
        break;
            }else{
        setState(() {
          _auxcalendar.dia2 = false;
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
        break;
            }else{
        setState(() {
          _auxcalendar.dia3 = false;
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
        break;
            }else{
        setState(() {
          _auxcalendar.dia4 = false;
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
        break;
            }else{
        setState(() {
          _auxcalendar.dia5 = false;
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
        break;
            }else{
        setState(() {
          _auxcalendar.dia6 = false;
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
        break;
            }else{
        setState(() {
          _auxcalendar.dia7 = false;
        });  
      }
    }
    //-------------------------------------------------------------------------------------------------
    if (datauser.length==0){
      setState(() {
        _auxcalendar.dia1 = false;
        _auxcalendar.dia2 = false;
        _auxcalendar.dia3 = false;
        _auxcalendar.dia4 = false;
        _auxcalendar.dia5 = false;
        _auxcalendar.dia6 = false;
        _auxcalendar.dia7 = false;
      });
    }
    Navigator.pushNamed(context, '/calendario');
    return json.decode(response.body);
  }

//----------------------------------------------

  TextEditingController _correo;
  TextEditingController _edad;
  TextEditingController _telefono;
  TextEditingController _direccion;
  TextEditingController _clave;
  bool _activar = false;
  String _password;
  String _phoneNumber;
  String _direcciooon;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Paciente _paciente = new Paciente();
  @override
  void initState() {
    _correo = new TextEditingController(text: "${widget.listaa[widget.auxx]['Correo']}");
    _direccion = new TextEditingController(text: "${widget.listaa[widget.auxx]['Direccion']}");
    _edad = new TextEditingController(text: "${_splitter2(widget.listaa[widget.auxx]['FechaN'])}");
    _telefono = new TextEditingController(text: "${widget.listaa[widget.auxx]['Telefono']}");
    _clave = new TextEditingController(text: "${widget.listaa[widget.auxx]['Clave']}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.listaa[widget.auxx]['Rut']}'),
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
                "${widget.listaa[widget.auxx]['PrimerNombre']} ${widget.listaa[widget.auxx]['SegundoNombre']} ${widget.listaa[widget.auxx]['PrimerApellido']} ${widget.listaa[widget.auxx]['SegundoApellido']}",
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
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                  "Rut: ${widget.listaa[widget.auxx]['Rut']}",
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(height: 30.0),
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
        ),
      ],
    );
  }

  Widget _botones(context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      _botonbitacora(),
      SizedBox(width: 25.0),
      _botoneditar(),
      SizedBox(width: 25.0),
      _botonalertas(),
      SizedBox(width: 25.0),
      _botoningresarbitacora(),
      SizedBox(width: 25.0),
      _botonvercalendario(),
      SizedBox(width: 30.0),
      _botonenviarmensaje()
    ]);
  }

  _cambiar() {
    if (_activar == false) {
      setState(() {
        _activar = true;
      });
    }
  }
  _veralertas(){
    setState(() {
      _paciente.idd=widget.listaa[widget.auxx]['IdPaciente'];
      _paciente.nombre=widget.listaa[widget.auxx]['PrimerNombre']+' '+widget.listaa[widget.auxx]['PrimerApellido'];
    });
    Navigator.popAndPushNamed(context, '/verunaalerta');
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
    Widget _botoningresarbitacora() {
    return RaisedButton(
      onPressed: () => Navigator.of(context).push(
              new MaterialPageRoute(
                  builder: (BuildContext context) => new ElegirFechav2(
                        list: widget.listaa,
                        index: widget.auxx,
                      ))),
      color: Colors.black.withOpacity(0.0),
      elevation: 0.0,
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[Icon(Icons.post_add_outlined ), Text("Ingresar bitacora")],
      ),
    );
  }
    Widget _botonvercalendario() {
    return RaisedButton(
      onPressed: () => {_agregarFechas()},
      color: Colors.black.withOpacity(0.0),
      elevation: 0.0,
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[Icon(Icons.calendar_today_outlined), Text("Ver Calendario")],
      ),
    );
  }
    Widget _botonenviarmensaje() {
    return RaisedButton(
      onPressed: () => Navigator.of(context).push(
              new MaterialPageRoute(
                  builder: (BuildContext context) => new FormScreennotifi(
                        list: widget.listaa,
                        index: widget.auxx,
                      ))),
      color: Colors.black.withOpacity(0.0),
      elevation: 0.0,
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[Icon(Icons.send_to_mobile), Text("Notificación")],
      ),
    );
  }

  Widget _botonbitacora() {
    return RaisedButton(
      onPressed: () => Navigator.of(context).push(
              new MaterialPageRoute(
                  builder: (BuildContext context) => new ElegirFecha(
                        lista2: widget.listaa,
                        auxx2: widget.auxx,
                      ))),
       // _agregarFechas();

      
      elevation: 0.0,
      color: Colors.black.withOpacity(0.0),
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[Icon(Icons.assignment), Text("Ver bitacoras")],
      ),
    );
  }

  Widget _botonalertas() {
    return RaisedButton( //verunaalerta
      onPressed: () => {_veralertas()},
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
        enabled: false,
        controller: _edad,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          icon: Icon(
            Icons.calendar_today_rounded,
            color: Colors.black,
          ),
          hintText: 'ejemplo@correo.com',
          labelText: 'Fecha de nacimiento',
        ),
      ),
    );
  }

  Widget _telefonoo() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        enabled: _activar,
        controller: _telefono,
             validator: (String value) {
        if (value.isEmpty) {
          return 'Numero de telefono requerido';
        }

        return null;
      },
      onSaved: (String value) {
        _phoneNumber = value;
      },
        
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          icon: Icon(
            Icons.phone_android_outlined,
            color: Colors.black,
          ),
          hintText: 'ejemplo@correo.com',
          labelText: 'Telefono',
        ),
        
      ),
    );
  }

  Widget _direccioon() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        enabled: _activar,
        controller: _direccion,
              validator: (String value) {
        if (value.isEmpty) {
          return 'Direccion requerida';
        }

        return null;
      },
      onSaved: (String value) {
        _direcciooon = value;
      },
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
      child: TextFormField(
        //keyboardType: TextInputType.visiblePassword,
        obscureText:true,
        enabled: _activar,
        controller: _clave,
        validator: (String value) {
        if (value.isEmpty) {
          return 'Contraseña requerida';
        }

        return null;
      },
      onSaved: (String value) {
        _password = value;
      },
        
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
     // onPressed: () => {_cambiar()},
                      onPressed: () {
                  if (!_formKey.currentState.validate()) {
                    return;
                  }

                  _formKey.currentState.save();

                  _actualizardatos();
                },
      color: Colors.grey.withOpacity(1.0),
      elevation: 0.0,
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[Text("guardar")],
      ),
    );
  }
}

//-------------------------------------------------------------
class ElegirFecha extends StatefulWidget {
  List lista2;
  int auxx2;

  ElegirFecha({this.lista2, this.auxx2});
  @override
  _ElegirFecha createState() => _ElegirFecha();
}

class _ElegirFecha extends State<ElegirFecha> {
  final BitacoraController _bitacora = new BitacoraController();
  final Paciente _paciente = new Paciente();
  String mensaje = '';
  String user = '';
  DateTime _dateTime = DateTime.now();
  // DateTime _dateTimeFin;
  String _splitter(String _sfecha) {
    try {
      List a = (_sfecha.split(" "));
      String auxC = a[0];
      List b = (auxC.split("-"));
      String fecha = (b[2] + "/" + b[1] + "/" + b[0]).toString();
      //<{'','',''}>
      print(fecha);
      return auxC;
    } catch (e) {
      print(e);
    }
  }

  Future<List> verBitacora() async {
    // final response = await http.post("http://192.168.1.27/demo1/verbitacora.php", body:{
    final response =
        await http.post("http://192.168.1.27/demo1/verbitacora.php", body: {
      "IdPaciente": widget.lista2[widget.auxx2]['IdPaciente'],
      "DataIni": _splitter(_dateTime.toString()),
    });
    var datauser = json.decode(response.body);
    print(datauser);

    if (datauser.length == 0) {
      setState(() {
        mensaje = "No se han ingresado bitacoras ese dia";
      });
    } else {
      setState(() {
        _paciente.idd = widget.lista2[widget.auxx2]['IdPaciente'];
        _bitacora.fechaaux = _splitter(_dateTime.toString());
      });

      Navigator.popAndPushNamed(context, '/elegirbitacoramedico');
    }

    return json.decode(response.body);
  }

  Future<List> edit() async {
    final response = await http
        .post("http://192.168.1.27/demo1/buscardatospaciente.php", body: {
      "IdPaciente": _paciente.idd,
    });
    var datauser = json.decode(response.body);

    if (datauser.length == 0) {
      setState(() {
        mensaje = "Error";
      });
    } else {
      setState(() {
        _paciente.clave = datauser[0]['Clave'];
        _paciente.numerodetelefono = datauser[0]['Telefono'];
        _paciente.direccion = datauser[0]['Direccion'];
        _paciente.nombre =
            'Nombre: ${datauser[0]['PrimerNombre']} ${datauser[0]['PrimerApellido']}';
      });
      Navigator.popAndPushNamed(context, '/editardatos');
    }
    return datauser;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                user = _paciente.idd = widget.lista2[widget.auxx2]['IdPaciente'];
                edit();
              },
            )
          ],
          title: Text('Ver Bitacora'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                  _dateTime.toString() == null
                      ? 'No se ha seleccionado una fecha'
                      : _splitter(_dateTime.toString()),
                  style: TextStyle(fontSize: 25.0)),
              RaisedButton(
                child: Text('Seleccionar fecha'),
                onPressed: () {
                  showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2001),
                          lastDate: DateTime(2022))
                      .then((date) {
                    print(date);
                    if (date == null) {
                      date = _dateTime;
                    } else {
                      setState(() {
                        _dateTime = date;
                      });
                    }
                  });
                },
              ),
              new RaisedButton(
                child: new Text("Ingresar"),
                color: Colors.orangeAccent,
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                onPressed: () {
                  verBitacora();
                },
              ),
              Text(
                mensaje,
                style: TextStyle(fontSize: 25.0, color: Colors.red),
              )
            ],
          ),
        ),
      ),
    );
  }
}


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
  //Funcion enviar notificacion personalizada
    void enviaralertaphp() {
    var url = "http://192.168.1.27/demo1/adalerta.php";

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
      appBar: AppBar(title: Text("Enviar notificacion personalizada")),
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
//--------------------------------------------------------------------------------------------------
class ElegirFechav2 extends StatefulWidget {
  List list;
  int index;
  
  ElegirFechav2({this.index,this.list});

  @override
  _ElegirFechav2 createState() => _ElegirFechav2();
}

class _ElegirFechav2 extends State<ElegirFechav2> {

  final BitacoraController _bitacora= new BitacoraController();
  final Paciente _paciente = new Paciente();

  String user='';
  String mensaje='';
  DateTime _dateTime= DateTime.now();
 // DateTime _dateTimeFin;
  String _splitter(String _sfecha) {
    try {
      List a = (_sfecha.split(" "));
      String auxC = a[0];
      List b = (auxC.split("-"));
      String fecha = (b[2] + "/" + b[1] + "/" + b[0]).toString();
      //<{'','',''}>
      print(fecha);
      return auxC;
    } catch (e) {
      print(e);
    }
  }

      Future <List> regbitacora() async{
      
      final response = await http.post("http://192.168.1.27/demo1/regbitacora.php", body:{
      "IdPaciente":_paciente.idd,
      "DataIni":_splitter(_paciente.fechabitacora),
      });
      var datauser = json.decode(response.body);
      print('paso1');

      if(datauser.length < 3){
        print(datauser.length);
        Navigator.pushNamed(context, '/agregarbitacora');
      }else{
        print(datauser.length);
        print('paso3');
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Ya has ingresado bitacoras el dia de hoy.'),
            actions:<Widget>[
              
              RaisedButton(onPressed: (){
                Navigator.of(context).pop();
              },
               child: Text('Aceptar'))
            ],),
        );          
      }
    return datauser;
    }


  @override
  Widget build(BuildContext context) {
    return Container( 
      child: Scaffold(
        appBar: AppBar(
          
          title:Text('Seleccionar Fecha'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //Text(_dateTime == null ? 'No se ha seleccionado una fecha' : _dateTime.toString()),
              Text(_dateTime.toString()== null ? 'No se ha seleccionado una fecha':_splitter(_dateTime.toString()), style: TextStyle(fontSize: 25.0)),
              RaisedButton(
                child: Text('Selecciona una fecha para ingresar'),
                onPressed: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2001),
                    lastDate: DateTime(2022)
                  ).then((date) {
                    print(date);
                    if(date==null){
                      date = _dateTime;
                    }else{
                      setState(() {

                      _dateTime = date;
                      //date = _dateTime;
                    });

                    }
                    
                  });
                },
              ),
                    new RaisedButton( 
                     child: new Text("ingresar"),
                     color: Colors.orangeAccent,
                     shape: new RoundedRectangleBorder(
                       borderRadius: new BorderRadius.circular(30.0)
                     ),
                     onPressed:(){//widget.list[widget.index]['Titulo']
                       //user=_paciente.idd= list[i]['IdPaciente']; 
                       user=_paciente.idd= widget.list[widget.index]['IdPaciente']; 
                       _paciente.fechabitacora=(_dateTime).toString();
                       regbitacora();
                     },
                     ),
                     Text(mensaje,
                     style: TextStyle(fontSize: 25.0, color: Colors.red),)
            ],
          ),
        ),
      ),
    );
  }
}

//---------------------------------------------------------------------------------------------------------------
class Bitacora extends StatefulWidget {
  Bitacora({Key key}) : super(key: key);
  

  @override
  _BitacoraState createState() => _BitacoraState();
}

class _BitacoraState extends State<Bitacora> {
  
  
  
  void addData() {
    var url = "http://192.168.1.27/demo1/adbitacora.php";

    http.post(url, body: {
      "FechaHora": _paciente.fechabitacora,
      "Nauseas": _nauseas.toString(),
      "Vomitos": _vomito.toString(),
      "Diarrea":_diarrea.toString(),
      "Constipacion":_constipacion.toString(),
      "Dolor":_dolor.toString(),
      "Fatiga":_fatiga.toString(),
      "PerdidaApetito":_perdidaapetito.toString(),
      "Fiebre":_fiebre.toString(),
      "SintomasResfrio":_sintomaresfrio.toString(),
      "SintomasUnitarios":_sintomasunitarios.toString(),
      "ValorICG":_valoricg.toString(),
      "IdPaciente":_paciente.idd,
    });
  }

  
  final PageController control = PageController();
  int _nauseas= 0;
  int _vomito=0;
  int _diarrea=0;
  int _constipacion=0;
  int _dolor=0;
  int _fatiga=0;
  int _perdidaapetito=0;
  double _fiebre=37.0; 
  int _sintomaresfrio=0;
  int _sintomasunitarios=0;
  int _valoricg=0;
  DateTime now= new DateTime.now();
  
  final Paciente _paciente = new Paciente();
  void printear(){
      String usuario= _paciente.idd;
      
      print (now);
      print (usuario);
      print (_nauseas);
      print (_vomito);
      print (_diarrea);
      print (_constipacion);
      print (_dolor);
      print (_fatiga);
      print (_perdidaapetito);
      print (_fiebre); 
      print (_sintomaresfrio);
      print (_sintomasunitarios);
      print (_valoricg);
  }
//---------nauseas------------------------------------
  void incrementarnauseas() {
    setState(() {
      if (_nauseas<5) {
        _nauseas++;
      }
      if (_nauseas==5) {
        setState((){_nauseas=4;},);
        showDialog(
          context: context,         
          builder: (context) => AlertDialog(
            title: Text('No se puede incrementar más'),
            actions:<Widget>[
              FlatButton(onPressed: (){
                Navigator.of(context).pop();
              },
               child: Text('Aceptar'))
            ],),
        );      
      }      
    });
    
  } 
  void disminuirnauseas() {
    setState(() {
      if (_nauseas>-1) {
        _nauseas--;
      }
      if (_nauseas<=-1) {
        setState((){_nauseas=0;},);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('No se puede disminuir más'),
            actions:<Widget>[
              
              RaisedButton(onPressed: (){
                Navigator.of(context).pop();
              },
               child: Text('Aceptar'))
            ],),
        );      
      }      
    }); }
//---------vomito------------------------------------
  void incrementarvomito() {
    setState(() {
      if (_vomito<5) {
        _vomito++;
      }
      if (_vomito==5) {
        setState((){_vomito=4;},);
        showDialog(
          context: context,         
          builder: (context) => AlertDialog(
            title: Text('No se puede incrementar más'),
            actions:<Widget>[
              FlatButton(onPressed: (){
                Navigator.of(context).pop();
              },
               child: Text('Aceptar'))
            ],),
        );      
      }      
    });
    
  } 
  void disminuirvomito() {
    setState(() {
      if (_vomito>-1) {
        _vomito--;
      }
      if (_vomito<=-1) {
        setState((){_vomito=0;},);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('No se puede disminuir más'),
            actions:<Widget>[
              
              RaisedButton(onPressed: (){
                Navigator.of(context).pop();
              },
               child: Text('Aceptar'))
            ],),
        );      
      }      
    });
    }  
//---------diarrea------------------------------------
  void incrementardiarrea() {
    setState(() {
      if (_diarrea<5) {
        _diarrea++;
      }
      if (_diarrea==5) {
        setState((){_diarrea=4;},);
        showDialog(
          context: context,         
          builder: (context) => AlertDialog(
            title: Text('No se puede incrementar más'),
            actions:<Widget>[
              FlatButton(onPressed: (){
                Navigator.of(context).pop();
              },
               child: Text('Aceptar'))
            ],),
        );      
      }      
    });
    
  } 
  void disminuirdiarrea() {
    setState(() {
      if (_diarrea>-1) {
        _diarrea--;
      }
      if (_diarrea<=-1) {
        setState((){_diarrea=0;},);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('No se puede disminuir más'),
            actions:<Widget>[
              
              RaisedButton(onPressed: (){
                Navigator.of(context).pop();
              },
               child: Text('Aceptar'))
            ],),
        );      
      }      
    }); } 
//---------constipacion------------------------------------
  void incrementarconstipacion() {
    setState(() {
      if (_constipacion<5) {
        _constipacion++;
      }
      if (_constipacion==5) {
        setState((){_constipacion=4;},);
        showDialog(
          context: context,         
          builder: (context) => AlertDialog(
            title: Text('No se puede incrementar más'),
            actions:<Widget>[
              FlatButton(onPressed: (){
                Navigator.of(context).pop();
              },
               child: Text('Aceptar'))
            ],),
        );      
      }      
    });
    
  } 
  void disminuirconstipacion() {
    setState(() {
      if (_constipacion>-1) {
        _constipacion--;
      }
      if (_constipacion<=-1) {
        setState((){_constipacion=0;},);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('No se puede disminuir más'),
            actions:<Widget>[
              
              RaisedButton(onPressed: (){
                Navigator.of(context).pop();
              },
               child: Text('Aceptar'))
            ],),
        );      
      }      
    }); 
  } 
//---------dolor--------------------
  void incrementardolor() {
    setState(() {
      if (_dolor<5) {
        _dolor++;
      }
      if (_dolor==5) {
        setState((){_dolor=4;},);
        showDialog(
          context: context,         
          builder: (context) => AlertDialog(
            title: Text('No se puede incrementar más'),
            actions:<Widget>[
              FlatButton(onPressed: (){
                Navigator.of(context).pop();
              },
               child: Text('Aceptar'))
            ],),
        );      
      }      
    });
    
  } 
  void disminuirdolor() {
    setState(() {
      if (_dolor>-1) {
        _dolor--;
      }
      if (_dolor<=-1) {
        setState((){_dolor=0;},);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('No se puede disminuir más'),
            actions:<Widget>[
              
              RaisedButton(onPressed: (){
                Navigator.of(context).pop();
              },
               child: Text('Aceptar'))
            ],),
        );      
      }      
    }); 
  } 
//---------fatiga--------------------
  void incrementarfatiga() {
    setState(() {
      if (_fatiga<5) {
        _fatiga++;
      }
      if (_fatiga==5) {
        setState((){_fatiga=4;},);
        showDialog(
          context: context,         
          builder: (context) => AlertDialog(
            title: Text('No se puede incrementar más'),
            actions:<Widget>[
              FlatButton(onPressed: (){
                Navigator.of(context).pop();
              },
               child: Text('Aceptar'))
            ],),
        );      
      }      
    });
    
  } 
  void disminuirfatiga() {
    setState(() {
      if (_fatiga>-1) {
        _fatiga--;
      }
      if (_fatiga<=-1) {
        setState((){_fatiga=0;},);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('No se puede disminuir más'),
            actions:<Widget>[
              
              RaisedButton(onPressed: (){
                Navigator.of(context).pop();
              },
               child: Text('Aceptar'))
            ],),
        );      
      }      
    }); 
  } 
//---------perdidaapetito--------------------
  void incrementarperdidaapetito() {
    setState(() {
      if (_perdidaapetito<5) {
        _perdidaapetito++;
      }
      if (_perdidaapetito==5) {
        setState((){_perdidaapetito=4;},);
        showDialog(
          context: context,         
          builder: (context) => AlertDialog(
            title: Text('No se puede incrementar más'),
            actions:<Widget>[
              FlatButton(onPressed: (){
                Navigator.of(context).pop();
              },
               child: Text('Aceptar'))
            ],),
        );      
      }      
    });
    
  } 
  void disminuirperdidaapetito() {
    setState(() {
      if (_perdidaapetito>-1) {
        _perdidaapetito--;
      }
      if (_perdidaapetito<=-1) {
        setState((){_perdidaapetito=0;},);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('No se puede disminuir más'),
            actions:<Widget>[
              
              RaisedButton(onPressed: (){
                Navigator.of(context).pop();
              },
               child: Text('Aceptar'))
            ],),
        );      
      }      
    }); 
  } 
//--------------fiebre-----------------------
  void incrementarfiebre() {
    setState(() {
      
      if (_fiebre<55.1) {
        _fiebre= _fiebre+0.1;
      }
      if (_fiebre>55) {
        setState((){_fiebre=55;},);
        showDialog(
          context: context,         
          builder: (context) => AlertDialog(
            title: Text('No se puede incrementar más'),
            actions:<Widget>[
              FlatButton(onPressed: (){
                Navigator.of(context).pop();
              },
               child: Text('Aceptar'))
            ],),
        );      
      }      
    });
    
  } 
  void disminuirfiebre() {
    setState(() {
      if (_fiebre>29.9) {
        _fiebre=_fiebre-0.1;
      }
      if (_fiebre<=29.9) {
        setState((){_fiebre=30;},);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('No se puede disminuir más'),
            actions:<Widget>[
              
              RaisedButton(onPressed: (){
                Navigator.of(context).pop();
              },
               child: Text('Aceptar'))
            ],),
        );      
      }      
    }); 
  } 
//---------sintomaderesfrio--------------------
  void incrementarsintomaresfrio() {
    setState(() {
      if (_sintomaresfrio<5) {
        _sintomaresfrio++;
      }
      if (_sintomaresfrio==5) {
        setState((){_sintomaresfrio=4;},);
        showDialog(
          context: context,         
          builder: (context) => AlertDialog(
            title: Text('No se puede incrementar más'),
            actions:<Widget>[
              FlatButton(onPressed: (){
                Navigator.of(context).pop();
              },
               child: Text('Aceptar'))
            ],),
        );      
      }      
    });
    
  } 
  void disminuirsintomaresfrio() {
    setState(() {
      if (_sintomaresfrio>-1) {
        _sintomaresfrio--;
      }
      if (_sintomaresfrio<=-1) {
        setState((){_sintomaresfrio=0;},);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('No se puede disminuir más'),
            actions:<Widget>[
              
              RaisedButton(onPressed: (){
                Navigator.of(context).pop();
              },
               child: Text('Aceptar'))
            ],),
        );      
      }      
    }); 
  } 
  //---------sintomasunitarios--------------------
  void incrementarsintomasunitarios() {
    setState(() {
      if (_sintomasunitarios<5) {
        _sintomasunitarios++;
      }
      if (_sintomasunitarios==5) {
        setState((){_sintomasunitarios=4;},);
        showDialog(
          context: context,         
          builder: (context) => AlertDialog(
            title: Text('No se puede incrementar más'),
            actions:<Widget>[
              FlatButton(onPressed: (){
                Navigator.of(context).pop();
              },
               child: Text('Aceptar'))
            ],),
        );      
      }      
    });
    
  } 
  void disminuirsintomasunitarios() {
    setState(() {
      if (_sintomasunitarios>-1) {
        _sintomasunitarios--;
      }
      if (_sintomasunitarios<=-1) {
        setState((){_sintomasunitarios=0;},);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('No se puede disminuir más'),
            actions:<Widget>[
              
              RaisedButton(onPressed: (){
                Navigator.of(context).pop();
              },
               child: Text('Aceptar'))
            ],),
        );      
      }      
    }); 
  } 
  //---------valoricg--------------------
  void incrementarvaloricg() {
    setState(() {
      if (_valoricg<5) {
        _valoricg++;
      }
      if (_valoricg==5) {
        setState((){_valoricg=4;},);
        showDialog(
          context: context,         
          builder: (context) => AlertDialog(
            title: Text('No se puede incrementar más'),
            actions:<Widget>[
              FlatButton(onPressed: (){
                Navigator.of(context).pop();
              },
               child: Text('Aceptar'))
            ],),
        );      
      }      
    });
    
  } 
  void disminuirvaloricg() {
    setState(() {
      if (_valoricg>-1) {
        _valoricg--;
      }
      if (_valoricg<=-1) {
        setState((){_valoricg=0;},);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('No se puede disminuir más'),
            actions:<Widget>[
              
              RaisedButton(onPressed: (){
                Navigator.of(context).pop();
              },
               child: Text('Aceptar'))
            ],),
        );      
      }      
    }); 
  } 

  //cierre
  @override
  Widget build(BuildContext context) {
    String fiebre=_fiebre.toStringAsFixed(1);
    return Scaffold(
        body: new PageView(
          scrollDirection: Axis.horizontal,
          controller: control,
          children: [
//---------nauseas------------------------------------
            new Container(
              child: Scaffold(
                appBar: AppBar(
                  title: Text('Registrar bitacora'),
                ),
                body: Container(
                  padding: EdgeInsets.only(
                    top: 70,
                    bottom: 0,
                    right: 10,
                    left: 10
                  ),
                  child: Column(         
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(                  
                            child: Text('¿Qué valor asignaría en relación \n a las Nauseas en este momento?\n',                 
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              )
                            ),
                          )
                        ],             
                      ),
                     Row(
                      children: [
                        Text('\n')],
                     ),
                         
                    Table(
                    border: TableBorder.all(),
                    columnWidths: {
                    0:FractionColumnWidth(.15),
                    1:FractionColumnWidth(.25),
                    2:FractionColumnWidth(.15),
                    3:FractionColumnWidth(.2),
                    4:FractionColumnWidth(.2),
                    },
                
              
              children: [            
                TableRow(children: [
                  TableCell(child: Container (color: Colors.green[300], child: Center(child: Text('Nada',style: TextStyle(color: Colors.black,fontSize: 18),))),),
                  TableCell(child: Container (color: Colors.purple[300], child: Center(child: Text('Muy poco',style: TextStyle(color: Colors.black,fontSize: 18),))),),
                  TableCell(child: Container (color: Colors.orange[300], child: Center(child: Text('Poco',style: TextStyle(color: Colors.black,fontSize: 18),))),),
                  TableCell(child: Container (color: Colors.pink[300], child: Center(child: Text('Bastante',style: TextStyle(color: Colors.black,fontSize: 18),))),), 
                  TableCell(child: Container (color: Colors.red[200], child: Center(child: Text('Severo',style: TextStyle(color: Colors.black,fontSize: 18),))),),             
                ]),
                TableRow(children: [
                  TableCell(
                    child: Center(child: Text('0',style: TextStyle(color: Colors.black,fontSize: 18),)),
                    verticalAlignment: TableCellVerticalAlignment.bottom,
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Center(child: Text('1',style: TextStyle(color: Colors.black,fontSize: 18),)),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Center(child: Text('2',style: TextStyle(color: Colors.black,fontSize: 18),)),
                  ),
                  TableCell(
                    child: Center(child: Text('3',style: TextStyle(color: Colors.black,fontSize: 18),)),
                    verticalAlignment: TableCellVerticalAlignment.top,
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Center(child: Text('4',style: TextStyle(color: Colors.black,fontSize: 18),)),
                  ),
            ]),
            ],), 
            Row(
              children: [
                Text('\n')
            ],),                                 
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  margin: EdgeInsets.fromLTRB(90.0, 16.0, 16.0, 16.0),      
                  child :Text('$_nauseas ',style: Theme.of(context).textTheme.headline4,),  
                ),
                Card(
                  child: Column(
                    children:<Widget> [
                      RaisedButton(onPressed: incrementarnauseas ,
                      child: Icon(Icons.expand_less), ),
                      RaisedButton(onPressed: disminuirnauseas,
                      child: Icon(Icons.expand_more), )
                    ],
                  ),
                )
              ]
            ),
            Row(
              children: [
                Text('\n'),
              ],
            ), 
            Row(
              children: [
                Text('\n'),
              ],
            ), 
            Row(
              children: [
                Text('\n'),
              ],
            ), 
            Row(
              children: [
                Text('\n'),
              ],
            ), 
          ],
        ),
      ), 
    ),
            ),
//---------vomito------------------------------------
            new Container(child: Scaffold(
                appBar: AppBar(
                  title: Text('Registrar bitacora'),
                ),
                body: Container(
                  padding: EdgeInsets.only(
                    top: 70,
                    bottom: 0,
                    right: 10,
                    left: 10
                  ),
                  child: Column(         
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(                  
                            child: Text('¿Qué valor asignaría en relación \n a las Vomitos en este momento?\n',                 
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              )
                            ),
                          )
                        ],             
                      ),
                     Row(
                      children: [
                        Text('\n')],
                     ),
                         
                    Table(
                    border: TableBorder.all(),
                    columnWidths: {
                    0:FractionColumnWidth(.15),
                    1:FractionColumnWidth(.25),
                    2:FractionColumnWidth(.15),
                    3:FractionColumnWidth(.2),
                    4:FractionColumnWidth(.2),
                    },
                
              
              children: [            
                TableRow(children: [
                  TableCell(child: Container (color: Colors.green[300], child: Center(child: Text('Nada',style: TextStyle(color: Colors.black,fontSize: 18),))),),
                  TableCell(child: Container (color: Colors.purple[300], child: Center(child: Text('Muy poco',style: TextStyle(color: Colors.black,fontSize: 18),))),),
                  TableCell(child: Container (color: Colors.orange[300], child: Center(child: Text('Poco',style: TextStyle(color: Colors.black,fontSize: 18),))),),
                  TableCell(child: Container (color: Colors.pink[300], child: Center(child: Text('Bastante',style: TextStyle(color: Colors.black,fontSize: 18),))),), 
                  TableCell(child: Container (color: Colors.red[200], child: Center(child: Text('Severo',style: TextStyle(color: Colors.black,fontSize: 18),))),),             
                ]),
                TableRow(children: [
                  TableCell(
                    child: Center(child: Text('0',style: TextStyle(color: Colors.black,fontSize: 18),)),
                    verticalAlignment: TableCellVerticalAlignment.bottom,
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Center(child: Text('1',style: TextStyle(color: Colors.black,fontSize: 18),)),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Center(child: Text('2',style: TextStyle(color: Colors.black,fontSize: 18),)),
                  ),
                  TableCell(
                    child: Center(child: Text('3',style: TextStyle(color: Colors.black,fontSize: 18),)),
                    verticalAlignment: TableCellVerticalAlignment.top,
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Center(child: Text('4',style: TextStyle(color: Colors.black,fontSize: 18),)),
                  ),
            ]),
            ],), 
            Row(
              children: [
                Text('\n')
            ],),                                 
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  margin: EdgeInsets.fromLTRB(90.0, 16.0, 16.0, 16.0),      
                  child :Text('$_vomito ',style: Theme.of(context).textTheme.headline4,),  
                ),
                Card(
                  child: Column(
                    children:<Widget> [
                      RaisedButton(onPressed: incrementarvomito  ,
                      child: Icon(Icons.expand_less), ),
                      RaisedButton(onPressed: disminuirvomito,
                      child: Icon(Icons.expand_more), )
                    ],
                  ),
                )
              ]
            ),
            Row(
              children: [
                Text('\n'),
              ],
            ), 
            Row(
              children: [
                Text('\n'),
              ],
            ), 
            Row(
              children: [
                Text('\n'),
              ],
            ), 
            Row(
              children: [
                Text('\n'),
              ],
            ), 
          ],
        ),
      ), 
    ),),
//---------diarrea------------------------------------
            new Container(child: Scaffold(
                appBar: AppBar(
                  title: Text('Registrar bitacora'),
                ),
                body: Container(
                  padding: EdgeInsets.only(
                    top: 70,
                    bottom: 0,
                    right: 10,
                    left: 10
                  ),
                  child: Column(         
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(                  
                            child: Text('¿Qué valor asignaría en relación \n a las Diarrea en este momento?\n',                 
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              )
                            ),
                          )
                        ],             
                      ),
                     Row(
                      children: [
                        Text('\n')],
                     ),
                         
                    Table(
                    border: TableBorder.all(),
                    columnWidths: {
                    0:FractionColumnWidth(.15),
                    1:FractionColumnWidth(.25),
                    2:FractionColumnWidth(.15),
                    3:FractionColumnWidth(.2),
                    4:FractionColumnWidth(.2),
                    },
                
              
              children: [            
                TableRow(children: [
                  TableCell(child: Container (color: Colors.green[300], child: Center(child: Text('Nada',style: TextStyle(color: Colors.black,fontSize: 18),))),),
                  TableCell(child: Container (color: Colors.purple[300], child: Center(child: Text('Muy poco',style: TextStyle(color: Colors.black,fontSize: 18),))),),
                  TableCell(child: Container (color: Colors.orange[300], child: Center(child: Text('Poco',style: TextStyle(color: Colors.black,fontSize: 18),))),),
                  TableCell(child: Container (color: Colors.pink[300], child: Center(child: Text('Bastante',style: TextStyle(color: Colors.black,fontSize: 18),))),), 
                  TableCell(child: Container (color: Colors.red[200], child: Center(child: Text('Severo',style: TextStyle(color: Colors.black,fontSize: 18),))),),             
                ]),
                TableRow(children: [
                  TableCell(
                    child: Center(child: Text('0',style: TextStyle(color: Colors.black,fontSize: 18),)),
                    verticalAlignment: TableCellVerticalAlignment.bottom,
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Center(child: Text('1',style: TextStyle(color: Colors.black,fontSize: 18),)),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Center(child: Text('2',style: TextStyle(color: Colors.black,fontSize: 18),)),
                  ),
                  TableCell(
                    child: Center(child: Text('3',style: TextStyle(color: Colors.black,fontSize: 18),)),
                    verticalAlignment: TableCellVerticalAlignment.top,
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Center(child: Text('4',style: TextStyle(color: Colors.black,fontSize: 18),)),
                  ),
            ]),
            ],), 
            Row(
              children: [
                Text('\n')
            ],),                                 
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  margin: EdgeInsets.fromLTRB(90.0, 16.0, 16.0, 16.0),      
                  child :Text('$_diarrea ',style: Theme.of(context).textTheme.headline4,),  
                ),
                Card(
                  child: Column(
                    children:<Widget> [
                      RaisedButton(onPressed: incrementardiarrea  ,
                      child: Icon(Icons.expand_less), ),
                      RaisedButton(onPressed: disminuirdiarrea,
                      child: Icon(Icons.expand_more), )
                    ],
                  ),
                )
              ]
            ),
            Row(
              children: [
                Text('\n'),
              ],
            ), 
            Row(
              children: [
                Text('\n'),
              ],
            ), 
            Row(
              children: [
                Text('\n'),
              ],
            ), 
            Row(
              children: [
                Text('\n'),
              ],
            ), 
          ],
        ),
      ), 
    ),),
//---------constipacion------------------------------------
            new Container(child: Scaffold(
                appBar: AppBar(
                  title: Text('Registrar bitacora'),
                ),
                body: Container(
                  padding: EdgeInsets.only(
                    top: 70,
                    bottom: 0,
                    right: 10,
                    left: 10
                  ),
                  child: Column(         
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(                  
                            child: Text('¿Qué valor asignaría en relación \n a las Constipacion en este momento?\n',                 
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              )
                            ),
                          )
                        ],             
                      ),
                     Row(
                      children: [
                        Text('\n')],
                     ),
                         
                    Table(
                    border: TableBorder.all(),
                    columnWidths: {
                    0:FractionColumnWidth(.15),
                    1:FractionColumnWidth(.25),
                    2:FractionColumnWidth(.15),
                    3:FractionColumnWidth(.2),
                    4:FractionColumnWidth(.2),
                    },
                
              
              children: [            
                TableRow(children: [
                  TableCell(child: Container (color: Colors.green[300], child: Center(child: Text('Nada',style: TextStyle(color: Colors.black,fontSize: 18),))),),
                  TableCell(child: Container (color: Colors.purple[300], child: Center(child: Text('Muy poco',style: TextStyle(color: Colors.black,fontSize: 18),))),),
                  TableCell(child: Container (color: Colors.orange[300], child: Center(child: Text('Poco',style: TextStyle(color: Colors.black,fontSize: 18),))),),
                  TableCell(child: Container (color: Colors.pink[300], child: Center(child: Text('Bastante',style: TextStyle(color: Colors.black,fontSize: 18),))),), 
                  TableCell(child: Container (color: Colors.red[200], child: Center(child: Text('Severo',style: TextStyle(color: Colors.black,fontSize: 18),))),),             
                ]),
                TableRow(children: [
                  TableCell(
                    child: Center(child: Text('0',style: TextStyle(color: Colors.black,fontSize: 18),)),
                    verticalAlignment: TableCellVerticalAlignment.bottom,
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Center(child: Text('1',style: TextStyle(color: Colors.black,fontSize: 18),)),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Center(child: Text('2',style: TextStyle(color: Colors.black,fontSize: 18),)),
                  ),
                  TableCell(
                    child: Center(child: Text('3',style: TextStyle(color: Colors.black,fontSize: 18),)),
                    verticalAlignment: TableCellVerticalAlignment.top,
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Center(child: Text('4',style: TextStyle(color: Colors.black,fontSize: 18),)),
                  ),
            ]),
            ],), 
            Row(
              children: [
                Text('\n')
            ],),                                 
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  margin: EdgeInsets.fromLTRB(90.0, 16.0, 16.0, 16.0),      
                  child :Text('$_constipacion ',style: Theme.of(context).textTheme.headline4,),  
                ),
                Card(
                  child: Column(
                    children:<Widget> [
                      RaisedButton(onPressed: incrementarconstipacion  ,
                      child: Icon(Icons.expand_less), ),
                      RaisedButton(onPressed: disminuirconstipacion,
                      child: Icon(Icons.expand_more), )
                    ],
                  ),
                )
              ]
            ),
            Row(
              children: [
                Text('\n'),
              ],
            ), 
            Row(
              children: [
                Text('\n'),
              ],
            ), 
            Row(
              children: [
                Text('\n'),
              ],
            ), 
            Row(
              children: [
                Text('\n'),
              ],
            ), 
          ],
        ),
      ), 
    ),),
//----------dolor----------   
            new Container(child: Scaffold(
                appBar: AppBar(
                  title: Text('Registrar bitacora'),
                ),
                body: Container(
                  padding: EdgeInsets.only(
                    top: 70,
                    bottom: 0,
                    right: 10,
                    left: 10
                  ),
                  child: Column(         
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(                  
                            child: Text('¿Qué valor asignaría en relación \n a las Dolor en este momento?\n',                 
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              )
                            ),
                          )
                        ],             
                      ),
                     Row(
                      children: [
                        Text('\n')],
                     ),
                         
                    Table(
                    border: TableBorder.all(),
                    columnWidths: {
                    0:FractionColumnWidth(.15),
                    1:FractionColumnWidth(.25),
                    2:FractionColumnWidth(.15),
                    3:FractionColumnWidth(.2),
                    4:FractionColumnWidth(.2),
                    },
                
              
              children: [            
                TableRow(children: [
                  TableCell(child: Container (color: Colors.green[300], child: Center(child: Text('Nada',style: TextStyle(color: Colors.black,fontSize: 18),))),),
                  TableCell(child: Container (color: Colors.purple[300], child: Center(child: Text('Muy poco',style: TextStyle(color: Colors.black,fontSize: 18),))),),
                  TableCell(child: Container (color: Colors.orange[300], child: Center(child: Text('Poco',style: TextStyle(color: Colors.black,fontSize: 18),))),),
                  TableCell(child: Container (color: Colors.pink[300], child: Center(child: Text('Bastante',style: TextStyle(color: Colors.black,fontSize: 18),))),), 
                  TableCell(child: Container (color: Colors.red[200], child: Center(child: Text('Severo',style: TextStyle(color: Colors.black,fontSize: 18),))),),             
                ]),
                TableRow(children: [
                  TableCell(
                    child: Center(child: Text('0',style: TextStyle(color: Colors.black,fontSize: 18),)),
                    verticalAlignment: TableCellVerticalAlignment.bottom,
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Center(child: Text('1',style: TextStyle(color: Colors.black,fontSize: 18),)),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Center(child: Text('2',style: TextStyle(color: Colors.black,fontSize: 18),)),
                  ),
                  TableCell(
                    child: Center(child: Text('3',style: TextStyle(color: Colors.black,fontSize: 18),)),
                    verticalAlignment: TableCellVerticalAlignment.top,
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Center(child: Text('4',style: TextStyle(color: Colors.black,fontSize: 18),)),
                  ),
            ]),
            ],), 
            Row(
              children: [
                Text('\n')
            ],),                                 
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  margin: EdgeInsets.fromLTRB(90.0, 16.0, 16.0, 16.0),      
                  child :Text('$_dolor ',style: Theme.of(context).textTheme.headline4,),  
                ),
                Card(
                  child: Column(
                    children:<Widget> [
                      RaisedButton(onPressed: incrementardolor  ,
                      child: Icon(Icons.expand_less), ),
                      RaisedButton(onPressed: disminuirdolor,
                      child: Icon(Icons.expand_more), )
                    ],
                  ),
                )
              ]
            ),
            Row(
              children: [
                Text('\n'),
              ],
            ), 
            Row(
              children: [
                Text('\n'),
              ],
            ), 
            Row(
              children: [
                Text('\n'),
              ],
            ), 
            Row(
              children: [
                Text('\n'),
              ],
            ), 
          ],
        ),
      ), 
    ),),
//--------------fatiga-----------------
            new Container(child: Scaffold(
                appBar: AppBar(
                  title: Text('Registrar bitacora'),
                ),
                body: Container(
                  padding: EdgeInsets.only(
                    top: 70,
                    bottom: 0,
                    right: 10,
                    left: 10
                  ),
                  child: Column(         
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(                  
                            child: Text('¿Qué valor asignaría en relación \n a las Fatiga en este momento?\n',                 
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              )
                            ),
                          )
                        ],             
                      ),
                     Row(
                      children: [
                        Text('\n')],
                     ),
                         
                    Table(
                    border: TableBorder.all(),
                    columnWidths: {
                    0:FractionColumnWidth(.15),
                    1:FractionColumnWidth(.25),
                    2:FractionColumnWidth(.15),
                    3:FractionColumnWidth(.2),
                    4:FractionColumnWidth(.2),
                    },
                
              
              children: [            
                TableRow(children: [
                  TableCell(child: Container (color: Colors.green[300], child: Center(child: Text('Nada',style: TextStyle(color: Colors.black,fontSize: 18),))),),
                  TableCell(child: Container (color: Colors.purple[300], child: Center(child: Text('Muy poco',style: TextStyle(color: Colors.black,fontSize: 18),))),),
                  TableCell(child: Container (color: Colors.orange[300], child: Center(child: Text('Poco',style: TextStyle(color: Colors.black,fontSize: 18),))),),
                  TableCell(child: Container (color: Colors.pink[300], child: Center(child: Text('Bastante',style: TextStyle(color: Colors.black,fontSize: 18),))),), 
                  TableCell(child: Container (color: Colors.red[200], child: Center(child: Text('Severo',style: TextStyle(color: Colors.black,fontSize: 18),))),),             
                ]),
                TableRow(children: [
                  TableCell(
                    child: Center(child: Text('0',style: TextStyle(color: Colors.black,fontSize: 18),)),
                    verticalAlignment: TableCellVerticalAlignment.bottom,
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Center(child: Text('1',style: TextStyle(color: Colors.black,fontSize: 18),)),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Center(child: Text('2',style: TextStyle(color: Colors.black,fontSize: 18),)),
                  ),
                  TableCell(
                    child: Center(child: Text('3',style: TextStyle(color: Colors.black,fontSize: 18),)),
                    verticalAlignment: TableCellVerticalAlignment.top,
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Center(child: Text('4',style: TextStyle(color: Colors.black,fontSize: 18),)),
                  ),
            ]),
            ],), 
            Row(
              children: [
                Text('\n')
            ],),                                 
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  margin: EdgeInsets.fromLTRB(90.0, 16.0, 16.0, 16.0),      
                  child :Text('$_fatiga ',style: Theme.of(context).textTheme.headline4,),  
                ),
                Card(
                  child: Column(
                    children:<Widget> [
                      RaisedButton(onPressed: incrementarfatiga  ,
                      child: Icon(Icons.expand_less), ),
                      RaisedButton(onPressed: disminuirfatiga,
                      child: Icon(Icons.expand_more), )
                    ],
                  ),
                )
              ]
            ),
            Row(
              children: [
                Text('\n'),
              ],
            ), 
            Row(
              children: [
                Text('\n'),
              ],
            ), 
            Row(
              children: [
                Text('\n'),
              ],
            ), 
            Row(
              children: [
                Text('\n'),
              ],
            ), 
          ],
        ),
      ), 
    ),),
//--------------perdidaapetito-----------------    
            new Container(child: Scaffold(
                appBar: AppBar(
                  title: Text('Registrar bitacora'),
                ),
                body: Container(
                  padding: EdgeInsets.only(
                    top: 70,
                    bottom: 0,
                    right: 10,
                    left: 10
                  ),
                  child: Column(         
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(                  
                            child: Text('¿Qué valor asignaría en relación \n a las Perdida de apetito en este momento?\n',                 
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              )
                            ),
                          )
                        ],             
                      ),
                     Row(
                      children: [
                        Text('\n')],
                     ),
                         
                    Table(
                    border: TableBorder.all(),
                    columnWidths: {
                    0:FractionColumnWidth(.15),
                    1:FractionColumnWidth(.25),
                    2:FractionColumnWidth(.15),
                    3:FractionColumnWidth(.2),
                    4:FractionColumnWidth(.2),
                    },
                
              
              children: [            
                TableRow(children: [
                  TableCell(child: Container (color: Colors.green[300], child: Center(child: Text('Nada',style: TextStyle(color: Colors.black,fontSize: 18),))),),
                  TableCell(child: Container (color: Colors.purple[300], child: Center(child: Text('Muy poco',style: TextStyle(color: Colors.black,fontSize: 18),))),),
                  TableCell(child: Container (color: Colors.orange[300], child: Center(child: Text('Poco',style: TextStyle(color: Colors.black,fontSize: 18),))),),
                  TableCell(child: Container (color: Colors.pink[300], child: Center(child: Text('Bastante',style: TextStyle(color: Colors.black,fontSize: 18),))),), 
                  TableCell(child: Container (color: Colors.red[200], child: Center(child: Text('Severo',style: TextStyle(color: Colors.black,fontSize: 18),))),),             
                ]),
                TableRow(children: [
                  TableCell(
                    child: Center(child: Text('0',style: TextStyle(color: Colors.black,fontSize: 18),)),
                    verticalAlignment: TableCellVerticalAlignment.bottom,
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Center(child: Text('1',style: TextStyle(color: Colors.black,fontSize: 18),)),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Center(child: Text('2',style: TextStyle(color: Colors.black,fontSize: 18),)),
                  ),
                  TableCell(
                    child: Center(child: Text('3',style: TextStyle(color: Colors.black,fontSize: 18),)),
                    verticalAlignment: TableCellVerticalAlignment.top,
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Center(child: Text('4',style: TextStyle(color: Colors.black,fontSize: 18),)),
                  ),
            ]),
            ],), 
            Row(
              children: [
                Text('\n')
            ],),                                 
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  margin: EdgeInsets.fromLTRB(90.0, 16.0, 16.0, 16.0),      
                  child :Text('$_perdidaapetito ',style: Theme.of(context).textTheme.headline4,),  
                ),
                Card(
                  child: Column(
                    children:<Widget> [
                      RaisedButton(onPressed: incrementarperdidaapetito  ,
                      child: Icon(Icons.expand_less), ),
                      RaisedButton(onPressed: disminuirperdidaapetito,
                      child: Icon(Icons.expand_more), )
                    ],
                  ),
                )
              ]
            ),
            Row(
              children: [
                Text('\n'),
              ],
            ), 
            Row(
              children: [
                Text('\n'),
              ],
            ), 
            Row(
              children: [
                Text('\n'),
              ],
            ), 
            Row(
              children: [
                Text('\n'),
              ],
            ), 
          ],
        ),
      ), 
    ),),
//--------------fiebre-----------------
            new Container(child: Scaffold(
                appBar: AppBar(
                  title: Text('Registrar bitacora'),
                ),
                body: Container(
                  padding: EdgeInsets.only(
                    top: 70,
                    bottom: 0,
                    right: 10,
                    left: 10
                  ),
                  child: Column(         
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(                  
                            child: Text('¿Qué valor asignaría en relación \n a las Fiebre en este momento?\n',                 
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              )
                            ),
                          )
                        ],             
                      ),
                     Row(
                      children: [
                        Text('\n')],
                     ),
                         
                    Table(
                    border: TableBorder.all(),
                    columnWidths: {
                    0:FractionColumnWidth(.15),
                    1:FractionColumnWidth(.25),
                    2:FractionColumnWidth(.15),
                    3:FractionColumnWidth(.2),
                    4:FractionColumnWidth(.2),
                    },
                
              
              children: [            
                TableRow(children: [
                  TableCell(child: Container (color: Colors.green[300], child: Center(child: Text('Nada',style: TextStyle(color: Colors.black,fontSize: 18),))),),
                  TableCell(child: Container (color: Colors.purple[300], child: Center(child: Text('Muy poco',style: TextStyle(color: Colors.black,fontSize: 18),))),),
                  TableCell(child: Container (color: Colors.orange[300], child: Center(child: Text('Poco',style: TextStyle(color: Colors.black,fontSize: 18),))),),
                  TableCell(child: Container (color: Colors.pink[300], child: Center(child: Text('Bastante',style: TextStyle(color: Colors.black,fontSize: 18),))),), 
                  TableCell(child: Container (color: Colors.red[200], child: Center(child: Text('Severo',style: TextStyle(color: Colors.black,fontSize: 18),))),),             
                ]),
                TableRow(children: [
                  TableCell(
                    child: Center(child: Text('0',style: TextStyle(color: Colors.black,fontSize: 18),)),
                    verticalAlignment: TableCellVerticalAlignment.bottom,
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Center(child: Text('1',style: TextStyle(color: Colors.black,fontSize: 18),)),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Center(child: Text('2',style: TextStyle(color: Colors.black,fontSize: 18),)),
                  ),
                  TableCell(
                    child: Center(child: Text('3',style: TextStyle(color: Colors.black,fontSize: 18),)),
                    verticalAlignment: TableCellVerticalAlignment.top,
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Center(child: Text('4',style: TextStyle(color: Colors.black,fontSize: 18),)),
                  ),
            ]),
            ],), 
            Row(
              children: [
                Text('\n')
            ],),                                 
            Row(
              
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  margin: EdgeInsets.fromLTRB(90.0, 16.0, 16.0, 16.0),  
                     
                  child :Text('$fiebre °C ',style: Theme.of(context).textTheme.headline4,),  
                  
                ),
                Card(
                  child: Column(
                    children:<Widget> [
                      RaisedButton(onPressed: incrementarfiebre  ,
                      child: Icon(Icons.expand_less), ),
                      RaisedButton(onPressed: disminuirfiebre,
                      child: Icon(Icons.expand_more), )
                    ],
                  ),
                )
              ]
            ),
            Row(
              children: [
                Text('\n'),
              ],
            ), 
            Row(
              children: [
                Text('\n'),
              ],
            ), 
            Row(
              children: [
                Text('\n'),
              ],
            ), 
            Row(
              children: [
                Text('\n'),
              ],
            ), 
          ],
        ),
      ), 
    ),),
//--------------sintomasresfrio-----------------
            new Container(child: Scaffold(
                appBar: AppBar(
                  title: Text('Registrar bitacora'),
                ),
                body: Container(
                  padding: EdgeInsets.only(
                    top: 70,
                    bottom: 0,
                    right: 10,
                    left: 10
                  ),
                  child: Column(         
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(                  
                            child: Text('¿Qué valor asignaría en relación \n a las Sintomas de Resfrio\n en este momento?\n',                 
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              )
                            ),
                          )
                        ],             
                      ),
                     Row(
                      children: [
                        Text('\n')],
                     ),
                         
                    Table(
                    border: TableBorder.all(),
                    columnWidths: {
                    0:FractionColumnWidth(.15),
                    1:FractionColumnWidth(.25),
                    2:FractionColumnWidth(.15),
                    3:FractionColumnWidth(.2),
                    4:FractionColumnWidth(.2),
                    },
                
              
              children: [            
                TableRow(children: [
                  TableCell(child: Container (color: Colors.green[300], child: Center(child: Text('Nada',style: TextStyle(color: Colors.black,fontSize: 18),))),),
                  TableCell(child: Container (color: Colors.purple[300], child: Center(child: Text('Muy poco',style: TextStyle(color: Colors.black,fontSize: 18),))),),
                  TableCell(child: Container (color: Colors.orange[300], child: Center(child: Text('Poco',style: TextStyle(color: Colors.black,fontSize: 18),))),),
                  TableCell(child: Container (color: Colors.pink[300], child: Center(child: Text('Bastante',style: TextStyle(color: Colors.black,fontSize: 18),))),), 
                  TableCell(child: Container (color: Colors.red[200], child: Center(child: Text('Severo',style: TextStyle(color: Colors.black,fontSize: 18),))),),             
                ]),
                TableRow(children: [
                  TableCell(
                    child: Center(child: Text('0',style: TextStyle(color: Colors.black,fontSize: 18),)),
                    verticalAlignment: TableCellVerticalAlignment.bottom,
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Center(child: Text('1',style: TextStyle(color: Colors.black,fontSize: 18),)),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Center(child: Text('2',style: TextStyle(color: Colors.black,fontSize: 18),)),
                  ),
                  TableCell(
                    child: Center(child: Text('3',style: TextStyle(color: Colors.black,fontSize: 18),)),
                    verticalAlignment: TableCellVerticalAlignment.top,
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Center(child: Text('4',style: TextStyle(color: Colors.black,fontSize: 18),)),
                  ),
            ]),
            ],), 
            Row(
              children: [
                Text('\n')
            ],),                                 
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  margin: EdgeInsets.fromLTRB(90.0, 16.0, 16.0, 16.0),      
                  child :Text('$_sintomaresfrio ',style: Theme.of(context).textTheme.headline4,),  
                ),
                Card(
                  child: Column(
                    children:<Widget> [
                      RaisedButton(onPressed: incrementarsintomaresfrio  ,
                      child: Icon(Icons.expand_less), ),
                      RaisedButton(onPressed: disminuirsintomaresfrio,
                      child: Icon(Icons.expand_more), )
                    ],
                  ),
                )
              ]
            ),
            Row(
              children: [
                Text('\n'),
              ],
            ), 
            Row(
              children: [
                Text('\n'),
              ],
            ), 
            Row(
              children: [
                Text('\n'),
              ],
            ), 
            Row(
              children: [
                Text('\n'),
              ],
            ), 
          ],
        ),
      ), 
    ),),
//--------------sintomasunitarios-----------------
          new Container(child: Scaffold(
                appBar: AppBar(
                  title: Text('Registrar bitacora'),
                ),
                body: Container(
                  padding: EdgeInsets.only(
                    top: 70,
                    bottom: 0,
                    right: 10,
                    left: 10
                  ),
                  child: Column(         
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(                  
                            child: Text('¿Qué valor asignaría en relación \n a las Sintomas Unitarios\n en este momento?\n',                 
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              )
                            ),
                          )
                        ],             
                      ),
                     Row(
                      children: [
                        Text('\n')],
                     ),
                         
                    Table(
                    border: TableBorder.all(),
                    columnWidths: {
                    0:FractionColumnWidth(.15),
                    1:FractionColumnWidth(.25),
                    2:FractionColumnWidth(.15),
                    3:FractionColumnWidth(.2),
                    4:FractionColumnWidth(.2),
                    },
                
              
              children: [            
                TableRow(children: [
                  TableCell(child: Container (color: Colors.green[300], child: Center(child: Text('Nada',style: TextStyle(color: Colors.black,fontSize: 18),))),),
                  TableCell(child: Container (color: Colors.purple[300], child: Center(child: Text('Muy poco',style: TextStyle(color: Colors.black,fontSize: 18),))),),
                  TableCell(child: Container (color: Colors.orange[300], child: Center(child: Text('Poco',style: TextStyle(color: Colors.black,fontSize: 18),))),),
                  TableCell(child: Container (color: Colors.pink[300], child: Center(child: Text('Bastante',style: TextStyle(color: Colors.black,fontSize: 18),))),), 
                  TableCell(child: Container (color: Colors.red[200], child: Center(child: Text('Severo',style: TextStyle(color: Colors.black,fontSize: 18),))),),             
                ]),
                TableRow(children: [
                  TableCell(
                    child: Center(child: Text('0',style: TextStyle(color: Colors.black,fontSize: 18),)),
                    verticalAlignment: TableCellVerticalAlignment.bottom,
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Center(child: Text('1',style: TextStyle(color: Colors.black,fontSize: 18),)),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Center(child: Text('2',style: TextStyle(color: Colors.black,fontSize: 18),)),
                  ),
                  TableCell(
                    child: Center(child: Text('3',style: TextStyle(color: Colors.black,fontSize: 18),)),
                    verticalAlignment: TableCellVerticalAlignment.top,
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Center(child: Text('4',style: TextStyle(color: Colors.black,fontSize: 18),)),
                  ),
            ]),
            ],), 
            Row(
              children: [
                Text('\n')
            ],),                                 
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  margin: EdgeInsets.fromLTRB(90.0, 16.0, 16.0, 16.0),      
                  child :Text('$_sintomasunitarios ',style: Theme.of(context).textTheme.headline4,),  
                ),
                Card(
                  child: Column(
                    children:<Widget> [
                      RaisedButton(onPressed: incrementarsintomasunitarios  ,
                      child: Icon(Icons.expand_less), ),
                      RaisedButton(onPressed: disminuirsintomasunitarios,
                      child: Icon(Icons.expand_more), )
                    ],
                  ),
                )
              ]
            ),
            Row(
              children: [
                Text('\n'),
              ],
            ), 
            Row(
              children: [
                Text('\n'),
              ],
            ), 
            Row(
              children: [
                Text('\n'),
              ],
            ), 
            Row(
              children: [
                Text('\n'),
              ],
            ), 
          ],
        ),
      ), 
    ),),
//--------------valoricg-----------------
          new Container(child: Scaffold(
                appBar: AppBar(
                  title: Text('Registrar bitacora'),
                ),
                body: Container(
                  padding: EdgeInsets.only(
                    top: 70,
                    bottom: 0,
                    right: 10,
                    left: 10
                  ),
                  child: Column(         
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(                  
                            child: Text('¿Qué valor asignaría en relación \n a las Valor ICG en este momento?\n',                 
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              )
                            ),
                          )
                        ],             
                      ),
                     Row(
                      children: [
                        Text('\n')],
                     ),
                         
                    Table(
                    border: TableBorder.all(),
                    columnWidths: {
                    0:FractionColumnWidth(.15),
                    1:FractionColumnWidth(.25),
                    2:FractionColumnWidth(.15),
                    3:FractionColumnWidth(.2),
                    4:FractionColumnWidth(.2),
                    },
                
              
              children: [            
                TableRow(children: [
                  TableCell(child: Container (color: Colors.green[300], child: Center(child: Text('Nada',style: TextStyle(color: Colors.black,fontSize: 18),))),),
                  TableCell(child: Container (color: Colors.purple[300], child: Center(child: Text('Muy poco',style: TextStyle(color: Colors.black,fontSize: 18),))),),
                  TableCell(child: Container (color: Colors.orange[300], child: Center(child: Text('Poco',style: TextStyle(color: Colors.black,fontSize: 18),))),),
                  TableCell(child: Container (color: Colors.pink[300], child: Center(child: Text('Bastante',style: TextStyle(color: Colors.black,fontSize: 18),))),), 
                  TableCell(child: Container (color: Colors.red[200], child: Center(child: Text('Severo',style: TextStyle(color: Colors.black,fontSize: 18),))),),             
                ]),
                TableRow(children: [
                  TableCell(
                    child: Center(child: Text('0',style: TextStyle(color: Colors.black,fontSize: 18),)),
                    verticalAlignment: TableCellVerticalAlignment.bottom,
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Center(child: Text('1',style: TextStyle(color: Colors.black,fontSize: 18),)),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Center(child: Text('2',style: TextStyle(color: Colors.black,fontSize: 18),)),
                  ),
                  TableCell(
                    child: Center(child: Text('3',style: TextStyle(color: Colors.black,fontSize: 18),)),
                    verticalAlignment: TableCellVerticalAlignment.top,
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Center(child: Text('4',style: TextStyle(color: Colors.black,fontSize: 18),)),
                  ),
            ]),
            ],), 
            Row(
              children: [
                Text('\n')
            ],),                                 
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  margin: EdgeInsets.fromLTRB(90.0, 16.0, 16.0, 16.0),      
                  child :Text('$_valoricg ',style: Theme.of(context).textTheme.headline4,),  
                ),
                Card(
                  child: Column(
                    children:<Widget> [
                      RaisedButton(onPressed: incrementarvaloricg  ,
                      child: Icon(Icons.expand_less), ),
                      RaisedButton(onPressed: disminuirvaloricg,
                      child: Icon(Icons.expand_more), )
                    ],
                  ),
                )
              ]
            ),
            Row(
              children: [
                Text('\n'),
              ],
            ), 
            Row(
              children: [
                Text('\n'),
              ],
            ), 
            Row(
              children: [
                Text('\n'),
              ],
            ), 
            Row(
              children: [
                RaisedButton(onPressed:(){
                  addData();
                  Navigator.of(context).pop(); 
                 // Navigator.popAndPushNamed(context, '/menutrabajador');
                } , child: Text ('Ingresar'))
              ],
            ), 
          ],
        ),
      ), 
    ),),

          ],
        ),
      );
  }
}