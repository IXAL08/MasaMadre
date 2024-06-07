import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AgregarComentario extends StatefulWidget {
  const AgregarComentario({super.key});

  @override
  State<AgregarComentario> createState() => _AgregarComentarioState();
}

class _AgregarComentarioState extends State<AgregarComentario> {

  var c_nombre = TextEditingController();
  var c_comentario = TextEditingController();

  String nombre = '';
  String comentario = '';

  Future <void> agregar() async{
    var url = Uri.parse('https://ivan.stuug.com/Apps/MasaMadre/add_comentario.php');

    var response = await http.post(url, body: {
      'nombre' : nombre,
      'comentario' : comentario,
    });

    print('Respuesta: ' + response.body);
    Navigator.of(context).pop();
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
      body: GestureDetector(
        onTap:(){
          final FocusScopeNode focus = FocusScope.of(context);
          if(!focus.hasPrimaryFocus && focus.hasFocus){
            FocusManager.instance.primaryFocus?.unfocus();
          }},
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              const SizedBox(height: 5,),
              TextField(
                controller: c_nombre,
                decoration: const InputDecoration(hintText: 'Nombre'),
              ),
              const SizedBox(height: 15,),
              TextField(
                controller: c_comentario,
                decoration: const InputDecoration(hintText: 'Comentario'),
              ),
              const SizedBox(height: 15,),
              ElevatedButton(
                  onPressed: (){
                    nombre = c_nombre.text;
                    comentario = c_comentario.text;
                    agregar();
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF9E5726)),
                  child: const Text('Agregar', style: TextStyle(color: Colors.white),))
            ],
          ),
        ),
      ),
    );
  }
}
