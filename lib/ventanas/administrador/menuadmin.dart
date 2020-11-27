import 'package:demo1/ventanas/medico/bienvenida.dart';
import 'package:flutter/material.dart';
import 'package:demo1/main.dart';
import 'package:demo1/controllers/usuario.dart';
import 'package:demo1/ventanas/medico/bitacoraprueba.dart';
import 'package:demo1/ventanas/medico/verpacientesweb.dart';
import 'package:demo1/ventanas/medico/veralertaspaciente.dart';
import 'package:demo1/ventanas/medico/agregarpaciente.dart';
import 'package:demo1/ventanas/medico/ingresarbitacorasweb.dart';
import 'package:demo1/ventanas/administrador/agregarmedico.dart';
import 'package:demo1/ventanas/administrador/vertrabajadores.dart';

class MenuAdmin extends StatefulWidget {
  MenuAdmin({Key key}) : super(key: key);
  
  @override
  _MenuAdminState createState() => _MenuAdminState();
}

class _MenuAdminState extends State<MenuAdmin> {
  
  int _selectDrawer = 0;
  _getDrawer(int pos){
    switch(pos){
      case 0: return Bienvenido();
      case 2: return VerTrabajadores();
      
      
      case 1: return FormScreen2();
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
              title: Text('Personal'),         
            ),
            ListTile(
              title: Text('Agregar Trabajador'),
              onTap: (){  
                Navigator.popAndPushNamed(context,'/agregarpersonal');     
              },
            ),
            ListTile(
              title: Text('Lista Trabajadores'),
              onTap: (){  
                _onSelect(2);             
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
 

