import 'package:flutter/material.dart';
import 'package:project/show-toast.dart';
import 'package:project/utility/colors.dart';
import 'package:project/view/home-screen.dart';
import 'package:project/view/intro-screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utility/big-text.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {

  final _key = GlobalKey<FormState>();

  final _Cname = TextEditingController();
  final _Dname = TextEditingController();
  final _Cemail = TextEditingController();
  final _Remail = TextEditingController();



  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        decoration:  BoxDecoration(
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
              width: width/1.2,
              height: height/1.8,
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
                  const SizedBox(height: 30,),
                  BigText(text: "Company information ", size: 22, color: appColors.black,),
                  const SizedBox(height: 10,),

                  const SizedBox(height: 20,),

                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Form(
                      key: _key,
                        child: Column(
                            children: [
                              TextFormField(
                                controller: _Cname,
                                validator: (value) {
                                  if(value!.isEmpty){
                                    return "Company Name Field is empty";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: "Company Name",
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 0,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1,color:appColors.secondryColor
                                    ),
                                  ),
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder:  InputBorder.none,
                                  contentPadding:
                                  EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                                  filled: true,
                                  fillColor: appColors.white,
                                ),
                              ),
                              const SizedBox(height: 10,),
                              TextFormField(
                                controller: _Dname,
                                validator: (value) {
                                  if(value!.isEmpty){
                                    return "Driver Name Field is empty";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: "Driver name",
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1,color:appColors.secondryColor
                                    ),
                                  ),
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder:  InputBorder.none,
                                  contentPadding:
                                  EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                                  filled: true,
                                  fillColor: appColors.white,
                                ),
                              ),
                              const SizedBox(height: 10,),
                              TextFormField(
                                controller: _Cemail,
                                validator: (value) {
                                  if(value!.isEmpty){
                                    return "Company Email Field is empty";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: "Company Email",
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1,color:appColors.secondryColor
                                    ),
                                  ),
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder:  InputBorder.none,
                                  contentPadding:
                                  EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                                  filled: true,
                                  fillColor: appColors.white,
                                ),
                              ),
                              const SizedBox(height: 10,),
                              TextFormField(
                                controller: _Remail,
                                validator: (value) {
                                  if(value!.isEmpty){
                                    return "Receiver email Field is empty";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: "Receiver email",
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1,color:appColors.secondryColor
                                    ),
                                  ),
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder:  InputBorder.none,
                                  contentPadding:
                                  EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                                  filled: true,
                                  fillColor: appColors.white,
                                ),
                              ),

                              const SizedBox(height: 30,),

                              GestureDetector(
                                onTap: (){
                                  _saveInfo();
                                },
                                child: Container(
                                  padding: EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
                                  decoration: BoxDecoration(
                                    color: appColors.secondryColor,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: const Text("Let’s Go",
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
                    ),
                  ),




                ],
              ),
            )
        ),
      ),
    );
  }

  void _saveInfo()async{
    if(_Cname.text.isNotEmpty && _Dname.text.isNotEmpty && _Cemail.text.isNotEmpty && _Remail.text.isNotEmpty){
      SharedPreferences localStage = await SharedPreferences.getInstance();
      localStage.setString("status", "1");
      localStage.setString("Cname", _Cname.text);
      localStage.setString("Dname", _Dname.text);
      localStage.setString("Cemail", _Cemail.text);
      localStage.setString("Remail", _Remail.text);
      Navigator.push(context, MaterialPageRoute(builder: (context)=> IntroScreen()));
    }else{
      print("dsafds");
      ShowToast("Field much not be empty").errorToast();
    }

  }
}
