import 'package:flutter/material.dart';

class carta extends StatelessWidget {
  final String titulo;
  final double size;
  final String imagen;
  final Widget url;
  const carta({super.key, required this.titulo, required this.size, required this.imagen, required this.url});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 450,
      child: Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 5,
        margin: const EdgeInsets.all(10),
        child: InkWell(
          onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => url));},
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("$imagen"),
                    fit: BoxFit.fill,
                    colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.darken)
                )
            ),
            child: Center(
              child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("$titulo",style: TextStyle(color: Colors.white,fontFamily: "Titulos",fontSize: size),)
              ),
            ),
          ),
        ),
      ),
    );;
  }
}
