import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:project/view/home-screen.dart';
import 'package:project/view/info-screen.dart';
import 'package:project/view/intro-screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}



class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  void initState(){
    super.initState();
    _UserInfo();
  }
  var ID;

  _UserInfo()async{
    SharedPreferences localStage = await SharedPreferences.getInstance();
    setState((){
      ID = localStage.getString("status");
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
      ),
      home: AnimatedSplashScreen(
        splash:  Image.asset("assets/logo.png",height: 300,),
        duration: 2000,
        nextScreen: ID == "1" ? HomeScreen(): InfoScreen(),
      ),
    );
  }
}
