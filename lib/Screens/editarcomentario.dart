import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditarComentario extends StatefulWidget {

  String? id = '';
  String? comentario = '';

  EditarComentario(this.id, this.comentario,{Key? key}) : super(key : key);

  @override
  State<EditarComentario> createState() => _EditarComentarioState();
}

class _EditarComentarioState extends State<EditarComentario> {

  String comentario = '';

  final c_comentario = TextEditingController();

  Future <void> editar() async{
    var url = Uri.parse('https://ivan.stuug.com/Apps/MasaMadre/edit_comentarios.php');

    var response = await http.post(url, body: {
      'id' : widget.id,
      'comentario' : comentario,
    });

    print('Respuesta: ' + response.body);

    if(response.body == '1'){
      Navigator.of(context).pop();
    }
    else {
      print(response.body);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      c_comentario.text = widget.comentario!;
    });
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
                controller: c_comentario,
                decoration: const InputDecoration(hintText: 'Comentario'),
              ),
              const SizedBox(height: 15,),
              ElevatedButton(
                  onPressed: (){
                    comentario = c_comentario.text;
                    editar();
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.brown),
                  child: const Text('Guardar cambios', style: TextStyle(color: Colors.white),))
            ],
          ),
        ),
      ),
    );
  }
}
