import 'package:flutter/material.dart';
import 'package:proyecto/widgets/widgets.dart';

class receta1 extends StatelessWidget {
  const receta1({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BackgroundImageReceta(urlImage: "Media/images/Bolillo_Background.jpg",),
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(color: Colors.white),
          ),
          backgroundColor: Colors.transparent,
          body: pasos(platillo:"Bolillo",ingredientes: "    *Harina(1000g)        *Levadura Nevada Roja(10g)\n\n    *Sal(10g)                   *Azúcar(20g)\n\n    *Magnupro(10g)        *Agua(600ml)", preparacion: "   1.-Mezclar todos los ingredientes secos en 1° velocidad durante 30s.\n\n    2.-Agregar el agua y seguir mezclando durante 3 minutos en 1° velocidad\n\n   3.-Cambiar a 2° velocidad, mezclar hasta obtener el desarrollo total de la masa. La temperatura final deberá ser 26°C a 28°C\n\n    4.-Sacar la masa, pesar, cortar y dejar reposar duarante 10 minutos y formar las piezas.\n\n    5.-Fermentar las piezas a una temperatura de 35°C y 80% de húmedad relativa hasta que lleguen al volumen requerido.\n\n   6.-Cortar de extremo a extremo el bolillo y hornear con vapor a 220°C de 12 a 15 minutos aproximadamente.", tiempo: "01:10")
        ),
      ],
    );
  }
}
