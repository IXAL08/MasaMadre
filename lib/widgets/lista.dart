import 'package:flutter/material.dart';
import 'package:proyecto/widgets/Save.dart';


class lista extends StatelessWidget {
  const lista({super.key});

  static const String ROUTE = "/";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(child:Icon(Icons.add),onPressed: () {
        Navigator.pushNamed(context, guardar.ROUTE);
      }),
      appBar: AppBar(
        title: Text("Lista"),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            ListTile(title: Text("Nota 1"),),
            ListTile(title: Text("Nota 1"),),
            ListTile(title: Text("Nota 1"),),
            ListTile(title: Text("Nota 1"),),
            ListTile(title: Text("Nota 1"),),
            ListTile(title: Text("Nota 1"),),
          ],
        ),
      ),
    );
  }
}
