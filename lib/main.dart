import 'package:demo1/controllers/provider.dart';
import 'package:demo1/ventanas/medico/menutrabajador.dart';
import 'package:demo1/ventanas/medico/nuevaventanapaciente.dart';
import 'package:demo1/ventanas/medico/veralertaspacientes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:demo1/ventanas/medico/verbitacora.dart';
import 'package:demo1/ventanas/medico/verperfilmedico.dart';
import 'package:demo1/ventanas/medico/veralertaspaciente.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:demo1/controllers/usuario.dart';
import 'package:demo1/ventanas/medico/agregarpaciente.dart';
import 'package:demo1/ventanas/medico/ingresarbitacorasweb.dart';
import 'package:demo1/ventanas/administrador/menuadmin.dart';
import 'package:demo1/ventanas/administrador/loginadmin.dart';
import 'package:demo1/ventanas/administrador/agregarmedico.dart';
import 'package:demo1/ventanas/medico/enviarnotifi.dart';
import 'package:demo1/ventanas/medico/editardatosp.dart';
import 'package:demo1/ventanas/medico/elegirbitacora.dart';
import 'package:demo1/ventanas/medico/verbitacorafinal.dart';
import 'package:demo1/controllers/login_bloc.dart';
import 'package:demo1/ventanas/medico/perfilprueba.dart';
import 'package:demo1/ventanas/medico/calendario.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: <String, WidgetBuilder>{
          "/loginmedico" : (BuildContext context) => LoginPage(),
          "/menutrabajador":(BuildContext context) => MenuTrabajador(),
          "/verbitacoramedico":(BuildContext context) => VerBitacoramedico(),
          "/verperfilmedico":(BuildContext context) =>VerPerfilmedico(),
          "/agregarpaciente":(BuildContext context) => FormScreen(),
          "/agregarbitacora":(BuildContext context) => Bitacora(),
          "/menuadmin":(BuildContext context) => MenuAdmin(),
          "/loginadmin":(BuildContext context) => Loginadmin(),
          "/agregarpersonal":(BuildContext context) => FormScreen2(),
          "/enviarnoti":(BuildContext context) =>EnviarNotificacion(),
          "/editardatos":(BuildContext context) =>FormScreen5(),
          "/elegirbitacoramedico":(BuildContext context) =>ElegirBitacoramedico(),
          "/verpacientesdos":(BuildContext context) =>VerPacientedos(),
          "/verpacientestres":(BuildContext context) =>VerPacientetres(),
         // "/perfilprueba":(BuildContext context) =>Perfil(),
          "/calendario":(BuildContext context) =>CalendarPage2(),
          "/verunaalerta":(BuildContext context) =>VerAlertasPaciente(),
        }
        ,
        home: LoginPage()
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
    final Usuario _usuario = new Usuario();

    Future <List> _login(LoginBloc bloc) async{
    //final response = await http.post("http://192.168.1.108/demo1/loginfuncionario.php", body:{
      final response = await http.post("http://192.168.1.27/demo1/loginfuncionario.php", body:{
      "Correo":bloc.email,
      "clave":bloc.clave,
    });
    var datauser = json.decode(response.body);

    if(datauser.length == 0){
      showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Contraseña o usuario incorrecto'),
        actions:<Widget>[
          RaisedButton(onPressed: (){
            Navigator.of(context).pop();
          },
          child: Text('Aceptar'))
        ],),
      ); 
      
    }else{
      Navigator.popAndPushNamed(context, '/menutrabajador');
      setState(() {
          print(datauser[0]['IdPersona']);
          int aux=int.parse(datauser[0]['IdPersona']);
          _usuario.id= aux;
          _usuario.nombre= datauser[0]['PrimerNombre'];
          _usuario.telefono= datauser[0]['Telefono'];     
          _usuario.clave= datauser[0]['Clave'];
      });
    }
    return datauser;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        _Fondo(context),
        _loginFrom(context),
      ],
    ));
  }

  Widget _loginFrom(context) {
    final bloc = Provider.of(context);
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 180.0,
            ),
          ),
          Container(
            width: size.width * 0.75,
            margin: EdgeInsets.symmetric(vertical: 30.0),
            padding: EdgeInsets.symmetric(vertical: 60.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3.0,
                      offset: Offset(0.0, 5.0),
                      spreadRadius: 3.0)
                ]),
            child: Column(
              children: <Widget>[
                Text(
                  'Ingreso',
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(height: 60.0),
                _email(bloc),
                SizedBox(height: 30.0),
                _clave(bloc),
                SizedBox(height: 30.0),
                _boton(bloc),
              ],
            ),
          ),
          InkWell(
            onTap: (){Navigator.pushReplacementNamed(context, '/loginadmin');},
            child: Text('ingresar como administrador'),
          ),
          SizedBox(
            
            height: 80.0,
          )
        ],
      ),
    );
  }

  Widget _email(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(
                Icons.email_outlined,
                color: Colors.black,
              ),
              hintText: 'ejemplo@correo.com',
              labelText: 'Correo electronico',
              errorText: snapshot.error,
            ),
            onChanged: bloc.changeEmail,
          ),
        );
      },
    );
  }

  Widget _clave(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.claveStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(
                Icons.lock_outline,
                color: Colors.black,
              ),
              labelText: 'Contraseña',
              errorText: snapshot.error
            ),
            onChanged: bloc.changeClave,
          ),
        );
      },
    );
  }

  Widget _boton(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.formValidStream ,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return RaisedButton(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            child: Text('Ingresar'),
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          elevation: 0.0,
          color: Color.fromRGBO(189, 219, 255, 1),
          onPressed: snapshot.hasData ? ()=>_login(bloc): null,
        );
      },
    );
  }
/*
  _login(LoginBloc bloc){
    print('correo ${bloc.email}');
    print('clave ${bloc.clave}');
  }
*/
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
          padding: EdgeInsets.only(top: 50.0),
          child: Column(
            children: <Widget>[
              Image.asset(
                'assets/images/medico.png',
                width: 100,
                height: 100,
              ),
              SizedBox(
                height: 10.0,
                width: double.infinity,
              ),
              Text(
                'Login Medico',
                style: TextStyle(color: Colors.black, fontSize: 25.0),
              )
            ],
          ),
        )
      ],
    );
  }
}

// =>
// <> 