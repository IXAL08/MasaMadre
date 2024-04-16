import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditarPerfil extends StatefulWidget {
  const EditarPerfil({super.key});

  @override
  State<EditarPerfil> createState() => _EditarPerfilState();
}

class _EditarPerfilState extends State<EditarPerfil> {
  String email = "", username = "";
  TextEditingController userController = TextEditingController(), emailController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void getCred() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      email = pref.getString("email")!;
      username = pref.getString("username")!;
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
                      onTap: () {},
                      child: CircleAvatar(radius: 70, backgroundImage: AssetImage("Media/images/1.jpg"),)
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
                    child: ElevatedButton(onPressed: () {GuardarDatos(emailController.text, userController.text);}, child: Text("Guardar datos", style: TextStyle(color: Colors.white),),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    )
                )
              ],
            ),
          ]
        ),
      ),
    );
  }

  void GuardarDatos(String email, String username) async{
    if(emailController.text.isNotEmpty && userController.text.isNotEmpty){
      SharedPreferences pref = await SharedPreferences.getInstance();

      await pref.setString("email", email);
      await pref.setString("username", username);
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => index()), (route) => false);
    }else{
      return showDialog(context: context, builder: (BuildContext context){
        return const AlertDialog(
          title: Center(child: Text("Error", style: TextStyle(color: Colors.red),)),
          content: Text("Campos en blanco. Vuelva a intentarlo"),
        );
      });
    }
  }
}
