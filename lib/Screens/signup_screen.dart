import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages.dart';
import 'package:http/http.dart' as http;

class Registrarse extends StatefulWidget {
  const Registrarse({super.key});

  @override
  State<Registrarse> createState() => _RegistrarseState();
}

class _RegistrarseState extends State<Registrarse> {
  TextEditingController userController = TextEditingController(), emailController = TextEditingController(), passwordController = TextEditingController();
  String id = "", foto = "1.jpg";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color(0xFF9E5726).withOpacity(0.9),
                Colors.black,
              ]
          )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: ListView(
          children: [
            const SizedBox(height: 10,),
            const Center(child: Text("Sign Up", style: TextStyle(
                fontSize: 55, color: Colors.white, fontFamily: "Titulos"),)),
            const SizedBox(height: 40,),
            Column(
              children: [
                Container(
                  width: 360,
                  child: TextFormField(
                    controller: userController,
                    style: TextStyle(color:Colors.white),
                    decoration: InputDecoration(
                        hintText: "Username",
                        hintStyle: TextStyle(color: Colors.grey[700]),
                        filled: true,
                        fillColor: const Color(0xFF2C1B0C),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white
                              .withOpacity(0.6), width: 2),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        prefixIcon: Icon(Icons.perm_identity_outlined,
                            color: Colors.white.withOpacity(0.6))
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  width: 360,
                  child: TextFormField(
                    style: TextStyle(color:Colors.white),
                    controller: emailController,
                    decoration: InputDecoration(
                        hintText: "Email",
                        hintStyle: TextStyle(color: Colors.grey[700]),
                        filled: true,
                        fillColor: const Color(0xFF2C1B0C),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white
                              .withOpacity(0.6), width: 2),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        prefixIcon: Icon(Icons.email_outlined,
                          color: Colors.white.withOpacity(0.6),)
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  width: 360,
                  child: TextFormField(
                    style: TextStyle(color:Colors.white),
                    controller: passwordController,
                    decoration: InputDecoration(
                        hintText: "Password",
                        hintStyle: TextStyle(color: Colors.grey[700]),
                        filled: true,
                        fillColor: const Color(0xFF2C1B0C),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white
                              .withOpacity(0.6), width: 2),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        prefixIcon: Icon(Icons.lock_outline,
                            color: Colors.white.withOpacity(0.6))
                    ),
                    textInputAction: TextInputAction.next,
                    obscureText: true,
                  ),
                ),
                SizedBox(height: 25,),
                Container(
                  width: 200,
                  padding: const EdgeInsets.only(top: 25),
                  child: ElevatedButton(
                    onPressed: () {signUp();},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    child: const Text(
                        "Sign Up", style: TextStyle(color: Colors.black)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future signUp() async{
    var url = Uri.parse("https://ivan.stuug.com/Apps/MasaMadre/register.php");
    var response = await http.post(url, body: {
      "Username" : userController.text,
      "Email" : emailController.text,
      "Password" : passwordController.text,
    });
    
    var data = jsonDecode(response.body);
    if(emailController.text.isNotEmpty && userController.text.isNotEmpty && passwordController.text.isNotEmpty){
      if(data == "Error"){
        return showDialog(context: context, builder: (BuildContext context){
          return const AlertDialog(
            title: Center(child: Text("Error", style: TextStyle(color: Colors.red),)),
            content: Text("Usuario ya existente"),
          );
        });
      }else{
        pageRoute(emailController.text, passwordController.text, userController.text,id,foto);
      }

    }else{
      return showDialog(context: context, builder: (BuildContext context){
        return const AlertDialog(
          title: Center(child: Text("Error", style: TextStyle(color: Colors.red),)),
          content: Text("Campos vacios. Vuelva a intentarlo"),
        );
      });
    }
}
  void pageRoute(String email, String password, String username, String id,String foto) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("email", email);
    await pref.setString("password", password);
    await pref.setString("username", username);
    await pref.setString("id", id);
    await pref.setString("foto", foto);
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => index()), (route) => false);

  }
}
