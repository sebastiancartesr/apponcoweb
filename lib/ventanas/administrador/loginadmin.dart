import 'package:demo1/controllers/provider.dart';
import 'package:flutter/material.dart';
import 'package:demo1/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:demo1/controllers/usuario.dart';
import 'package:demo1/controllers/login_bloc.dart';
/*
class Loginadmin extends StatefulWidget {
  //Loginpaciente({Key key}) : super(key: key);
  @override
  _LoginadminState createState() => _LoginadminState();
}

class _LoginadminState extends State<Loginadmin> { 
  TextEditingController controllerUser = new TextEditingController();
  TextEditingController controllerPass = new TextEditingController();
  final Usuario _usuario = new Usuario();
  String mensaje = '';
     Future <List> login() async{
      
      final response = await http.post("http://192.168.1.30/demo1/loginadmin.php", body:{
      "Correo":controllerUser.text,
      "clave":controllerPass.text,
      });
      var datauser = json.decode(response.body);
      if(datauser.length == 0){
        setState(() {
          mensaje="usuario o contraseña incorrecta";});
      }else{
        Navigator.popAndPushNamed(context, '/menuadmin');
      setState(() {
          int aux=int.parse(datauser[0]['IdPersona']);
          _usuario.id= aux;
          _usuario.nombre= datauser[0]['PrimerNombre'];
          _usuario.telefono= datauser[0]['Telefono'];     
          _usuario.clave= datauser[0]['Clave'];
          _usuario.centro= datauser[0]['IdCetrooncologico'];
          print(_usuario.centro);
      });
    }
    return datauser;
    }
  
  @override
  Widget build(BuildContext context) {
    _navegarmedico() async{
      Navigator.pushReplacementNamed(context, '/loginmedico');}
    return Scaffold(
       resizeToAvoidBottomPadding: false,
       body: Form(
         child: Container(
           decoration: new BoxDecoration(
             image: new DecorationImage(
               image: new AssetImage("assets/images/fondo.png"),
               fit: BoxFit.cover
             ),
           ),
           child: Column(
             children:<Widget>[
               
               
               new Container(
                 padding: EdgeInsets.only(top:77.0),
                 child: new CircleAvatar(
                   backgroundColor: Color(0xF81F7F3),
                   child: new Image(
                     width: 300,
                     height: 300,
                     image: new AssetImage('assets/images/paciente.png'),
                   ) ,
                 ),
                 width: 250,
                 height: 250,
                 decoration: BoxDecoration(
                   shape: BoxShape.circle
                 ),
               ),
               Container(
                 height: MediaQuery.of(context).size.height / 2,
                 width: MediaQuery.of(context).size.width,
                 padding: EdgeInsets.only(top: 93), 
                 child: Column(
                   children: <Widget> [
                     
                     Container(
                       width: MediaQuery.of(context).size.width / 1.2,
                       padding: EdgeInsets.only(
                         top: 4, left: 16, right: 16, bottom: 4
                       ),
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.all(Radius.circular(50)),
                         color: Colors.white,
                         boxShadow: [
                           BoxShadow(
                             color: Colors.black12,
                             blurRadius: 5 
                           ),
                        
                         ],
                       ),
                       child: TextFormField(
                         controller: controllerUser,
                         decoration: InputDecoration(
                           icon: Icon(
                             Icons.email,
                             color: Colors.black,
                           ),
                           hintText:'Usuario' 
                         ),
                       ),
                     ),
                     Container(
                       width: MediaQuery.of(context).size.width / 1.2,
                       height: 50,
                       margin: EdgeInsets.only(
                         top: 32
                       ),
                       padding: EdgeInsets.only(
                         top: 4, left: 16, bottom: 4
                       ),
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.all(Radius.circular(50)),
                         color: Colors.white,
                         boxShadow: [
                           BoxShadow(
                             color: Colors.black12,
                             blurRadius: 5
                           )
                         ]
                       ),
                       child: TextField(
                         controller: controllerPass,
                         obscureText: true,
                         decoration: InputDecoration(
                           icon: Icon(
                             Icons.vpn_key,
                             color: Colors.black
                           ),
                           hintText:'Password'
                         ),
                       ),
                     ),
       
                    
                     
                     InkWell(
                          child: Align(
                         alignment: Alignment.centerRight,
                         child: Padding(
                           padding: const EdgeInsets.only(
                             top: 6,
                             right: 32,
                           ),
                           child: Text(
                             'Ingresar como medico aqui',
                             style: TextStyle(
                               color: Colors.black,
                               )
                           ),
                           
                         ),
                         
                       ),
                       onTap: (
                         _navegarmedico
                       ),
                     ),
                     
                     Spacer(),
                     new RaisedButton( 
                     child: new Text("ingresar"),
                     color: Colors.orangeAccent,
                     shape: new RoundedRectangleBorder(
                       borderRadius: new BorderRadius.circular(30.0)
                     ),
                     onPressed:(){
                       login();
                     },
                     ),
                     Text(mensaje,
                     style: TextStyle(fontSize: 25.0, color: Colors.red),)
                   ],
                 ),               
               )
             ],
           ),
         ),
         ),
    );
  }
}
*/

class Loginadmin extends StatefulWidget {
  const Loginadmin({Key key}) : super(key: key);

  @override
  _LoginadminState createState() => _LoginadminState();
}

class _LoginadminState extends State<Loginadmin> {
    final Usuario _usuario = new Usuario();

    Future <List> _login(LoginBloc bloc) async{
    final response = await http.post("http://192.168.1.30/demo1/loginadmin.php", body:{
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
