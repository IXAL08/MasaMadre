import 'package:flutter/material.dart';

class BackgroundImageReceta extends StatelessWidget {
  final String urlImage;
  const BackgroundImageReceta({super.key, required this.urlImage});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        colors: [Colors.black,Colors.black12],
        begin: Alignment.bottomCenter,
        end: Alignment.center,
      ).createShader(bounds),
      blendMode: BlendMode.darken,
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("$urlImage"),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.white10, BlendMode.colorDodge),
            )
        ),
      ),
    );
  }
}
