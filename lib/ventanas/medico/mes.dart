import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:demo1/ventanas/medico/nuevaventanapaciente.dart';
import 'package:demo1/controllers/usuario.dart';

Widget _getHeader(context) {
  if (MediaQuery.of(context).size.width <= 600) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                child: RaisedButton(
                  child: Text(
                    "Hoy",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  color: Colors.blue[900],
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              RaisedButton(
                child: Text(
                  "Semana",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                color: Colors.blue[900],
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/semanainfo');
                },
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                child: RaisedButton(
                  child: Text(
                    "Mes",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  color: Colors.blue[900],
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
        Text(
          DateTime.now().day.toString() +
              "/" +
              DateTime.now().month.toString() +
              "/" +
              DateTime.now().year.toString(),
          textAlign: TextAlign.end,
          style: TextStyle(letterSpacing: 1.2, fontSize: 20.0),
        ),
      ],
    );
  } else {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                child: RaisedButton(
                  child: Text(
                    "Hoy",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  color: Colors.blue[900],
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              RaisedButton(
                child: Text(
                  "Semana",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                color: Colors.blue[900],
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/semanainfo');
                },
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                child: RaisedButton(
                  child: Text(
                    "Mes",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  color: Colors.blue[900],
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
        Text(
          DateTime.now().day.toString() +
              "/" +
              DateTime.now().month.toString() +
              "/ " +
              DateTime.now().year.toString(),
          textAlign: TextAlign.end,
          style: TextStyle(letterSpacing: 1.2, fontSize: 20.0),
        ),
      ],
    );
  }
}

class Mesinfo extends StatefulWidget {
  Mesinfo({Key key}) : super(key: key);

  _MesinfoState createState() => _MesinfoState();
}

class _MesinfoState extends State<Mesinfo> {
  DateTime _hoy = DateTime.now();
  DateTime _fin = DateTime.now().subtract(Duration(days: 31));
  final Usuario _usuario = new Usuario();
  Future<List> getData() async {
    final response = await http
        .post("http://192.168.1.27/demo1/verpacalertasmes.php", body: {
      "IdMedico": _usuario.id.toString(),
      "DataFin": _splitter(_hoy.toString()),
      "DataIni": _splitter(_fin.toString())
    });
    return json.decode(response.body);
  }

  Future<List> getData2() async {
    final response =
        await http.post("http://192.168.1.27/demo1/vermaxfiebremes.php", body: {
      "IdMedico": _usuario.id.toString(),
      "DataFin": _splitter(_hoy.toString()),
      "DataIni": _splitter(_fin.toString())
    });
    return json.decode(response.body);
  }

  Future<List> getData3() async {
    final response =
        await http.post("http://192.168.1.27/demo1/notbitacorames.php", body: {
      "IdMedico": _usuario.id.toString(),
      "DataFin": _splitter(_hoy.toString()),
      "DataIni": _splitter(_fin.toString())
    });
    return json.decode(response.body);
  }

  Future<List> getData4() async {
    final response =
        await http.post("http://192.168.1.27/demo1/pacdiarreames.php", body: {
      "IdMedico": _usuario.id.toString(),
      "DataFin": _splitter(_hoy.toString()),
      "DataIni": _splitter(_fin.toString())
    });
    return json.decode(response.body);
  }

  Future<List> getData5() async {
    final response =
        await http.post("http://192.168.1.27/demo1/contador1mes.php", body: {
      "IdMedico": _usuario.id.toString(),
      "DataFin": _splitter(_hoy.toString()),
      "DataIni": _splitter(_fin.toString())
    });
    return json.decode(response.body);
  }
    Future<List> getData6() async {
    final response =
        await http.post("http://192.168.1.27/demo1/contador2mes.php", body: {
      "IdMedico": _usuario.id.toString(),
      "DataFin": _splitter(_hoy.toString()),
      "DataIni": _splitter(_fin.toString())
    });
    print(
        '${DateTime.now().year.toString()}-${DateTime.now().month.toString()}-${DateTime.now().day.toString()}');
    return json.decode(response.body);
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Informacion del ultimo mes",
              style: TextStyle(letterSpacing: 1.2)),
        ),
      ),
      body: Column(
        children: <Widget>[
          _getHeader(context),
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
                  elevation: 0.0,
                  color: Colors.amber[200],
                  child: Scaffold(
                    body: new FutureBuilder(
                      future: getData5(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) print(snapshot.error);
                        return snapshot.hasData
                            ? new Pacientesyalertas(
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
                  elevation: 0.0,
                  color: Colors.amber[200],
                  child: Scaffold(
                    body: new FutureBuilder(
                      future: getData6(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) print(snapshot.error);
                        return snapshot.hasData
                            ? new Gravesy(
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
                  color: Colors.lightGreen[200],
                  child: Scaffold(
                    appBar: AppBar(
                      title: Text("Pacientes sin registros este mes"),
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
                      title: Text("Pacientes con Síndrome diarreico"),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//--------------------------------------------------------

class DoctorsCardWidget extends StatelessWidget {
  final List list;
  DoctorsCardWidget({this.list});
  calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }

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
            onPressed: () => Navigator.of(context).push(
              new MaterialPageRoute(
                  builder: (BuildContext context) => new Perfil(
                        listaa: list,
                        auxx: i,
                      )),
            ),
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
                              "Edad: ${calculateAge(DateTime.parse(list[i]['FechaN']))} años",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                  fontSize: 15.0),
                            ),
                          ],
                        ),
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

class CardFiebreMax extends StatelessWidget {
  final List list;
  CardFiebreMax({this.list});
  calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }

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
            onPressed: () => Navigator.of(context).push(
              new MaterialPageRoute(
                  builder: (BuildContext context) => new Perfil(
                        listaa: list,
                        auxx: i,
                      )),
            ),
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
                              "Edad: ${calculateAge(DateTime.parse(list[i]['FechaN']))} años",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                  fontSize: 15.0),
                            ),
                          ],
                        ),
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
  calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }

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
            onPressed: () => Navigator.of(context).push(
              new MaterialPageRoute(
                  builder: (BuildContext context) => new Perfil(
                        listaa: list,
                        auxx: i,
                      )),
            ),
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
                              "Edad: ${calculateAge(DateTime.parse(list[i]['FechaN']))} años",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                  fontSize: 15.0),
                            ),
                          ],
                        ),
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
  calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }

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
            onPressed: () => Navigator.of(context).push(
              new MaterialPageRoute(
                  builder: (BuildContext context) => new Perfil(
                        listaa: list,
                        auxx: i,
                      )),
            ),
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
                      child: Icon(
                        Icons.person,
                        color: Colors.black,
                        size: 80.0,
                        semanticLabel:
                            'Text to announce in accessibility modes',
                      ),
                    ),
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
                              "Edad: ${calculateAge(DateTime.parse(list[i]['FechaN']))} años",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                  fontSize: 15.0),
                            ),
                          ],
                        ),
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

class Pacientesyalertas extends StatelessWidget {
  final List list;
  Pacientesyalertas({this.list});
  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.all(40.0),
        elevation: 0.0,
        child: Column(children: <Widget>[
          Card(
              margin: EdgeInsets.only(top: 0),
              elevation: 3.0,
              color: Colors.red[600],
              child: SizedBox(
                  height: 200,
                  width: 440,
                  child: Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
                    Card(
                      color: Colors.red[600],
                      margin: EdgeInsets.only(
                          top: 40, bottom: 40, left: 60, right: 40),
                      elevation: 0.0,
                      child: Icon(
                        Icons.supervised_user_circle_sharp,
                        size: 100.0,
                        color: Colors.white,
                      ),
                    ),
                    Card(
                      color: Colors.red[600],
                      margin: EdgeInsets.only(
                          top: 40, bottom: 40, left: 50, right: 90),
                      elevation: 0.0,
                      child: Column(
                        children: [
                          Text('Pacientes',
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.white)),
                          Text('${list[0]['CountPaciente']}',
                              style: TextStyle(
                                  fontSize: 60.0, color: Colors.white)),
                        ],
                      ),
                    ),
                  ]))),
          SizedBox(
            height: 40,
            //width: 300,
          ),
          Card(
              margin: EdgeInsets.only(top: 20),
              elevation: 3.0,
              color: Colors.red[600],
              child: SizedBox(
                  height: 200,
                  width: 440,
                  child: Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
                    Card(
                      color: Colors.red[600],
                      margin: EdgeInsets.only(
                          top: 40, bottom: 40, left: 60, right: 40),
                      elevation: 0.0,
                      child: Icon(
                        Icons.assignment_late,
                        size: 100.0,
                        color: Colors.white,
                      ),
                    ),
                    Card(
                      color: Colors.red[600],
                      margin: EdgeInsets.only(
                          top: 40, bottom: 40, left: 50, right: 90),
                      elevation: 0.0,
                      child: Column(
                        children: [
                          Text('Alertas',
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.white)),
                          Text('${list[0]['CountAlertas']}',
                              style: TextStyle(
                                  fontSize: 60.0, color: Colors.white)),
                        ],
                      ),
                    ),
                  ])))
        ]));
  }
}

class Gravesy extends StatelessWidget {
  final List list;
  Gravesy({this.list});
  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.all(40.0),
        elevation: 0.0,
        child: Column(children: <Widget>[
          Card(
              margin: EdgeInsets.only(top: 0),
              elevation: 3.0,
              color: Colors.blue[600],
              child: SizedBox(
                  height: 200,
                  width: 440,
                  child: Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
                    Card(
                      color: Colors.blue[600],
                      margin: EdgeInsets.only(
                          top: 40, bottom: 40, left: 60, right: 40),
                      elevation: 0.0,
                      child: Icon(
                        Icons.warning_rounded,
                        size: 100.0,
                        color: Colors.white,
                      ),
                    ),
                    Card(
                      color: Colors.blue[600],
                      margin: EdgeInsets.only(
                          top: 40, bottom: 40, left: 0, right: 60),
                      elevation: 0.0,
                      child: Column(
                        children: [
                          Text('Alertas de gravedad',
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.white)),
                          Text('${list[0]['CountAlertas']}',
                              style: TextStyle(
                                  fontSize: 60.0, color: Colors.white)),
                        ],
                      ),
                    ),
                  ]))),
          SizedBox(
            height: 40,
            //width: 300,
          ),
          Card(
              margin: EdgeInsets.only(top: 20),
              elevation: 3.0,
              color: Colors.blue[600],
              child: SizedBox(
                  height: 200,
                  width: 440,
                  child: Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
                    Card(
                      color: Colors.blue[600],
                      margin: EdgeInsets.only(
                          top: 40, bottom: 40, left: 60, right: 40),
                      elevation: 0.0,
                      child: Icon(
                        Icons.assignment,
                        size: 100.0,
                        color: Colors.white,
                      ),
                    ),
                    Card(
                      color: Colors.blue[600],
                      margin: EdgeInsets.only(
                          top: 40, bottom: 40, left: 50, right: 90),
                      elevation: 0.0,
                      child: Column(
                        children: [
                          Text('Bitacoras',
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.white)),
                          Text('${list[0]['CountBitacoras']}',
                              style: TextStyle(
                                  fontSize: 60.0, color: Colors.white)),
                        ],
                      ),
                    ),
                  ])))
        ]));
  }
}
