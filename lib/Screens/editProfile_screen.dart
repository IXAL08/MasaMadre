import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'pages.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class EditarPerfil extends StatefulWidget {
  const EditarPerfil({super.key});

  @override
  State<EditarPerfil> createState() => _EditarPerfilState();
}

class _EditarPerfilState extends State<EditarPerfil> {
  String email = "", username = "", id = "", password = "",foto = "";
  TextEditingController userController = TextEditingController(), emailController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCred();
  }

  Future getCred() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      email = pref.getString("email")!;
      password = pref.getString("password")!;
      username = pref.getString("username")!;
      id = pref.getString("id")!;
      foto = pref.getString("foto")!;
    });
    print("email: " + email + " password: " + password + " username: " + username + " id: " + id + "foto: " + foto);
  }

  File? image = null; //Es igual que File? image
  final ImagePicker picker = ImagePicker();


  Future cortar(picked) async {
    CroppedFile? cortado = await ImageCropper().cropImage(
        sourcePath: picked.path,
        aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0)
    );
    if(cortado != null){
      setState(() {
        image = File(cortado.path);
        SubirImagen();
      });
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
      body: Center(
        child: ListView(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 30),
                  child: InkWell(
                      onTap: () {seleccionar();},
                      child: CircleAvatar(radius: 70, backgroundImage: image == null ? NetworkImage("https://ivan.stuug.com/Apps/MasaMadre/fotos/$foto") : FileImage(image!) as ImageProvider)
                  ),
                ),
                Container(
                  width: 360,
                  child: TextFormField(
                    controller: userController,
                    style: TextStyle(color:Colors.white),
                    decoration: InputDecoration(
                        hintText: "Editar username",
                        hintStyle: TextStyle(color: Colors.white60),
                        filled: true,
                        fillColor: Colors.grey,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white
                              .withOpacity(0.6), width: 2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        prefixIcon: Icon(Icons.perm_identity_outlined,
                            color: Colors.white.withOpacity(0.8))
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  width: 360,
                  child: TextFormField(
                    controller: emailController,
                    style: TextStyle(color:Colors.white),
                    decoration: InputDecoration(
                        hintText: "Editar Correo electrónico",
                        hintStyle: TextStyle(color: Colors.white60),
                        filled: true,
                        fillColor: Colors.grey,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white
                              .withOpacity(0.6), width: 2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        prefixIcon: Icon(Icons.email_outlined,
                            color: Colors.white.withOpacity(0.8))
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                    width: 300,
                    child: ElevatedButton(onPressed: () {
                      setState(() {
                        GuardarDatos(emailController.text, userController.text, id, foto);
                      });
                    }, child: Text("Guardar datos", style: TextStyle(color: Colors.white),),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    )
                ),
              ],
            ),
          ]
        ),
      ),
    );
  }

  Future GuardarDatos(String email, String username, String id, String foto) async{
    var url =Uri.parse("https://ivan.stuug.com/Apps/MasaMadre/editarPerfil.php");
    var response = await http.post(url,body: {
      "Username": emailController.text,
      "Email": userController.text,
      "ID_Usuarios": id,
      "Foto" : foto
    });

    if(emailController.text.isNotEmpty && userController.text.isNotEmpty){
      if(response.statusCode == 200){
        var data = jsonDecode(response.body);
        if(data['status'] == 'Success'){
          SubirImagen();
          SharedPreferences pref = await SharedPreferences.getInstance();
          await pref.setString("email", email);
          await pref.setString("username", username);
          await pref.setString("foto", foto);

          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => index()), (route) => true);
        }else{
          return showDialog(context: context, builder: (BuildContext context){
            return const AlertDialog(
              title: Center(child: Text("Error", style: TextStyle(color: Colors.red),)),
              content: Text("Los datos no se guardaron correctamente."),
            );
          });
        }
      }else{
        return showDialog(context: context, builder: (BuildContext context){
          return const AlertDialog(
            title: Center(child: Text("Error", style: TextStyle(color: Colors.red),)),
            content: Text("Error response."),
          );
        });
      }
    }else{
      return showDialog(context: context, builder: (BuildContext context){
        return const AlertDialog(
          title: Center(child: Text("Error", style: TextStyle(color: Colors.red),)),
          content: Text("Campos en blanco. Vuelva a intentarlo"),
        );
      });
    }
  }

  Dio dio = new Dio();

  Future<void> SubirImagen() async{
    try{
      String filename = image!.path.split('/').last;

      FormData formdata = FormData.fromMap({
        'file': await MultipartFile.fromFile(
            image!.path, filename: filename
        )
      });

      await dio.post("https://ivan.stuug.com/Apps/MasaMadre/foto.php",data: formdata).then((respuesta){
        foto = respuesta.toString();
      });
    }catch(e){
      print(e.toString());
    }
  }
}
