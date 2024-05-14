import 'package:flutter/material.dart';

class guardar extends StatelessWidget {
  const guardar({super.key});

  static const String ROUTE = "/save";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Guardar"),),
      body: Container(
        child: FormSave(),
      ),
    );
  }
}

class FormSave extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Form(child: Column(children: <Widget>[
      TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50)))
        ),
      )
    ],));
  }
  
}
