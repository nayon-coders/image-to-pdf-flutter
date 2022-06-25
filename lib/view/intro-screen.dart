import 'package:flutter/material.dart';
import 'package:project/utility/big-text.dart';
import 'package:project/utility/colors.dart';
import 'package:project/utility/normal-text.dart';
import 'package:project/view/home-screen.dart';
import 'package:project/view/info-screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              appColors.mainColors,
              appColors.secondryColor,
            ],
            begin: Alignment.topLeft,
            end: Alignment(0.8, 1),
          ),
        ),
        child: Center(
            child: Container(
              width: width/1.3,
              height: height/1.9,
              decoration: BoxDecoration(
                color: appColors.grey,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: appColors.secondryColor,
                    blurRadius: 5.0,
                    spreadRadius: 1.0,
                    offset: Offset( 0.0, 1.0,),
                  )
                ],
              ),
              child: Column(
                children: [
                  Image.asset("assets/intro.gif", height: 200, width: 200, fit: BoxFit.cover,),
                  const SizedBox(height: 10,),
                  BigText(text: "Welcome", size: 35, color: appColors.mainColors,),
                  const SizedBox(height: 5,),
                  SizedBox(
                    width: 200,
                      child: Text(
                          "Happy journey to convert your image to PDF",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: appColors.black,
                          fontSize: 15,
                        ),

                      ),
                  ),
                  const SizedBox(height: 20,),
                  GestureDetector(
                    onTap: (){
                      _clickIntro();
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
                      decoration: BoxDecoration(
                        color: appColors.secondryColor,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Text("Let’s Start",
                        style: TextStyle(
                          color: appColors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  )

                ],
              ),
            )
        ),
      ),

    );
  }

  void _clickIntro(){
    Navigator.push(context, (MaterialPageRoute(builder: (context)=>HomeScreen())));
  }
}
