import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:demo1/controllers/usuario.dart';
import 'package:demo1/controllers/bitacoraController.dart';
import 'package:demo1/controllers/auxpaciente.dart';


class VerPacientedos extends StatefulWidget {
  VerPacientedos({Key key}) : super(key: key);

  @override
  _VerPacientedosState createState() => _VerPacientedosState();
}

class _VerPacientedosState extends State<VerPacientedos> {
    final Usuario _usuario = new Usuario();
     
    Future<List> getData() async {
    final response = await http.post("http://192.168.42.49/demo1/verpacientes.php", body:{
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
                      builder: (BuildContext context) => new ElegirFecha(
                           lista: list,
                            aux: i,
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


class ElegirFecha extends StatefulWidget {
    List lista;
    int aux;
  
  ElegirFecha({this.aux,this.lista});
  @override
  _ElegirFecha createState() => _ElegirFecha();
}

class _ElegirFecha extends State<ElegirFecha> {

  final BitacoraController _bitacora= new BitacoraController();
  final Paciente _paciente = new Paciente();
  String mensaje='';
  String user='';
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
  Future <List> verBitacora() async{
      
     // final response = await http.post("http://192.168.42.49/demo1/verbitacora.php", body:{
        final response = await http.post("http://192.168.42.49/demo1/verbitacora.php", body:{
      "IdPaciente":widget.lista[widget.aux]['IdPaciente'],
      "DataIni":_splitter(_dateTime.toString()),
      });
      var datauser = json.decode(response.body);

      if(datauser.length == 0){

        setState(() {
          mensaje="No se han ingresado bitacoras ese dia";});
      }else{
          setState(() {
            _paciente.idd=widget.lista[widget.aux]['IdPaciente'];
            _bitacora.fechaaux= _splitter(_dateTime.toString());});
        
       Navigator.popAndPushNamed(context, '/elegirbitacoramedico');
    }

    return json.decode(response.body);
    }
           Future <List> edit() async{
    final response = await http.post("http://192.168.42.49/demo1/buscardatospaciente.php", body:{
      "IdPaciente":_paciente.idd,
    });
    var datauser = json.decode(response.body);

    if(datauser.length == 0){
      setState(() {
        mensaje="Error";});
    }else{
      setState(() {
          _paciente.clave= datauser[0]['Clave'];
          _paciente.numerodetelefono= datauser[0]['Telefono'];
          _paciente.direccion= datauser[0]['Direccion']; 
          _paciente.nombre= 'Nombre: ${datauser[0]['PrimerNombre']} ${datauser[0]['PrimerApellido']}';
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
        user=_paciente.idd= widget.lista[widget.aux]['IdPaciente'];
        edit();
        
      },
    )
  ],
          title:Text('Ver Bitacora'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(_dateTime.toString()== null ? 'No se ha seleccionado una fecha':_splitter(_dateTime.toString()), style: TextStyle(fontSize: 25.0)),
              RaisedButton(
                child: Text('Seleccionar fecha'),
                onPressed: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2001),
                    lastDate: DateTime(2021)
                  ).then((date) {
                    print(date);
                    if(date==null){
                      date = _dateTime;
                    }else{
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
                       borderRadius: new BorderRadius.circular(30.0)
                     ),
                     onPressed:(){
                       verBitacora();
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

