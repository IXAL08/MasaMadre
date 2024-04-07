import 'package:flutter/material.dart';
import 'package:proyecto/Screens/receta1.dart';
import 'package:proyecto/widgets/widgets.dart';

//7B471E, D6803C, 9E5726

class index extends StatefulWidget {
  const index({super.key});

  @override
  State<index> createState() => _indexState();
}

class _indexState extends State<index> {
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
      drawer: const Dibujador(),
      body: const SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 10,),
              Text("AÑADIDOS RECIENTEMENTE", style: TextStyle(fontFamily: "Titulos",fontSize: 30),),
              SizedBox(height: 25,),
              carta(titulo: "RECETA",size: 50,imagen: "Media/images/Login_image.jpg",url: receta1(),),
              //carta(titulo: "RECETA",size: 50,imagen: "Media/images/Login_image.jpg"),
              //carta(titulo: "RECETA",size: 50,imagen: "Media/images/Login_image.jpg"),
            ],
          ),
        ),
      ),
    );
  }
}
