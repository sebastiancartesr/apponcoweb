import 'package:demo1/ventanas/medico/menutrabajador.dart';
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
void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        "/loginmedico" : (BuildContext context) => Loginmedico(),
        "/menutrabajador":(BuildContext context) => MenuTrabajador(),
        "/verbitacoramedico":(BuildContext context) => VerBitacoramedico(),
        "/verperfilmedico":(BuildContext context) =>VerPerfilmedico(),
        "/agregarpaciente":(BuildContext context) => FormScreen(),
        "/agregarbitacora":(BuildContext context) => Bitacora(),
        "/menuadmin":(BuildContext context) => MenuAdmin(),
        "/loginadmin":(BuildContext context) => Loginadmin(),
        
      }
      ,
      home: Loginmedico()
    );
  }
}

class Loginmedico extends StatefulWidget {
  //Loginmedico({Key key}) : super(key: key);
  

  //@override
  _LoginmedicoState createState() => _LoginmedicoState();
}

class _LoginmedicoState extends State<Loginmedico> { 
  
  
  TextEditingController controllerUser = new TextEditingController();
  TextEditingController controllerPass = new TextEditingController();
  final Usuario _usuario = new Usuario();
  String mensaje = '';


   Future <List> login() async{
    final response = await http.post("http://192.168.1.108/demo1/loginfuncionarioweb.php", body:{
      "Correo":controllerUser.text,
      "clave":controllerPass.text,
    });
    var datauser = json.decode(response.body);

    if(datauser.length == 0){
      setState(() {
        mensaje="usuario o contraseña incorrecta";});
    }else{
      setState(() {

          int aux=int.parse(datauser[0]['IdPersona']);
          _usuario.id= aux;
          _usuario.nombre= datauser[0]['PrimerNombre'];
          _usuario.telefono= datauser[0]['Telefono'];     
          _usuario.clave= datauser[0]['Clave'];
          _usuario.idMedico= datauser[0]['IdEspecialista'];
          print(datauser[0]['IdPersona']);
          print(datauser[0]['IdEspecialista']);
      });
      if(datauser[0]['NombreRol']=='medico' || datauser[0]['NombreRol']=='asistente'){
        Navigator.popAndPushNamed(context, '/menutrabajador');
      }else{
        
      }
      

    }
    return datauser;
    }
  


  @override
  Widget build(BuildContext context) {
      _navegaradministrador() async{
      Navigator.pushReplacementNamed(context, '/loginadmin');}
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
                     width: 500,
                     height: 500,
                     image: new AssetImage('assets/images/medico.png'),
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
                             'Ingresar como administrador',
                             style: TextStyle(
                               color: Colors.grey,
                               )
                           ),
                           
                         ),
                         
                       ),
                       onTap: (
                         _navegaradministrador
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


// =>
// <> 