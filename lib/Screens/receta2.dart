import 'package:flutter/material.dart';
import 'package:proyecto/widgets/widgets.dart';

class receta2 extends StatelessWidget {
  const receta2({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BackgroundImageReceta(urlImage: "Media/images/Concha_Background.jpg",),
        Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              iconTheme: IconThemeData(color: Colors.white),
            ),
            backgroundColor: Colors.transparent,
            body: pasos(platillo:"Concha",ingredientes: "   *Harina(2000g)                  *Levadura Nevada de Oro(10g)\n\n   *Plupan(10g)                      *Azúcar(1300g)\n\n   *Mantequilla(100g)            *Sal(12g)\n\n    *Leche en polvo(40g)        *Huevo(400g)\n\n     *Agua(200ml)                    *Grasa vegetal(1000g)\n\n     *Margarina(150g)", preparacion:"   1.-Mezclar harina con todos los ingredientes secos en 1° velocidad durante 30 segundos.\n\n   2.-Agregar los huevos y el agua y continuar mezclando por 3 minutos.\n\n    3.-Cambiar a 2° velocidad, y cuando la masa tenga un 70 a 80% de desarrollo, agregar mantequilla, margarina y mezclar hasta obtener el desarrollo total de la masa. La temperatura final deberá ser 28°C a 30°C.\n\n   4.-Sacar la masa del tazón y dejarla reposar de 45 a 60 minutos dependiendo de la temperatura ambiente.\n\n   5.-Una vez fermentada la masa; pese, corte, boleé y deje que suelte o afloje la masa. Tape y fermente la masa a una temperatura de 35°C y 70% húmedad relativa; o fermente a temperatura ambiente hasta que lleguen al volúmen requerido, cubriendo para evitar que se resequen.\n\n    6.-Hornear a 200°C durante 12 minutos aproximadamente. ", tiempo: "01:30")
        ),
      ],
    );
  }
}