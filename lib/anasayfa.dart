import 'package:android_flutter_storage_operations_app_2/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {

  String spUsername = "";
  String spPassword = "";

  Future<void> oturumOku() async {
    var sp = await SharedPreferences.getInstance();

    setState(() {
      spUsername = sp.getString("username") ?? "admin";
      spPassword = sp.getString("password") ?? "password";
    });
  }

  Future<void> cikisYap() async {
    var sp = await SharedPreferences.getInstance();

    sp.remove("username");
    sp.remove("password");

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginEkrani()));
  }

  @override
  void initState() {
    super.initState();
    oturumOku();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: Text("Anasayfa"),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: (){
              cikisYap();
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Kullanıcı adı : $spUsername", style: TextStyle(fontSize: 30),),
              Text("Şifre         : $spPassword", style: TextStyle(fontSize: 30),),
            ],
          ),
        ),
      ),
    );
  }
}
