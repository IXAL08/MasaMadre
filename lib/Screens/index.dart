import 'package:flutter/material.dart';
import 'pages.dart';
import 'package:proyecto/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

//7B471E, D6803C, 9E5726

class index extends StatefulWidget {
  const index({super.key});

  @override
  State<index> createState() => _indexState();
}

class _indexState extends State<index> {
  String email = "", password = "", username = "", id="";

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
      body: const SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 10,),
              Text("AÑADIDOS RECIENTEMENTE", style: TextStyle(fontFamily: "Titulos",fontSize: 30),),
              SizedBox(height: 25,),
              carta(titulo: "Bolillo",size: 50,imagen: "Media/images/Bolillo_Background.jpg",url: receta1(),),
              carta(titulo: "Concha",size: 50,imagen: "Media/images/Concha_Background.jpg",url: receta2(),),
              carta(titulo: "Telera",size: 50,imagen: "Media/images/Telera_Background.jpg",url: receta3(),),
            ],
          ),
        ),
      ),
    );
  }

}
