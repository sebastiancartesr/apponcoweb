import 'package:demo1/ventanas/medico/bienvenida.dart';
import 'package:flutter/material.dart';
import 'package:demo1/main.dart';
import 'package:demo1/controllers/usuario.dart';
import 'package:demo1/ventanas/medico/bitacoraprueba.dart';
import 'package:demo1/ventanas/medico/verpacientesweb.dart';
import 'package:demo1/ventanas/medico/veralertaspaciente.dart';
import 'package:demo1/ventanas/medico/agregarpaciente.dart';
import 'package:demo1/ventanas/medico/ingresarbitacorasweb.dart';

class MenuTrabajador extends StatefulWidget {
  MenuTrabajador({Key key}) : super(key: key);
  
  @override
  _MenuTrabajadorState createState() => _MenuTrabajadorState();
}

class _MenuTrabajadorState extends State<MenuTrabajador> {
  
  int _selectDrawer = 0;
  _getDrawer(int pos){
    switch(pos){
      case 0: return Bienvenido();
      case 1: return VerBitacoramedicoweb();
      case 2: return VerPacienteweb();
      case 3: return VerAlertas();
      case 4: return Ingresarbitacora();
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
        title: Text("AppOnco"),
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
              onTap: (){  
                _onSelect(2);             
              },
            ),
            ListTile(
              leading: Icon(Icons.message),
              title: Text('Notificaciones'),
            ),
            ListTile(
              title: Text('Ver Alertas'),
              onTap: (){ 
                _onSelect(3);           
              },
            ),
            ListTile(
              title: Text('Enviar Notificaciones  '),
              onTap: (){               
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
            ),  
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
              }, 
            ),
          ]
        )
      ),
    body: _getDrawer(_selectDrawer),
    );
  }
}
 

