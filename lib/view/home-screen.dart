import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_cropper/image_cropper.dart';
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

  File? _selectedFile;


  bool _isUpload = false;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFFEFF7FF),
      body: _isUpload ? Center(
        child: CircularProgressIndicator(
          color: Colors.green,
          strokeWidth: 4,
        ),
      ):Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: [
              Container(
                width: width,
                height: height/2,
                color: Color(0xFF026906),
                child: Column(
                  children: [
                    //SizedBox(height: 20,),
                    //Image.asset("assets/truck90.jpg", height: 70, width: 70, fit:  BoxFit.contain,),

                    SizedBox(height: 50,),
                    Image.asset("assets/1.png", height: 200, width: 900, fit: BoxFit.cover,),
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
                          blurRadius: 10.0,
                          spreadRadius: 1.0,
                          offset: Offset( 0.0, 5.0,),
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
              Positioned(
                top: 35,
                  right: 20,
                  child: GestureDetector(
                    onTap: (){
                      exit(0);
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: appColors.white
                      ),
                      child: Icon(
                        Icons.close,
                        color: Colors.green,
                        size: 20,
                      ),
                    ),
                  )
              )
            ],
          ),

          GestureDetector(
            onTap: (){
              imagePicker(ImageSource.gallery);
            },
            child: Container(
              width: width/1.4,
              height: 100,
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/8, ),
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
          ),

          SizedBox(height: MediaQuery.of(context).size.height/15,),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: width/1.5,
              child: Column(
                children: const [
                  Text("For Transport Accounting & Bookkeeping Visit us @",
                   textAlign:  TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                  SizedBox(height: 10,),

                  Text("www.truck90.com",
                    textAlign:  TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),

                ],
              ),
            ),
          ),
          SizedBox(height: 20,),
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
    setState((){
      _isUpload = true;
    });
    final pickerFile = await picker.getImage(source: pickImageType);
    if(pickerFile != null){

      CroppedFile? croppedFile = await ImageCropper().cropImage(
       sourcePath: pickerFile.path,
       aspectRatioPresets: [
         CropAspectRatioPreset.square,
         CropAspectRatioPreset.ratio3x2,
         CropAspectRatioPreset.original,
         CropAspectRatioPreset.ratio4x3,
         CropAspectRatioPreset.ratio16x9
       ],
       uiSettings: [
         AndroidUiSettings(
             toolbarTitle: 'Cropper',
             toolbarColor: Colors.green,
             toolbarWidgetColor: Colors.white,
             initAspectRatio: CropAspectRatioPreset.original,
             lockAspectRatio: false),
         IOSUiSettings(
           title: 'Cropper',
         ),
       ],
     );
      File imagePath = File(croppedFile!.path);

      File compressImage = await compress(ImagePathTOComprose:imagePath);
      setState((){
        _image.add(compressImage);
      });
      Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewPdf(image: _image)));




    }else{
      ShowToast("No Image Selected");
    }
    setState((){
      _isUpload = true;
    });


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
