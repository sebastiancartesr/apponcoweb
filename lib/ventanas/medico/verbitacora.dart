import 'package:flutter/material.dart';
import 'package:demo1/controllers/bitacoraController.dart';


class VerBitacoramedico extends StatefulWidget {
  VerBitacoramedico({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _VerBitacoramedicoState createState() => _VerBitacoramedicoState();
}

class _VerBitacoramedicoState extends State<VerBitacoramedico> {
  final BitacoraController _bita= new BitacoraController();
  
  @override
  Widget build(BuildContext context) {
    return Container(
      
      child: Scaffold(
        appBar: AppBar(
          title: Text(''),
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
                  TableCell(child: Container (child: Center(child: Text('\n'+_bita.nauseas ,style: TextStyle(color: Colors.black,fontSize: 20),))),),                            
                ]),
                                TableRow(children: [
                  TableCell(child: Container ( child: Text('\n  Vomitos',style: TextStyle(color: Colors.black,fontSize: 20),)),),
                  TableCell(child: Container (child: Center(child: Text('\n'+_bita.vomito ,style: TextStyle(color: Colors.black,fontSize: 20),))),),                            
                ]),
                                TableRow(children: [
                  TableCell(child: Container ( child: Text('\n  Diarrea',style: TextStyle(color: Colors.black,fontSize: 20),)),),
                  TableCell(child: Container (child: Center(child: Text('\n'+_bita.diarrea ,style: TextStyle(color: Colors.black,fontSize: 20),))),),                            
                ]),
                                TableRow(children: [
                  TableCell(child: Container ( child: Text('\n  Constipacion',style: TextStyle(color: Colors.black,fontSize: 20),)),),
                  TableCell(child: Container (child: Center(child: Text('\n'+_bita.constipacion ,style: TextStyle(color: Colors.black,fontSize: 20),))),),                            
                ]),
                                TableRow(children: [
                  TableCell(child: Container ( child: Text('\n  Dolor',style: TextStyle(color: Colors.black,fontSize: 20),)),),
                  TableCell(child: Container (child: Center(child: Text('\n'+_bita.dolor ,style: TextStyle(color: Colors.black,fontSize: 20),))),),                            
                ]),
                                TableRow(children: [
                  TableCell(child: Container ( child: Text('\n  Fatiga',style: TextStyle(color: Colors.black,fontSize: 20),)),),
                  TableCell(child: Container (child: Center(child: Text('\n'+_bita.fatiga ,style: TextStyle(color: Colors.black,fontSize: 20),))),),                            
                ]),
                                TableRow(children: [
                  TableCell(child: Container ( child: Text('\n  Perdida de apetito',style: TextStyle(color: Colors.black,fontSize: 20),)),),
                  TableCell(child: Container (child: Center(child: Text('\n'+_bita.perdidaapetito ,style: TextStyle(color: Colors.black,fontSize: 20),))),),                            
                ]),
                                TableRow(children: [
                  TableCell(child: Container ( child: Text('\n  Fiebre en °C',style: TextStyle(color: Colors.black,fontSize: 20),)),),
                  TableCell(child: Container (child: Center(child: Text('\n'+_bita.fiebre ,style: TextStyle(color: Colors.black,fontSize: 20),))),),                            
                ]),
                                TableRow(children: [
                  TableCell(child: Container ( child: Text('\n  Sintomas de resfrio',style: TextStyle(color: Colors.black,fontSize: 20),)),),
                  TableCell(child: Container (child: Center(child: Text('\n'+_bita.sintomaresfrio ,style: TextStyle(color: Colors.black,fontSize: 20),))),),                            
                ]),
                                TableRow(children: [
                  TableCell(child: Container ( child: Text('\n  Sintomas unitarios',style: TextStyle(color: Colors.black,fontSize: 20),)),),
                  TableCell(child: Container (child: Center(child: Text('\n'+_bita.sintomasunitarios ,style: TextStyle(color: Colors.black,fontSize: 20),))),),                            
                ]),
                                TableRow(children: [
                  TableCell(child: Container ( child: Text('\n  Valor ICG',style: TextStyle(color: Colors.black,fontSize: 20),)),),
                  TableCell(child: Container (child: Center(child: Text('\n'+_bita.valoricg ,style: TextStyle(color: Colors.black,fontSize: 20),))),),                            
                ]),

            ],),
          ]
        ),
        )
      ),
    );

    
    }
}
