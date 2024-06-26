import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});
  @override
  State<ForgotPassword> createState() => _ForgotPassword();
}
class _ForgotPassword extends State<ForgotPassword>{
  TextEditingController emailController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent,iconTheme: IconThemeData(color: Colors.white),),
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () {
          if(!FocusScope.of(context).hasPrimaryFocus && FocusScope.of(context).hasFocus){
            FocusManager.instance.primaryFocus?.unfocus();
          }
        },
        child: Center(
          child: ListView(
            children: [
              SizedBox(height: 50),
              Image.asset("Media/images/Candado.png"),
              SizedBox(height:30),
              Center(child: Text("Ingresa tu correo de recuperación por favor",style: TextStyle(color: Colors.white,fontSize: 20),)),
              Padding(
                padding: const EdgeInsets.only(left: 17,right: 17,top: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[600]?.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: TextFormField(
                    controller: emailController,
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 20),
                        border: InputBorder.none,
                        hintText: "Correo electronico",
                        hintStyle: TextStyle(fontFamily: 'Titulos',color: Colors.white70),
                        prefixIcon: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Icon(
                            Icons.email_rounded,
                            color: Colors.white,
                            size: 30,
                          ),
                        )
                    ),
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50, right: 50),
                child: Container(
                  padding: const EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                    onPressed: () {resetpassword();},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    child: const Text("Enviar correo", style: TextStyle(color: Colors.black)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future resetpassword() async{
    var url = Uri.parse("https://ivan.stuug.com/Apps/MasaMadre/resetpassword.php");
    var response = await http.post(url, body: {
      "Email" : emailController.text,
    });
    var data = jsonDecode(response.body);

    if(emailController.text.isNotEmpty){
      if(data['status'] == 'Success'){
        return showDialog(context: context, builder: (BuildContext context){
          return const AlertDialog(
            title: Center(child: Text("Correo enviado.", style: TextStyle(color: Colors.green),)),
            content: Text("Revise su correo por favor."),
          );
        });
      }else{
        return showDialog(context: context, builder: (BuildContext context){
          return const AlertDialog(
            title: Center(child: Text("Error", style: TextStyle(color: Colors.red),)),
            content: Text("Correo no existente."),
          );
        });
      }
    }else{
      return showDialog(context: context, builder: (BuildContext context){
        return const AlertDialog(
          title: Center(child: Text("Error", style: TextStyle(color: Colors.red),)),
          content: Text("Campos en blanco. Vuelva a intentarlo"),
        );
      });
    }
}

}
