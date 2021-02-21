import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:demo1/controllers/usuario.dart';
import 'package:demo1/controllers/bitacoraController.dart';
import 'package:demo1/controllers/auxpaciente.dart';

class Ingresarbitacora extends StatelessWidget {

  final Usuario _usuario = new Usuario();
     
    Future<List> getData() async {
    final response = await http.post("http://192.168.1.27/demo1/verpacientes.php", body:{
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
class ElegirFecha extends StatefulWidget {
  List list;
  int index;
  
  ElegirFecha({this.index,this.list});

  @override
  _ElegirFecha createState() => _ElegirFecha();
}

class _ElegirFecha extends State<ElegirFecha> {

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

/*
    Future <List> regbitacora() async{
      
      final response = await http.post("http://192.168.1.27/demo1/regbitacora.php", body:{
      "IdPaciente":_paciente.idd,
      "DataIni":_splitter(_paciente.fechabitacora),
      });
      var datauser = json.decode(response.body);
      print('paso1');

      if(datauser.length == 0){
        print('paso2');
        Navigator.popAndPushNamed(context,'/agregarbitacora');
        
      }else{
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
    }*/
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
                    lastDate: DateTime(2021)
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
class Bitacora2 extends StatefulWidget {
  Bitacora2({Key key}) : super(key: key);
  

  @override
  _Bitacora2State createState() => _Bitacora2State();
}

class _Bitacora2State extends State<Bitacora2> {
  
  
  
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
