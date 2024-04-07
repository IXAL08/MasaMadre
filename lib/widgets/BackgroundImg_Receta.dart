import 'package:flutter/material.dart';

class BackgroundImageReceta extends StatelessWidget {
  const BackgroundImageReceta({super.key});

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
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("Media/images/Login_image.jpg"),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.white10, BlendMode.colorDodge),
            )
        ),
      ),
    );
  }
}
