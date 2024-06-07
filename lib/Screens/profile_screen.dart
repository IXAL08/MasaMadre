import 'package:flutter/material.dart';
import 'package:proyecto/Screens/editProfile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Perfil extends StatefulWidget {
  const Perfil({super.key});

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  String email = "", password = "", username = "",id="",foto="";

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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 30),
              child: CircleAvatar(radius: 70, backgroundImage: NetworkImage("https://ivan.stuug.com/Apps/MasaMadre/fotos/$foto"),),
            ),
            Text("$username",style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),
            Text("$email", style: TextStyle(fontSize: 22)),
            SizedBox(height: 20,),
            Container(
              child: ElevatedButton(onPressed: () {Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditarPerfil()));}, child: Text("Editar perfil", style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              )
            )
          ],
        ),
      ),
    );
  }
}
