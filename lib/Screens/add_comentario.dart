import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

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
  String id = '';

  File? image = null; //Es igual que File? image
  final ImagePicker picker = ImagePicker();

  Future <void> agregar() async{
    var url = Uri.parse('https://ivan.stuug.com/Apps/MasaMadre/add_comentario.php');

    var response = await http.post(url, body: {
      'nombre' : nombre,
      'comentario' : comentario,
    });
    if (response.body != '0') {
      id = response.body;
      await uploadPicture();
      Navigator.pop(context);
    }

    print('Respuesta: ' + response.body);
    //Navigator.of(context).pop();
  }

  Future cortar(picked) async {
    CroppedFile? cortado = await ImageCropper().cropImage(
        sourcePath: picked.path,
        aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0)
    );
    if(cortado != null){
      setState(() {
        image = File(cortado.path);
      });
    }
  }

  Dio dio = new Dio();

  Future<void> uploadPicture() async {
    try{
      String filename = image!.path.split('/').last;
      FormData formData = FormData.fromMap({
        'id':id,
        'file': await MultipartFile.fromFile(
            image!.path, filename: filename
        )
      });

      await dio.post('https://ivan.stuug.com/Apps/MasaMadre/foto_comentario.php',data: formData).then((respuesta){
        if(respuesta == '1'){
          print('Se guardo');
        } else{
          print(respuesta);
        }
      });

    }
    catch(e){
      print(e.toString());
    }
  }

  Future seleccionar_imagen(op) async {
    var pickedFile;
    if(op == 1){
      pickedFile = await picker.pickImage(source: ImageSource.camera);
    }else{
      pickedFile = await picker.pickImage(source: ImageSource.gallery);
    }

    setState(() {
      if(pickedFile != null){
        //image = File(pickedFile.path);
        cortar(File(pickedFile.path));
      }
    });
  }

  seleccionar(){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            contentPadding: EdgeInsets.all(0),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.of(context).pop();
                      seleccionar_imagen(1);
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(width: 1, color: Colors.grey)
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(child: Text('Tomar una foto', style: TextStyle(fontSize: 16),)),
                          Icon(Icons.camera_alt, color: Colors.blue,),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.of(context).pop();
                      seleccionar_imagen(2);
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Expanded(child: Text('Tomar de galeria', style: TextStyle(fontSize: 16),)),
                          Icon(Icons.image, color: Colors.blue,),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){Navigator.of(context).pop();},
                    child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.only(bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20))
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Cancelar', style: TextStyle(color: Colors.white),),
                          ],
                        )
                    ),
                  ),
                ],
              ),
            ),
          );
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
                controller: c_nombre,
                decoration: const InputDecoration(hintText: 'Nombre'),
              ),
              const SizedBox(height: 15,),
              TextField(
                controller: c_comentario,
                decoration: const InputDecoration(hintText: 'Comentario'),
              ),
              SizedBox(height: 20,),
              image == null ? Center() : Image.file(image!),
              ElevatedButton(
                  onPressed: (){
                    seleccionar();
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.brown),
                  child: Text('Tomar foto',style: TextStyle(color: Colors.white),)
              ),
              SizedBox(height: 20,),
              const SizedBox(height: 15,),
              ElevatedButton(
                  onPressed: (){
                    nombre = c_nombre.text;
                    comentario = c_comentario.text;
                    agregar();
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.brown),
                  child: const Text('Agregar', style: TextStyle(color: Colors.white),))
            ],
          ),
        ),
      ),
    );
  }
}
