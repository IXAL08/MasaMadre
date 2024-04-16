import 'package:flutter/material.dart';
import 'package:proyecto/widgets/widgets.dart';

class receta3 extends StatelessWidget {
  const receta3({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BackgroundImageReceta(urlImage: "Media/images/Telera_Background.jpg",),
        Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              iconTheme: IconThemeData(color: Colors.white),
            ),
            backgroundColor: Colors.transparent,
            body: pasos(platillo:"Telera",ingredientes: "   *Harina(1000g)                  *Levadura Nevada Roja(7g)\n\n   *Magimix(10g)                      *Azúcar(30g)\n\n   *Sal(20g)            *Agua(540ml)\n\n    *Masa madre(300g)        *Grasa(50g)", preparacion:"   1.-Mezclar todos los ingredientes secos en 1° velocidad durante 30 segundos.\n\n   2.-Agregar el agua y seguir mezclando durante 3 minutos en 1° velocidad.\n\n    3.-Cambiar a 2° velocidad, agregar la grasa a la masa madre y continuar mezclando hasta obtener el desarrollo total de la masa. La temperatura fina deberá ser 26°C a 28°C.\n\n   4.-Pesar, cortar y formar las piezas.\n\n   5.-Fermentar las piezas a una temperatura de 35°C y 70% de húmedad relativa hasta que lleguen al volúmen requerido.\n\n    6.-Hornear durante 15 minutos aproximadamente. ", tiempo: "01:20")
        ),
      ],
    );
  }
}