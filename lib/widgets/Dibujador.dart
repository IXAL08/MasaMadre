import 'package:flutter/material.dart';
import 'package:proyecto/Screens/pages.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dibujador extends StatefulWidget {
  const Dibujador({super.key});

  @override
  State<Dibujador> createState() => _DibujadorState();
}

class _DibujadorState extends State<Dibujador> {
  String email = "", password = "", username = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCred();
  }

  void getCred() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      email = pref.getString("email")!;
      password = pref.getString("password")!;
      username = pref.getString("username")!;
    });
  }
  @override
  Widget build(BuildContext context) {
    return SidebarX(
      controller: SidebarXController(selectedIndex: 0, extended: true),
      items: const [
        SidebarXItem(icon: Icons.home, label: 'Inicio'),
        SidebarXItem(icon: Icons.person, label: 'Chef'),
      ],
      theme: SidebarXTheme(
        width: 150,
        textStyle: const TextStyle(fontFamily: "Parrafos", fontSize: 35),
        selectedTextStyle: const TextStyle(fontFamily: "Parrafos", fontSize: 35),
        itemTextPadding: const EdgeInsets.only(left: 10),
        selectedItemTextPadding: const EdgeInsets.only(left: 10),
        selectedItemDecoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.black)),
        iconTheme: IconThemeData(color: const Color(0xFF9E5726).withOpacity(0.5)),
        selectedIconTheme: const IconThemeData(color: Color(0xFF9E5726))
      ),
      headerBuilder: (context, extended) {
        return InkWell(
          onTap: () {Navigator.of(context).push(MaterialPageRoute(builder: (context) => Perfil()));},
          child: Ink(
            height: 120,
            width: 100,
            color: Colors.white70,
            child: Padding(padding: const EdgeInsets.only(top: 40, bottom: 20), child: CircleAvatar(backgroundImage: AssetImage("Media/images/1.jpg")),),
          ),
        );
      },
      footerBuilder: (context, extended) {
        return Column(
          children: [
            OutlinedButton(onPressed: () async{
              SharedPreferences pref = await SharedPreferences.getInstance();
              await pref.clear();
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Login()), (route) => false);
              },
                child: Text("Logout")
            ),
            Divider(color: Colors.black.withOpacity(0.2), height: 1)
          ],
        );
      },
    );
  }
}
