import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:proyecto/Screens/add_comentario.dart';
import 'package:proyecto/Screens/editarcomentario.dart';
import 'package:proyecto/widgets/datos_comentario.dart';
import 'package:proyecto/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Comentario extends StatefulWidget {
  const Comentario({super.key});

  @override
  State<Comentario> createState() => _ComentarioState();
}

class _ComentarioState extends State<Comentario> {
  String email = "", password = "", username = "",id="";

  List<Datos_Comentarios> datos = [];
  bool loading = true;

  Future<List<Datos_Comentarios>> tomar_datos() async{
    var url = Uri.parse('https://ivan.stuug.com/Apps/MasaMadre/view_comentarios.php');
    var response = await http.post(url).timeout(Duration(seconds: 90));

    var datos = jsonDecode(response.body);
    //print(response.body);

    List<Datos_Comentarios> registros = [];

    for(datos in datos){
      registros.add(Datos_Comentarios.fromJson(datos));
    }

    return registros;
  }

  mostrar_alerta(id,nombre)
  {
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('Alerta'),
            content: SingleChildScrollView(
              child: Text('Realmente quieres eliminar el comentario '+nombre+"?"),
            ),
            actions: [
              TextButton(
                onPressed: (){
                  confirmar_eliminar(id);
                },
                child: Text('Eliminar', style: TextStyle(color: Colors.red),),
              ),
              TextButton(
                onPressed: (){Navigator.of(context).pop();},
                child: Text('Cancelar', style: TextStyle(color: Colors.blue),),
              )
            ],
          );
        }
    );
  }

  Future<void> confirmar_eliminar(id) async{
    var url = Uri.parse('https://ivan.stuug.com/Apps/MasaMadre/delete_comentario.php');
    var response = await http.post(url,body: {
      'id' : id
    }).timeout(Duration(seconds: 90));

    Navigator.of(context).pop();

    if(response.body == '1'){
      setState(() {
        datos = [];
        loading = true;
        tomar_datos().then((value){
          setState(() {
            datos.addAll(value);
            loading = false;
          });
        });
      });
    }
    else{
      print(response.body);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCred();
    tomar_datos().then((value){
      setState(() {
        datos.addAll(value);
        loading = false;
        print(datos);
      });
    });
  }

  void getCred() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      email = pref.getString("email")!;
      password = pref.getString("password")!;
      username = pref.getString("username")!;
      id = pref.getString("id")!;
    });
    print("email: " + email + " password: " + password + " username: " + username + " id: " + id);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 80),
          child: Image.asset("Media/images/MasaMadre_LogoNegro.png", height: 60,),
        ),
        iconTheme: const IconThemeData(color: Color(0xFF9E5726)),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            color: const Color(0xFFD6803C),
            height: 2.0,
          ),
        ),
      ),
      drawer: Dibujador(),
      body: loading == true ?
      Center(
        child: CircularProgressIndicator(color: Colors.blue,),
      )
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: datos.length,
              itemBuilder: (BuildContext context, int index){
                return Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.grey, width: 1)
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Image.network(datos[index].imagen!, width: 300,),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(datos[index].comentario!, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'ebgaramont'),),
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                                return EditarComentario(datos[index].id!, datos[index].comentario!, datos[index].imagen!);
                              })).then((value){
                                setState(() {
                                  datos = [];
                                  loading = true;
                                  tomar_datos().then((value){
                                    setState(() {
                                      datos.addAll(value);
                                      loading=false;
                                    });
                                  });
                                });
                              });
                            },
                            child: Icon(Icons.edit, color: Colors.green,),
                          ),
                          //Icon(Icons.edit, color: Colors.green,),
                          SizedBox(width: 10,),
                          GestureDetector(
                              onTap: (){
                                mostrar_alerta(datos[index].id,datos[index].nombre);
                              },
                              child: Icon(Icons.delete, color: Colors.red,)),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
            return AgregarComentario();
          })).then((value){
            setState(() {
              datos = [];
              loading = true;
              tomar_datos().then((value){
                setState(() {
                  datos.addAll(value);
                  loading=false;
                });
              });
            });
          });
        },
        child: Icon(Icons.add, color: Colors.white,),
        backgroundColor: Color(0xFF9E5726),
        shape: CircleBorder(),
      ),
    );
  }
}

