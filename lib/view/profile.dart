import 'package:flutter/material.dart';
import 'package:project/utility/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../show-toast.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  final _key = GlobalKey<FormState>();

  final _Cname = TextEditingController();
  final _Dname = TextEditingController();
  final _Cemail = TextEditingController();
  final _Remail = TextEditingController();


  @override
  void initState(){
    super.initState();
    _UserInfo();
  }

  _UserInfo()async{
    SharedPreferences localStage = await SharedPreferences.getInstance();
    setState((){
      _Cname.text = localStage.getString("Cname")!;
      _Dname.text = localStage.getString("Dname")!;
      _Cemail.text = localStage.getString("Cemail")!;
      _Remail.text = localStage.getString("Remail")!;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Setting"),
        backgroundColor: appColors.mainColors,
      ),

      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 30),
        child: Container(
          margin: EdgeInsets.only(top: 50),
          padding: EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height/2,
          decoration: BoxDecoration(
            color: appColors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: appColors.grey,
                blurRadius: 5.0,
                spreadRadius: 1.0,
                offset: Offset( 0.0, 1.0,),
              )
            ],
          ),
          child: Form(
            key: _key,
            child: ListView(
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
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1,color:appColors.secondryColor
                      ),
                    ),
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
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1,color:appColors.secondryColor
                      ),
                    ),
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
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1,color:appColors.secondryColor
                      ),
                    ),
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
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1,color:appColors.secondryColor
                      ),
                    ),
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
                    child: Center(
                      child: const Text("Save Changes",
                        style: TextStyle(
                          color: appColors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
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
      ShowToast("Information is change success").successToast();
    }else{
      print("dsafds");
      ShowToast("Field much not be empty").errorToast();
    }

  }

}
