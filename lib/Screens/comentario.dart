import 'package:flutter/material.dart';
import 'package:proyecto/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:proyecto/widgets/widgets.dart';

class Comentario extends StatefulWidget {
  const Comentario({super.key});

  @override
  State<Comentario> createState() => _ComentarioState();
}

class _ComentarioState extends State<Comentario> {
  String email = "", password = "", username = "",id="";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCred();
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
      body: MaterialApp(
        initialRoute: lista.ROUTE,
        routes: {
          lista.ROUTE : (_) => lista(),
          guardar.ROUTE : (_) => guardar()
        },
      )
    );
  }
}

