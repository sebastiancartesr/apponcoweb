import 'package:demo1/ventanas/medico/bienvenida.dart';
import 'package:flutter/material.dart';
import 'package:demo1/main.dart';
import 'package:demo1/controllers/usuario.dart';
import 'package:demo1/ventanas/medico/bitacoraprueba.dart';
import 'package:demo1/ventanas/medico/verpacientesweb.dart';
import 'package:demo1/ventanas/medico/veralertaspaciente.dart';
import 'package:demo1/ventanas/medico/agregarpaciente.dart';
import 'package:demo1/ventanas/medico/ingresarbitacorasweb.dart';
import 'package:demo1/ventanas/medico/enviarnotifi.dart';
import 'package:demo1/ventanas/medico/elegirbitacora.dart';
import 'package:demo1/ventanas/medico/verbitacorafinal.dart';

class MenuTrabajador extends StatefulWidget {
  MenuTrabajador({Key key}) : super(key: key);
  
  @override
  _MenuTrabajadorState createState() => _MenuTrabajadorState();
}

class _MenuTrabajadorState extends State<MenuTrabajador> {
  
  int _selectDrawer = 0;
  _getDrawer(int pos){
    switch(pos){
      case 0: return Dashboard();
      case 1: return VerBitacoramedicoweb();
      //case 2: return VerPacienteweb();
      case 2: return VerPacientedos();
      case 3: return VerAlertas();
      case 4: return Ingresarbitacora();
      case 5: return EnviarNotificacion();
    }
  }
  _onSelect(int pos){
    setState(() {
      _selectDrawer = pos;
    });
    
  }
  final Usuario _usuario = new Usuario();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("AppOnco",style: TextStyle(letterSpacing: 1.2)),),
      ),
      drawer: Drawer(
        child: ListView(
          children:<Widget>[

            UserAccountsDrawerHeader(
              accountName: Text(_usuario.nombre),
              accountEmail: Text((_usuario.id).toString()),
              currentAccountPicture: ( 
                CircleAvatar(
                  child: Image.asset(
                  'assets/images/doctor.png',
              fit: BoxFit.cover,
            ),
              )
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: (){  
                _onSelect(0);     
              },
            ),
            ListTile(
              leading: Icon(Icons.supervised_user_circle),
              title: Text('Paciente'),         
            ),
            ListTile(
              title: Text('Agregar Paciente'),
              onTap: (){  
                Navigator.popAndPushNamed(context,'/agregarpaciente');     
              },
            ),
            ListTile(
              title: Text('Lista Paciente'),
              //onTap: (){   _onSelect(2);             },
                onTap: (){ 
                Navigator.popAndPushNamed(context, '/verpacientestres');
                
              }, 
            ),
            ListTile(
              leading: Icon(Icons.message),
              title: Text('Notificaciones'),
            ),
            ListTile(
              title: Text('Ver alertas de riesgo'),
              onTap: (){ 
                _onSelect(3);           
              },
            ),
            /*
            ListTile(
              title: Text('Enviar Notificaciones  '),
              onTap: (){    
                _onSelect(5);           
              },           
            ),
            ListTile(
              leading: Icon(Icons.perm_contact_calendar),
              title: Text('Bitacoras'),          
            ),
            ListTile(
              title: Text('Ingresar Bitacora'),
              onTap: (){ 
                   _onSelect(4);           
              },           
            ),  */
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Perfil'),
         
            ),
            ListTile(
              title: Text('Ver perfil'),
              onTap: (){
                Navigator.popAndPushNamed(context, '/verperfilmedico');               
              },           
            ),
            ListTile(
              
              title: Text('Cerrar sesion'),
              onTap: (){ 
                Navigator.popAndPushNamed(context, '/loginmedico');
              }, 
            ),

          ]
        )
      ),
    body: _getDrawer(_selectDrawer),
    );
  }
}
 

