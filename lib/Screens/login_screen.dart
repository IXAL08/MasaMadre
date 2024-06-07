import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:proyecto/Screens/forgotpassword_screen.dart';
import 'pages.dart';
import 'package:proyecto/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String username = "", id = "",foto="";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLogin();

  }

  void checkLogin() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? emailVal = pref.getString("email"), passVal = pref.getString("password"), userVal = pref.getString("username");
    if( emailVal != null && passVal != null && userVal != null){
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => index()), (route) => false);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BackgroundImage(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: GestureDetector(
            onTap: () {
              final FocusScopeNode focus = FocusScope.of(context);
              if (!focus.hasPrimaryFocus && focus.hasFocus){
                FocusManager.instance.primaryFocus?.unfocus();
              }
            },
            child: ListView(
              children: [
                Container(
                  height: 300,
                    child: Center(
                        child: Image.asset("Media/images/MasaMadre_LogoBlanco.png")
                    )
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[600]?.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: TextFormField(
                                controller: emailController,
                                style: const TextStyle(color: Colors.white, fontSize: 20),
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(vertical: 20),
                                  border: InputBorder.none,
                                  hintText: "Correo electronico",
                                  hintStyle: TextStyle(fontFamily: 'Titulos',color: Colors.white70),
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20),
                                    child: Icon(
                                      Icons.email_rounded,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  )
                                ),
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[600]?.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: TextFormField(
                              controller: passwordController,
                              style: const TextStyle(color: Colors.white, fontSize: 20),
                              decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(vertical: 20),
                                  border: InputBorder.none,
                                  hintText: "Contraseña",
                                  hintStyle: TextStyle(fontFamily: 'Titulos',color: Colors.white70),
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20),
                                    child: Icon(
                                      Icons.lock,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  )
                              ),
                              textInputAction: TextInputAction.next,
                              obscureText: true,
                            ),
                          ),
                          InkWell(child: const Text("Forgot Password?",style: TextStyle(color: Colors.white,fontSize: 18),), onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPassword()));},),
                        ],
                      ),
                      Container(
                        width: 200,
                        padding: const EdgeInsets.only(top: 25),
                        child: ElevatedButton(
                          onPressed: () {Login();},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                          ),
                          child: const Text("Login", style: TextStyle(color: Colors.black)),
                        ),
                      ),
                      Container(
                        width: 185,
                        padding: const EdgeInsets.only(top: 5),
                        child: ElevatedButton(
                          onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => Registrarse()));},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey,
                          ),
                          child: const Text("Sign Up", style: TextStyle(color: Colors.black)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
  Future Login() async{
    var url = Uri.parse("https://ivan.stuug.com/Apps/MasaMadre/login.php");
    var response = await http.post(url, body: {
      "Email" : emailController.text,
      "Password" : passwordController.text,
    });
    
    var data = jsonDecode(response.body);
    if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty){
      if(data['status'] == 'Success'){
        username = data['Username'];
        id = data['ID_Usuarios'];
        foto = data['Foto'];
        pageRoute(emailController.text, passwordController.text,username,id,foto);
      }else{
        return showDialog(context: context, builder: (BuildContext context){
          return const AlertDialog(
            title: Center(child: Text("Error", style: TextStyle(color: Colors.red),)),
            content: Text("Campos incorretos. Vuelva a intentarlo"),
          );
        });
      }
    } else{
      return showDialog(context: context, builder: (BuildContext context){
        return const AlertDialog(
          title: Center(child: Text("Error", style: TextStyle(color: Colors.red),)),
          content: Text("Campos en blanco. Vuelva a intentarlo"),
        );
      });
    }
  }

  void pageRoute(String email, String password, String username, String id, String foto) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("email", email);
    await pref.setString("password", password);
    await pref.setString("username", username);
    await pref.setString("id", id);
    await pref.setString("foto", foto);
    print("email: " + email + " password: " + password + " username: " + username + " id: " + id + "foto: " + foto);
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => index()), (route) => false);

  }

}

