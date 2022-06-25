import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:path_provider/path_provider.dart';
import "dart:io";
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:project/show-toast.dart';
import 'package:project/utility/colors.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project/view/home-screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewPdf extends StatefulWidget {
  late final List<File> image;
  ViewPdf({required this.image, Key? key}) : super(key: key);

  @override
  State<ViewPdf> createState() => _ViewPdfState();
}

class _ViewPdfState extends State<ViewPdf> {
  final picker = ImagePicker();
  final pdf = pw.Document();
  var pdfFile;
  bool _isSendedMail = false;


  @override
  void initState(){
    super.initState();
    _UserInfo();
  }
  var companyEmail;
  var reciverEmail;
  var companyName;
  var driverName;

  _UserInfo()async{
    SharedPreferences localStage = await SharedPreferences.getInstance();
    var Cemail = localStage.getString("Cemail");
    var Remail = localStage.getString("Remail");
    var Cname = localStage.getString("Cname");
    var Dname = localStage.getString("Dname");
    setState((){
      companyEmail = Cemail ;
      reciverEmail = Remail ;
      companyName = Cname;
      driverName = Dname;
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Preview"),
        backgroundColor: appColors.mainColors,
        actions: [
          IconButton(
              onPressed: (){
                _creatPdf();
                _savePdf();
              },
              icon: Icon(
                Icons.send,
                color: appColors.white,
              )

          )
        ],
      ),
      body: Center(
        child: _isSendedMail && widget.image != null  ?  Container(
          width: 200,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: appColors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: appColors.grey,
                blurRadius: 5.0,
                spreadRadius: 1.0,
                offset: Offset( 0.0, 1.0,),
              )
            ],
          ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  strokeWidth: 5,
                  color: appColors.mainColors,
                ),
                SizedBox(width: 5,),
                Text("Email Sending...",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          )
        : Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
              itemCount: widget.image.length,
              itemBuilder: (context, index){
                print(widget.image);
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: 400,
                  margin: EdgeInsets.all(10),
                  child: Stack(
                      children:[
                        Image.file(widget.image[index],),
                        Positioned(
                          right: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: appColors.white,
                              borderRadius: BorderRadius.circular(100)
                            ),
                            child: IconButton(
                                onPressed: (){
                                  setState((){
                                    widget.image.removeAt(index);
                                    ShowToast("Image removed").successToast();
                                    print(widget.image);
                                  });

                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                )
                            ),
                          ),
                        ),
                  ],
                  )
                );
              }
        ),
            ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 10, top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: (){
                _isSendedMail ? null:selectMoreImages(ImageSource.camera);
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: appColors.mainColors,
                ),
                child: Icon(
                  Icons.add_a_photo_rounded,
                  color: appColors.white,
                ),

              ),
            ),
            const SizedBox(width: 20,),
            GestureDetector(
              onTap: (){
                _isSendedMail ?null: selectMoreImages(ImageSource.gallery);
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: appColors.mainColors,
                ),
                child: Icon(
                  Icons.image,
                  color: appColors.white,
                ),

              ),
            )

          ],
        ),
      ),


    );
  }

  _creatPdf()async{
    for(var img in widget.image){
      final image = pw.MemoryImage(img.readAsBytesSync());
      pdf.addPage(pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context){
            pdfFile = pw.Center(child: pw.Image(image));
            //print(pdfFile);
            return pdfFile;
          }
      ));
    }
  }


  _savePdf()async{
    try{
      final dir = (await getApplicationDocumentsDirectory()).path;
      final file = File('$dir/PDF_file.pdf');
      print(dir);
      await file.writeAsBytes(await pdf.save());
      _sendEmail('$dir/PDF_file.pdf');
      ShowToast("PDF File Saved").successToast();
    }catch(e){
      print("Error$e");
    }
  }

  _sendEmail(path)async {
    setState((){
      _isSendedMail = true;
    });
    String username = 'nami918772@gmail.com';
    String password = 'jrtkrfqjsafizlqq';

    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, '$companyName')
      ..recipients.add('$reciverEmail')
      ..subject = '$driverName'
      ..text = 'Hai\nKindly download attached Document.\n\nThank You.'
      ..attachments.add(FileAttachment(File(path.toString())));

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: $sendReport');
      setState((){
        _isSendedMail = false;
      });
      CoolAlert.show(
        context: context,
        type: CoolAlertType.success,
        text: "Your PDF save and send by mail successful. ",
          onConfirmBtnTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
          }
      );
    } on MailerException catch (e) {
      print('Message not sent.$e');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
    setState((){
      _isSendedMail = false;
    });
  }


  selectMoreImages(type)async{

    final pickerFile = await picker.getImage(source: type);
    if(pickerFile != null){
      File imagePath = File(pickerFile.path);
      File compressImage = await compress(ImagePathTOComprose: imagePath);
      setState((){
        widget.image.add(compressImage);
      });
      ShowToast("Add New Image").successToast();
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
