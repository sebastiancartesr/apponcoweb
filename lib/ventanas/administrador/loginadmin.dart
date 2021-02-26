import 'package:demo1/controllers/provider.dart';
import 'package:flutter/material.dart';
import 'package:demo1/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:demo1/controllers/usuario.dart';
import 'package:demo1/controllers/login_bloc.dart';

class Loginadmin extends StatefulWidget {
  const Loginadmin({Key key}) : super(key: key);

  @override
  _LoginadminState createState() => _LoginadminState();
}

class _LoginadminState extends State<Loginadmin> {
    final Usuario _usuario = new Usuario();

    Future <List> Login_Admin(LoginBloc bloc) async{
    final response = await http.post("http://192.168.1.27/demo1/loginadmin.php", body:{
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


      /*
      setState(() {
        mensaje="usuario o contraseña incorrecta";});*/
      
    }else{
      Navigator.popAndPushNamed(context, '/menuadmin');
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
            onTap: (){Navigator.pushReplacementNamed(context, '/loginmedico');},
            child: Text('ingresar como Medico'),
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
          onPressed: snapshot.hasData ? ()=>Login_Admin(bloc): null,
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
                'assets/images/admin.png',
                width: 100,
                height: 100,
              ),
              
              SizedBox(
                height: 10.0,
                width: double.infinity,
              ),
              Text(
                'Login Administrador',
                style: TextStyle(color: Colors.black, fontSize: 25.0),
              )
            ],
          ),
        )
      ],
    );
  }
}
