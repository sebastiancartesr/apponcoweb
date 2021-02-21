import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:pie_chart/pie_chart.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key}) : super(key: key);

  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Future<List> getData() async {
    final response = await http.post(
        "http://192.168.1.27/demo1/verpacalertas.php",
        body: {"IdMedico": '1', "DataIni": '2021-02-19'});
    return json.decode(response.body);
  }

  Future<List> getData2() async {
    final response = await http.post(
        "http://192.168.1.27/demo1/vermaxfiebre.php",
        body: {"IdMedico": '1', "DataIni": '2021-02-19'});
    return json.decode(response.body);
  }

  Future<List> getData3() async {
    final response = await http.post(
        "http://192.168.1.27/demo1/notbitacora.php",
        body: {"IdMedico": '1', "DataIni": '2021-02-19'});
    return json.decode(response.body);
  }

  Future<List> getData4() async {
    final response = await http.post("http://192.168.1.27/demo1/pacdiarrea.php",
        body: {"IdMedico": '1', "DataIni": '2021-02-19'});
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: GridView(
            padding: EdgeInsets.only(top: 20.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: MediaQuery.of(context).size.width >= 1300
                    ? 3
                    : MediaQuery.of(context).size.width >= 700
                        ? 2
                        : 1),
            children: <Widget>[
              Card(
                margin: EdgeInsets.all(40.0),
                elevation: 3.0,
                color: Colors.lightGreen[200],
                child: Scaffold(
                  appBar: AppBar(
                    title: Text("Pacientes sin registros hoy"),
                    automaticallyImplyLeading: false,
                  ),
                  body: new FutureBuilder<List>(
                    future: getData3(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) print(snapshot.error);
                      return snapshot.hasData
                          ? new CardNoBitacora(
                              list: snapshot.data,
                            )
                          : new Center(
                              child: new CircularProgressIndicator(),
                            );
                    },
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.all(40.0),
                elevation: 3.0,
                color: Colors.lightBlue[200],
                child: Scaffold(
                  appBar: AppBar(
                    title: Text("Pacientes con más alertas "),
                    automaticallyImplyLeading: false,
                  ),
                  body: new FutureBuilder<List>(
                    future: getData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) print(snapshot.error);
                      return snapshot.hasData
                          ? new DoctorsCardWidget(
                              list: snapshot.data,
                            )
                          : new Center(
                              child: new CircularProgressIndicator(),
                            );
                    },
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.all(40.0),
                elevation: 3.0,
                color: Colors.orange[200],
                child: Scaffold(
                  appBar: AppBar(
                    title: Text("Pacientes con mayor riesgo por temperatura"),
                    automaticallyImplyLeading: false,
                  ),
                  body: new FutureBuilder<List>(
                    future: getData2(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) print(snapshot.error);
                      return snapshot.hasData
                          ? new CardFiebreMax(
                              list: snapshot.data,
                            )
                          : new Center(
                              child: new CircularProgressIndicator(),
                            );
                    },
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.all(40.0),
                elevation: 3.0,
                color: Colors.purple[200],
                child: Scaffold(
                  appBar: AppBar(
                    title: Text("Pacientes con mayor nivel de diarrea"),
                    automaticallyImplyLeading: false,
                  ),
                  body: new FutureBuilder<List>(
                    future: getData4(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) print(snapshot.error);
                      return snapshot.hasData
                          ? new CardDiarrea(
                              list: snapshot.data,
                            )
                          : new Center(
                              child: new CircularProgressIndicator(),
                            );
                    },
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.all(40.0),
                elevation: 3.0,
                color: Colors.brown[200],
                child: Scaffold(
                  appBar: AppBar(title: Text("Pacientes sin registros hoy")),
                  body: Text(
                    "Tile 1",
                    style: TextStyle(color: Colors.green[900], fontSize: 30.0),
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.all(40.0),
                elevation: 3.0,
                color: Colors.amber[200],
                child: Scaffold(
                  appBar: AppBar(title: Text("Pacientes sin registros hoy")),
                  body: Text(
                    "Tile 1",
                    style: TextStyle(color: Colors.green[900], fontSize: 30.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

//--------------------------------------------------------

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
            onTap: () {},
            /* =>Navigator.of(context).push(
              new MaterialPageRoute(
                  builder: (BuildContext context) => new ElegirFecha(
                        lista: list,
                        aux: i,
                      )),
            ),*/
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

class DoctorsCardWidget extends StatelessWidget {
  final List list;
  DoctorsCardWidget({this.list});
  final Map<String, double> dataMa = {
    "Flutter": 5,
    "React": 3,
  };

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return new Container(
          height: 129.0,
          padding: const EdgeInsets.all(1.0),
          child: FlatButton(
            highlightColor: Colors.white,
            onPressed: () {},
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(1.0),
            ),
            //onTap: () {},
            child: Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Container(
                decoration: BoxDecoration(
                  //border: Border.all(color: Colors.black),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        offset: Offset(0, 4),
                        blurRadius: 10)
                  ],
                ),
                padding: const EdgeInsets.only(
                    top: 20.0, bottom: 12.0, left: 12.0, right: 12.0),
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20.0),
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        children: [
                          Text(
                            '${list[i]['alertas']}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 24.0,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Alertas',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    /*
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    PieChart(
                      dataMap: dataMa,
                      showLegends: false,
                      showChartValues: false,
                      chartRadius: MediaQuery.of(context).size.width /
                          6.5, //determines the size of the chart
                      
                      chartType:
                          ChartType.disc, //can be changed to ChartType.ring
                    ),
                    Text(
                      'Bitacoras',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12.0,
                        color: this.widget.doctors.color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),*/
                    SizedBox(width: 20.0),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(bottom: 10.0),
                              child: Text(
                                list[i]['PrimerNombre'] +
                                    ' ' +
                                    list[i]['PrimerApellido'],
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              "Rut: ${list[i]['Rut']}",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                  fontSize: 15.0),
                            ),
                            SizedBox(height: 10.0),
                            Text(
                              "Edad: ${list[i]['FechaN']} años",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                  fontSize: 15.0),
                            ),
                          ],
                        ),
                        //Text(  '9:30AM - 8:30PM',style: TextStyle(fontFamily: 'Poppins',fontSize: 10.0,fontWeight: FontWeight.bold,),),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class DoctorsCardWidgetgrafico extends StatelessWidget {
  final List list;
  DoctorsCardWidgetgrafico({this.list});
  int dias = 3;

  final Map<String, double> dataMa = {
    "total": 3,
    "React": 3,
  };

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return new Container(
          height: 150.0,
          padding: const EdgeInsets.all(6.0),
          child: FlatButton(
            highlightColor: Colors.white,
            onPressed: () {},
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Card(
              elevation: 0.5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        offset: Offset(0, 4),
                        blurRadius: 10)
                  ],
                ),
                padding: const EdgeInsets.only(
                    top: 12.0, bottom: 12.0, left: 12.0, right: 12.0),
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white)),
                      child: PieChart(
                        dataMap: dataMa,
                        showLegends: false,
                        showChartValues: false,
                        chartRadius: MediaQuery.of(context).size.width /
                            20, //determines the size of the chart

                        chartType:
                            ChartType.disc, //can be changed to ChartType.ring
                      ),
                    ),
                    /*Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    PieChart(
                      dataMap: dataMa,
                      showLegends: false,
                      showChartValues: false,
                      chartRadius: MediaQuery.of(context).size.width /
                          20, //determines the size of the chart
                      
                      chartType:
                          ChartType.disc, //can be changed to ChartType.ring
                    ),
                    Text(
                      'Bitacoras',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),*/
                    SizedBox(width: 10.0),
                    Container(
                      //decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: const EdgeInsets.only(bottom: 10.0),
                                child: Text(
                                  list[i]['PrimerNombre'] +
                                      ' ' +
                                      list[i]['PrimerApellido'],
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(
                                "Rut: ${list[i]['Rut']}",
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                    fontSize: 15.0),
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                "Edad: ${list[i]['FechaN']} años",
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                    fontSize: 15.0),
                              ),
                            ],
                          ),
                          //Text(  '9:30AM - 8:30PM',style: TextStyle(fontFamily: 'Poppins',fontSize: 10.0,fontWeight: FontWeight.bold,),),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class CardFiebreMax extends StatelessWidget {
  final List list;
  CardFiebreMax({this.list});
  final Map<String, double> dataMa = {
    "Flutter": 5,
    "React": 3,
  };

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return new Container(
          height: 129.0,
          padding: const EdgeInsets.all(1.0),
          child: FlatButton(
            highlightColor: Colors.white,
            onPressed: () {},
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(1.0),
            ),
            //onTap: () {},
            child: Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Container(
                decoration: BoxDecoration(
                  //border: Border.all(color: Colors.black),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        offset: Offset(0, 4),
                        blurRadius: 10)
                  ],
                ),
                padding: const EdgeInsets.only(
                    top: 20.0, bottom: 12.0, left: 12.0, right: 12.0),
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20.0),
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        children: [
                          Text(
                            '${list[i]['MaxFiebre']}°',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 22.0,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Temperatura',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 10.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    /*
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    PieChart(
                      dataMap: dataMa,
                      showLegends: false,
                      showChartValues: false,
                      chartRadius: MediaQuery.of(context).size.width /
                          6.5, //determines the size of the chart
                      
                      chartType:
                          ChartType.disc, //can be changed to ChartType.ring
                    ),
                    Text(
                      'Bitacoras',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12.0,
                        color: this.widget.doctors.color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),*/
                    SizedBox(width: 20.0),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(bottom: 10.0),
                              child: Text(
                                list[i]['PrimerNombre'] +
                                    ' ' +
                                    list[i]['PrimerApellido'],
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              "Rut: ${list[i]['Rut']}",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                  fontSize: 15.0),
                            ),
                            SizedBox(height: 10.0),
                            Text(
                              "Edad: ${list[i]['FechaN']} años",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                  fontSize: 15.0),
                            ),
                          ],
                        ),
                        //Text(  '9:30AM - 8:30PM',style: TextStyle(fontFamily: 'Poppins',fontSize: 10.0,fontWeight: FontWeight.bold,),),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class CardDiarrea extends StatelessWidget {
  final List list;
  CardDiarrea({this.list});
  final Map<String, double> dataMa = {
    "Flutter": 5,
    "React": 3,
  };

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return new Container(
          height: 129.0,
          padding: const EdgeInsets.all(1.0),
          child: FlatButton(
            highlightColor: Colors.white,
            onPressed: () {},
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(1.0),
            ),
            //onTap: () {},
            child: Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Container(
                decoration: BoxDecoration(
                  //border: Border.all(color: Colors.black),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        offset: Offset(0, 4),
                        blurRadius: 10)
                  ],
                ),
                padding: const EdgeInsets.only(
                    top: 20.0, bottom: 12.0, left: 12.0, right: 12.0),
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20.0),
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        children: [
                          Text(
                            '${list[i]['MaxDiarrea']}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 24.0,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Nivel',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    /*
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    PieChart(
                      dataMap: dataMa,
                      showLegends: false,
                      showChartValues: false,
                      chartRadius: MediaQuery.of(context).size.width /
                          6.5, //determines the size of the chart
                      
                      chartType:
                          ChartType.disc, //can be changed to ChartType.ring
                    ),
                    Text(
                      'Bitacoras',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12.0,
                        color: this.widget.doctors.color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),*/
                    SizedBox(width: 20.0),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(bottom: 10.0),
                              child: Text(
                                list[i]['PrimerNombre'] +
                                    ' ' +
                                    list[i]['PrimerApellido'],
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              "Rut: ${list[i]['Rut']}",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                  fontSize: 15.0),
                            ),
                            SizedBox(height: 10.0),
                            Text(
                              "Edad: ${list[i]['FechaN']} años",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                  fontSize: 15.0),
                            ),
                          ],
                        ),
                        //Text(  '9:30AM - 8:30PM',style: TextStyle(fontFamily: 'Poppins',fontSize: 10.0,fontWeight: FontWeight.bold,),),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class CardNoBitacora extends StatelessWidget {
  final List list;
  CardNoBitacora({this.list});
  final Map<String, double> dataMa = {
    "Flutter": 5,
    "React": 3,
  };

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return new Container(
          height: 129.0,
          padding: const EdgeInsets.all(1.0),
          child: FlatButton(
            highlightColor: Colors.white,
            onPressed: () {},
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(1.0),
            ),
            //onTap: () {},
            child: Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Container(
                decoration: BoxDecoration(
                  //border: Border.all(color: Colors.black),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        offset: Offset(0, 4),
                        blurRadius: 10)
                  ],
                ),
                padding: const EdgeInsets.only(
                    top: 20.0, bottom: 12.0, left: 12.0, right: 12.0),
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 0.0),
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child:                           Icon(
                            Icons.person,
                            color: Colors.black,
                            size: 80.0,
                            semanticLabel:
                                'Text to announce in accessibility modes',
                          ),
                      ),
                    

                    /*
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    PieChart(
                      dataMap: dataMa,
                      showLegends: false,
                      showChartValues: false,
                      chartRadius: MediaQuery.of(context).size.width /
                          6.5, //determines the size of the chart
                      
                      chartType:
                          ChartType.disc, //can be changed to ChartType.ring
                    ),
                    Text(
                      'Bitacoras',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12.0,
                        color: this.widget.doctors.color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),*/
                    SizedBox(width: 20.0),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(bottom: 10.0),
                              child: Text(
                                list[i]['PrimerNombre'] +
                                    ' ' +
                                    list[i]['PrimerApellido'],
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              "Rut: ${list[i]['Rut']}",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                  fontSize: 15.0),
                            ),
                            SizedBox(height: 10.0),
                            Text(
                              "Edad: ${list[i]['FechaN']} años",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                  fontSize: 15.0),
                            ),
                          ],
                        ),
                        //Text(  '9:30AM - 8:30PM',style: TextStyle(fontFamily: 'Poppins',fontSize: 10.0,fontWeight: FontWeight.bold,),),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
