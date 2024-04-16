import 'package:flutter/material.dart';

class pasos extends StatelessWidget {
  final String tiempo;
  final String ingredientes;
  final String preparacion;
  final String platillo;
  const pasos({super.key,required this.ingredientes,required this.preparacion, required this.tiempo, required this.platillo});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 320,),
        Container(
          height: 300,
          width: 385,
          decoration: BoxDecoration(
              color: Color(0xFF7B471E).withOpacity(0.75),
              borderRadius: BorderRadius.circular(10)
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 270),
                    child: RichText(
                      text: TextSpan(text: "🕗 $tiempo horas"),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  RichText(text: TextSpan(children: [
                    TextSpan(text: "$platillo\n",style: TextStyle(fontSize: 24)),
                    TextSpan(text: "\n"),
                    TextSpan(text: "Ingredientes: \n\n", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    TextSpan(text: "$ingredientes\n\n"),
                    TextSpan(text: "Preparación: \n\n", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    TextSpan(text: "$preparacion")
                  ]
                  ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
