import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:proyecto/Screens/index.dart';
import 'package:proyecto/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var emailController = TextEditingController();
  var passController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void checkLogin() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? val = pref.getString("login");
    if(val != null){
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
          body: ListView(
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
                            controller: passController,
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
                        const Text("Forgot Password?",style: TextStyle(color: Colors.white,fontSize: 18),),
                      ],
                    ),
                    Container(
                      width: 200,
                      padding: const EdgeInsets.only(top: 25),
                      child: ElevatedButton(
                        onPressed: () {IniciarSesion();},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                        child: const Text("Login", style: TextStyle(color: Colors.black)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void IniciarSesion() async{
    if(passController.text.isNotEmpty && emailController.text.isNotEmpty){
      var response = await http.post(Uri.parse("https://reqres.in/api/login"),body:{
        //eve.holt@reqres.in, cityslicka
        "email": emailController.text,
        "password": passController.text
      });
      if(response.statusCode==200){
        final body = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Token : ${body['token']}")));
        pageRoute(body['token']);
      }else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid Credentials")));
      }
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Blank Value Found")));
    }


  }

  void pageRoute(String Token) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("login", Token);
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => index()), (route) => false);
  }

}
