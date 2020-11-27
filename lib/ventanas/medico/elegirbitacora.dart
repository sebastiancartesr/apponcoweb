import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:demo1/controllers/auxpaciente.dart';
import 'package:demo1/controllers/bitacoraController.dart';

class ElegirBitacoramedico extends StatefulWidget {
  ElegirBitacoramedico({Key key}) : super(key: key);

  @override
  _ElegirBitacoramedicoState createState() => _ElegirBitacoramedicoState();
}

class _ElegirBitacoramedicoState extends State<ElegirBitacoramedico> {
    final Paciente _paciente = new Paciente();
    final BitacoraController _bitacora = new BitacoraController();
     
  Future <List> verBitacoras() async{
      
      final response = await http.post("http://192.168.1.108/demo1/verbitacora.php", body:{
      "IdPaciente":_paciente.idd,
      "DataIni":_bitacora.fechaaux,
      });
    return json.decode(response.body);
  }

  @override
   Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Bitacoras"),
      ),
      body: new FutureBuilder<List>(
        future: verBitacoras(),
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
                  "Bitacora ${i+1}",
                  style: TextStyle(fontSize: 25.0, color: Colors.orangeAccent),
                ),
                leading: new Icon(
                  Icons.assignment,
                  size: 55.0,
                  color: Colors.orangeAccent,
                ),
                subtitle: new Text(
                  list[i]['FechaHora'],
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

class Detail extends StatefulWidget {
  List list;
  int index;
  Detail({this.index,this.list});
  @override
  _DetailState createState() => new _DetailState();
}

class _DetailState extends State<Detail> {
    final Paciente _paciente = new Paciente();


  @override
  Widget build(BuildContext context) {
    return Container(
      
      child: Scaffold(
        appBar: AppBar(
          title: Text('bitacora de ${widget.list[widget.index]['FechaHora']}'), 
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back_sharp),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Container(
          
          padding: EdgeInsets.only(
            top: 0,
            bottom: 0,
            right: 0,
            left: 0
          ),
        child: Column(
          
          children: <Widget>[
  
             Table(
                      border: TableBorder.all(),
                      columnWidths: {
                      0:FractionColumnWidth(.15),
                      1:FractionColumnWidth(.25),
                      2:FractionColumnWidth(.15),
                      3:FractionColumnWidth(.25),
                      4:FractionColumnWidth(.2),
                      },
                      
                  
                
                children: [            
                  TableRow(children: [
                    TableCell(child: Container (color: Colors.green[300], child: Center(child: Text('Nada',style: TextStyle(color: Colors.black,fontSize: 20),))),),
                    TableCell(child: Container (color: Colors.purple[300], child: Center(child: Text('Muy poco',style: TextStyle(color: Colors.black,fontSize: 20),))),),
                    TableCell(child: Container (color: Colors.orange[300], child: Center(child: Text('Poco',style: TextStyle(color: Colors.black,fontSize: 20),))),),
                    TableCell(child: Container (color: Colors.pink[300], child: Center(child: Text('Bastante',style: TextStyle(color: Colors.black,fontSize: 20),))),), 
                    TableCell(child: Container (color: Colors.red[200], child: Center(child: Text('Severo',style: TextStyle(color: Colors.black,fontSize: 20),))),),             
                  ]),
                  TableRow(children: [
                    TableCell(
                      child: Center(child: Text('0',style: TextStyle(color: Colors.black,fontSize: 25),)),
                      verticalAlignment: TableCellVerticalAlignment.bottom,
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Center(child: Text('1',style: TextStyle(color: Colors.black,fontSize: 25),)),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Center(child: Text('2',style: TextStyle(color: Colors.black,fontSize: 25),)),
                    ),
                    TableCell(
                      child: Center(child: Text('3',style: TextStyle(color: Colors.black,fontSize: 25),)),
                      verticalAlignment: TableCellVerticalAlignment.top,
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Center(child: Text('4',style: TextStyle(color: Colors.black,fontSize: 25),)),
                    ),
              ]),
              ],),

              new Table(
                    border: TableBorder.all(),
                    columnWidths: {
                    0:FractionColumnWidth(.75),
                    1:FractionColumnWidth(.25),
                    },
                    
              
              children: [            
                TableRow(children: [
                  TableCell(child: Container ( child: Text('\n  Nauseas',style: TextStyle(color: Colors.black,fontSize: 20),)),),
                  TableCell(child: Container (child: Center(child: Text('\n'+widget.list[widget.index]['Nauseas'] ,style: TextStyle(color: Colors.black,fontSize: 20),))),),                            
                ]),
                                TableRow(children: [
                  TableCell(child: Container ( child: Text('\n  Vomitos',style: TextStyle(color: Colors.black,fontSize: 20),)),),
                  TableCell(child: Container (child: Center(child: Text('\n'+widget.list[widget.index]['Vomitos'] ,style: TextStyle(color: Colors.black,fontSize: 20),))),),                            
                ]),
                                TableRow(children: [
                  TableCell(child: Container ( child: Text('\n  Diarrea',style: TextStyle(color: Colors.black,fontSize: 20),)),),
                  TableCell(child: Container (child: Center(child: Text('\n'+widget.list[widget.index]['Vomitos'] ,style: TextStyle(color: Colors.black,fontSize: 20),))),),                            
                ]),
                                TableRow(children: [
                  TableCell(child: Container ( child: Text('\n  Constipacion',style: TextStyle(color: Colors.black,fontSize: 20),)),),
                  TableCell(child: Container (child: Center(child: Text('\n'+widget.list[widget.index]['Constipacion'] ,style: TextStyle(color: Colors.black,fontSize: 20),))),),                            
                ]),
                                TableRow(children: [
                  TableCell(child: Container ( child: Text('\n  Dolor',style: TextStyle(color: Colors.black,fontSize: 20),)),),
                  TableCell(child: Container (child: Center(child: Text('\n'+widget.list[widget.index]['Dolor'] ,style: TextStyle(color: Colors.black,fontSize: 20),))),),                            
                ]),
                                TableRow(children: [
                  TableCell(child: Container ( child: Text('\n  Fatiga',style: TextStyle(color: Colors.black,fontSize: 20),)),),
                  TableCell(child: Container (child: Center(child: Text('\n'+widget.list[widget.index]['Fatiga'] ,style: TextStyle(color: Colors.black,fontSize: 20),))),),                            
                ]),
                                TableRow(children: [
                  TableCell(child: Container ( child: Text('\n  Perdida de apetito',style: TextStyle(color: Colors.black,fontSize: 20),)),),
                  TableCell(child: Container (child: Center(child: Text('\n'+widget.list[widget.index]['PerdidaApetito'] ,style: TextStyle(color: Colors.black,fontSize: 20),))),),                            
                ]),
                                TableRow(children: [
                  TableCell(child: Container ( child: Text('\n  Fiebre en °C',style: TextStyle(color: Colors.black,fontSize: 20),)),),
                  TableCell(child: Container (child: Center(child: Text('\n'+widget.list[widget.index]['Fiebre'] ,style: TextStyle(color: Colors.black,fontSize: 20),))),),                            
                ]),
                                TableRow(children: [
                  TableCell(child: Container ( child: Text('\n  Sintomas de resfrio',style: TextStyle(color: Colors.black,fontSize: 20),)),),
                  TableCell(child: Container (child: Center(child: Text('\n'+widget.list[widget.index]['SintomasResfrio'] ,style: TextStyle(color: Colors.black,fontSize: 20),))),),                            
                ]),
                                TableRow(children: [
                  TableCell(child: Container ( child: Text('\n  Sintomas unitarios',style: TextStyle(color: Colors.black,fontSize: 20),)),),
                  TableCell(child: Container (child: Center(child: Text('\n'+widget.list[widget.index]['SintomasUnitarios'] ,style: TextStyle(color: Colors.black,fontSize: 20),))),),                            
                ]),
                                TableRow(children: [
                  TableCell(child: Container ( child: Text('\n  Valor ICG',style: TextStyle(color: Colors.black,fontSize: 20),)),),
                  TableCell(child: Container (child: Center(child: Text('\n'+widget.list[widget.index]['ValorICG'] ,style: TextStyle(color: Colors.black,fontSize: 20),))),),                            
                ]),

            ],),
          ]
        ),
        )
      ),
    );

    
    }
}