import 'package:flutter/material.dart';
import 'package:proyecto/widgets/widgets.dart';

class receta1 extends StatelessWidget {
  const receta1({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BackgroundImageReceta(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: pasos(ingredientes: "Ingredientes", preparacion: "preparacion", tiempo: "00:00")
        ),
      ],
    );
  }
}
