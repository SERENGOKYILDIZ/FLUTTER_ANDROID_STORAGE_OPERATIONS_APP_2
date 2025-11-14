import 'package:android_flutter_storage_operations_app_2/anasayfa.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ///-> Giriş Yapıldıysa otomatik giriş yapsın
    ///
    Future<bool> oturumKontrol() async {
      var sp = await SharedPreferences.getInstance();
      String spUsername = sp.getString("username") ?? "admin";
      String spPassword = sp.getString("password") ?? "password";

      if(spUsername == "admin" && spPassword == "123")
        {
          return true;
        }
      else
        {
          return false;
        }
    }

    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      ///-> Burada kontrol edilir
      home: FutureBuilder<bool>(
        future: oturumKontrol(),
        builder: (context, snapshot){
          if(snapshot.hasData)
            {
              bool? gecisIzni = snapshot.data;
              return gecisIzni! ? Anasayfa() : LoginEkrani();
            }
          else
            {
              return Container();
            }
        },
      ),
    );
  }
}

class LoginEkrani extends StatefulWidget {
  @override
  State<LoginEkrani> createState() => _LoginEkraniState();
}

class _LoginEkraniState extends State<LoginEkrani> {

  var tfKullaniciAdi = TextEditingController();
  var tfSifre = TextEditingController();

  var scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  Future<void> girisKontrol() async {
    var user = tfKullaniciAdi.text;
    var password = tfSifre.text;

    if(user == "admin" && password == "123"){
      var sp = await SharedPreferences.getInstance();

      sp.setString("username", user);
      sp.setString("password", password);

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Anasayfa()));
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Giriş Hatalı")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: Text("Login Ekrani"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: tfKullaniciAdi,
                decoration: InputDecoration(
                  hintText: "Kullanici Adi"
                ),
              ),
              TextField(
                obscureText: true,
                controller: tfSifre,
                decoration: InputDecoration(
                    hintText: "Sifre"
                ),
              ),
              ElevatedButton(
                child: Text("Giriş Yap"),
                onPressed: (){
                  girisKontrol();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
