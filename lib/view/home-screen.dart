import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:project/show-toast.dart';
import 'package:project/utility/colors.dart';
import 'package:project/view/profile.dart';
import 'package:project/view/view-pdf.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:image_picker/image_picker.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {



  //TODO: PFD & IMAGES
  final pdf = pw.Document();
  final picker = ImagePicker();
  List <File> _image = [];



  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFFEFF7FF),
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: [
              Container(
                width: width,
                height: height/2,
                color: Colors.black,
                child: Column(
                  children: [
                    //SizedBox(height: 20,),
                    //Image.asset("assets/truck90.jpg", height: 70, width: 70, fit:  BoxFit.contain,),

                    SizedBox(height: 70,),
                    Image.asset("assets/pdf.png", height: 200, width: 200, fit: BoxFit.cover,),
                    SizedBox(
                      width: 200,
                      child: Text(
                        "Select the Camera or Gallery Image to Convert into PDF",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: appColors.white,
                          fontSize: 15,
                        ),

                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: -28,
                left: width/3.3,
                child: GestureDetector(
                  onTap: (){
                    imagePicker(ImageSource.camera);
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 30, right: 30, top: 15, bottom: 15),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 20.0,
                          spreadRadius: 1.0,
                          offset: Offset( 0.0, 10.0,),
                        )
                      ],
                      gradient: LinearGradient(
                        colors: [
                          appColors.mainColors,
                          appColors.secondryColor,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment(0.8, 1),
                      ),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.camera_alt_outlined,
                          color: appColors.grey,
                          size: 30,
                        ),
                        const SizedBox(width: 5,),
                        Text("Camera",
                          style: TextStyle(
                            color: appColors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          GestureDetector(
            onTap: (){
              imagePicker(ImageSource.gallery);
            },
            child: Container(
              width: width/1.4,
              height: 100,
              margin: EdgeInsets.only(top: 120, ),
              padding: EdgeInsets.only(left: 20, right: 20),
              decoration: BoxDecoration(
                color: appColors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 20.0,
                    spreadRadius: 2.0,
                    offset: Offset( 0.0, 6.0,),
                  )
                ],
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.photo_library_outlined,
                    size: 45,
                    color: appColors.black,
                  ),
                  const SizedBox(width: 5,),
                  SizedBox(
                    width: width/2.2,
                    child: const Text(
                      "Select images from gallery ",
                      style: TextStyle(
                        color: appColors.black,
                        fontSize: 16,

                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          //TODO: Gallery Image picker
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile()));
        },
        backgroundColor: appColors.mainColors,
        child: Icon(
          Icons.settings,
        ),
      ),
    );
  }


  //TODO: Gallery Image picker
  imagePicker(pickImageType)async{
      final pickerFile = await picker.getImage(source: pickImageType);
      if(pickerFile != null){
        File imagePath = File(pickerFile.path);
        File compressImage = await compress(ImagePathTOComprose: imagePath);
        setState((){
          _image.add(compressImage);
        });
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewPdf(image: _image)));
      }else{
        ShowToast("No Image Selected");
      }
  }
  Future<File> compress({required File ImagePathTOComprose, quality: 100, percentage: 10})async{
    var path = FlutterNativeImage.compressImage(
        ImagePathTOComprose.absolute.path,
        quality: 80,
        percentage: 50
    );
    return path;

  }


}
