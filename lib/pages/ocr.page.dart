import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:aget_arabic/utils/utils.dart';

class OcrPage extends StatefulWidget {
  const OcrPage({Key? key}) : super(key: key);

  @override
  State<OcrPage> createState() => _OcrPageState();
}

class _OcrPageState extends State<OcrPage> {
  bool isLoaded=false;
  late File imageFile;
  String finalText="No Text";
  String imagePath="";
  Utils utils = Utils();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OCR',style: TextStyle(color: Colors.white),),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height*0.5,
                child: isLoaded?Image.file(imageFile):const Text("No IMage"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height*0.5,
                child: SingleChildScrollView(child: Text(finalText)),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.camera, color: Colors.white,),
        onPressed: (){
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Source"),
                  content: const Text("Select the source"),
                  actions: [
                    ElevatedButton(
                        onPressed: () async{
                          performOcr(context, ImageSource.camera);
                        },
                        child: const Text("Camera", style: TextStyle(color: Colors.white),)
                    ),
                    ElevatedButton(
                        onPressed: () async{
                          performOcr(context, ImageSource.gallery);
                        },

                        child: const Text("Gallery", style: TextStyle(color: Colors.white),)
                    )
                  ],
                );
              }
          );
        },
      ),
    );
  }
  performOcr(context,source) async{
    Navigator.of(context).pop();
    File image=await utils.pickImage(source,false,0,0);
    File imageCropped= await utils.cropIMage(image);
    setState(() {
      isLoaded=true;
      imageFile=imageCropped;
    });
    String content=await utils.textOcr(imageCropped.path);
    setState(() {
      finalText=content;
    });
  }
}