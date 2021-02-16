import 'dart:math';

import 'package:demo1/controllers/calendariocontroll.dart';
import 'package:flutter/material.dart';

import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';


class CalendarPage2 extends StatefulWidget {
  @override
  _CalendarPage2State createState() => new _CalendarPage2State();
}

final CalendarioAux _auxcalendar = new CalendarioAux();
DateTime aux;
List<DateTime> _semana = _auxcalendar.listadias;


class _CalendarPage2State extends State<CalendarPage2> {
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


  Future<List> VerBitacorasemana() async {
    final response = await http
        .post("http://192.168.1.30/demo1/verbitacorasemana.php", body: {
      "IdPaciente": '112',
      "DataIni": '2021/02/01',
      "DataFin": '2021/02/07',
    });

    var datauser = json.decode(response.body);
    print('no seeeeeeeeee');
    print(datauser);
    print('salir del rest');
    if (datauser.length == 0) {
      setState(() {});
    } else {
      setState(() {});
    }

    return json.decode(response.body);
  }

  DateTime _hoy = DateTime.now();
  static Widget _iconoConRegistro(String day) => CircleAvatar(
        backgroundColor: Colors.green,
        child: Text(
          day,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      );
  static Widget _iconoNoRegistro(String day) => CircleAvatar(
        backgroundColor: Colors.red,
        child: Text(
          day,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      );

  EventList<Event> _markedDateMap = new EventList<Event>(
    events: {},
  );

  CalendarCarousel _calendarCarouselNoHeader;

  double cHeight;

  @override
  Widget build(BuildContext context) {
    cHeight = MediaQuery.of(context).size.height;

//---------------- dia uno ----------------------------------
    if (_auxcalendar.dia1 == true) {
      _markedDateMap.add(
        _semana[6],
        new Event(
          date: _auxcalendar.listadias[6],
          title: 'Event 5',
          icon: _iconoConRegistro(
            _auxcalendar.listadias[6].day.toString(),
          ),
        ),
      );
    } else {
      _markedDateMap.add(
        _auxcalendar.listadias[6],
        new Event(
          date: _auxcalendar.listadias[6],
          title: 'Event 5',
          icon: _iconoNoRegistro(
            _auxcalendar.listadias[6].day.toString(),
          ),
        ),
      );
    }
    //---------------- dia dos ----------------------------------
    if (_auxcalendar.dia2 == true) {
      _markedDateMap.add(
        _auxcalendar.listadias[5],
        new Event(
          date: _auxcalendar.listadias[5],
          title: 'Event 5',
          icon: _iconoConRegistro(
            _auxcalendar.listadias[5].day.toString(),
          ),
        ),
      );
    } else {
      _markedDateMap.add(
        _auxcalendar.listadias[5],
        new Event(
          date: _auxcalendar.listadias[5],
          title: 'Event 5',
          icon: _iconoNoRegistro(
            _auxcalendar.listadias[5].day.toString(),
          ),
        ),
      );
    }
    //---------------- dia tres ----------------------------------
    if (_auxcalendar.dia3 == true) {
      _markedDateMap.add(
        _auxcalendar.listadias[4],
        new Event(
          date: _auxcalendar.listadias[4],
          title: 'Event 5',
          icon: _iconoConRegistro(
            _auxcalendar.listadias[4].day.toString(),
          ),
        ),
      );
    } else {
      _markedDateMap.add(
        _auxcalendar.listadias[4],
        new Event(
          date: _auxcalendar.listadias[4],
          title: 'Event 5',
          icon: _iconoNoRegistro(
            _auxcalendar.listadias[4].day.toString(),
          ),
        ),
      );
    }
    //---------------- dia cuatro ----------------------------------
    if (_auxcalendar.dia4 == true) {
      _markedDateMap.add(
        _auxcalendar.listadias[3],
        new Event(
          date: _auxcalendar.listadias[3],
          title: 'Event 5',
          icon: _iconoConRegistro(
            _auxcalendar.listadias[3].day.toString(),
          ),
        ),
      );
    } else {
      _markedDateMap.add(
        _auxcalendar.listadias[3],
        new Event(
          date: _auxcalendar.listadias[3],
          title: 'Event 5',
          icon: _iconoNoRegistro(
            _auxcalendar.listadias[3].day.toString(),
          ),
        ),
      );
    }
    //---------------- dia cinco ----------------------------------
    if (_auxcalendar.dia5 == true) {
      _markedDateMap.add(
        _auxcalendar.listadias[2],
        new Event(
          date: _auxcalendar.listadias[2],
          title: 'Event 5',
          icon: _iconoConRegistro(
            _auxcalendar.listadias[2].day.toString(),
          ),
        ),
      );
    } else {
      _markedDateMap.add(
        _auxcalendar.listadias[2],
        new Event(
          date: _auxcalendar.listadias[2],
          title: 'Event 5',
          icon: _iconoNoRegistro(
            _auxcalendar.listadias[2].day.toString(),
          ),
        ),
      );
    }
    //---------------- dia seis ----------------------------------
    if (_auxcalendar.dia6 == true) {
      _markedDateMap.add(
        _auxcalendar.listadias[1],
        new Event(
          date: _auxcalendar.listadias[1],
          title: 'Event 5',
          icon: _iconoConRegistro(
            _auxcalendar.listadias[1].day.toString(),
          ),
        ),
      );
    } else {
      _markedDateMap.add(
        _auxcalendar.listadias[1],
        new Event(
          date: _auxcalendar.listadias[1],
          title: 'Event 5',
          icon: _iconoNoRegistro(
            _auxcalendar.listadias[1].day.toString(),
          ),
        ),
      );
    }
    //---------------- dia siete ----------------------------------
    if (_auxcalendar.dia7 == true) {
      _markedDateMap.add(
        _auxcalendar.listadias[0],
        new Event(
          date: _auxcalendar.listadias[0],
          title: 'Event 5',
          icon: _iconoConRegistro(
            _auxcalendar.listadias[0].day.toString(),
          ),
        ),
      );
    } else {
      _markedDateMap.add(
        _auxcalendar.listadias[0],
        new Event(
          date: _auxcalendar.listadias[0],
          title: 'Event 5',
          icon: _iconoNoRegistro(
            _auxcalendar.listadias[0].day.toString(),
          ),
        ),
      );
    }

    _calendarCarouselNoHeader = CalendarCarousel<Event>(
      height: cHeight * 0.54,
      weekendTextStyle: TextStyle(
        color: Colors.red,
      ),
      todayButtonColor: Colors.blue[200],
      markedDatesMap: _markedDateMap,
      markedDateShowIcon: true,
      markedDateIconMaxShown: 1,
      markedDateMoreShowTotal:
          null, // null for not showing hidden events indicator
      markedDateIconBuilder: (event) {
        return event.icon;
      },
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Calender"),
      ),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * .70,
          width: MediaQuery.of(context).size.height * .60,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[

                _calendarCarouselNoHeader,
                markerRepresent(Colors.red, "Sin Registro"),
                markerRepresent(Colors.green, "Registrado"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget markerRepresent(Color color, String data) {
    return new ListTile(
      leading: new CircleAvatar(
        backgroundColor: color,
        radius: cHeight * 0.022,
      ),
      title: new Text(
        data,
      ),
    );
  }
}
