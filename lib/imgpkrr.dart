import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MaterialApp(
    home: imagepikr(),
  ));
}

class imagepikr extends StatefulWidget {
  @override
  State<imagepikr> createState() => _imagepikrState();
}

class _imagepikrState extends State<imagepikr> {
  File? iimage;

  Future getImage(ImageSource source) async {
    final iimage = await ImagePicker().pickImage(source: source);
    if (iimage == null) return;
    final imageTemporary = File(iimage.path);

    setState(() {
      this.iimage = imageTemporary;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(

            children: [

              //Get Image // If image space is empty... Replace image with network image...
              iimage != null
                  ? Image.file(
                      iimage!,
                      height: 340,
                      width: MediaQuery.of(context).size.width,
                    )
                  : Image.network(
                      "https://www.logolynx.com/images/logolynx/s_30/30e85a8b425c27e64feb9832decfd757.png",
                      height: 340,
                      width: 340,
                    ),

              //take a gap
              SizedBox(height: 5,),

              //Button 1
              ElevatedButton(
                onPressed: () {
                  getImage(ImageSource.camera);
                },
                child: Text("OPEN CAMERA"),
              ),

              //take a gap
              SizedBox(height: 5,),

              //Button 2
              ElevatedButton(
                onPressed: () {
                  getImage(ImageSource.gallery);
                },
                child: Text("OPEN GALLERY"),
              ),


              //Alert Button
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (ctx) => AlertDialog(
                      actions: <Widget>[

                        Positioned(
                          right: 0.0,
                          child: GestureDetector(
                            onTap: (){
                              Navigator.of(context).pop();
                            },
                            child: const Align(
                              alignment: Alignment.topRight,
                              child: CircleAvatar(
                                radius: 14.0,
                                backgroundColor: Colors.white,
                                child: Icon(Icons.close_outlined, color: Colors.red),
                              ),
                            ),
                          ),
                        ),

                        Align(
                          child:
                          ElevatedButton.icon(onPressed: (){
                                getImage(ImageSource.gallery);
                              },
                              icon: const Icon(Icons.perm_media_outlined,
                              color: Colors.white,),
                              label: Text("Gallery")),
                        ),


                        Align(
                          child: ElevatedButton.icon(onPressed: (){
                            getImage(ImageSource.camera);
                          }, icon: const Icon(Icons.camera_alt_outlined, color: Colors.white,), label: Text("Camera")),
                        ),

                      ],
                    ),
                  );
                },
                child: const Text("Camera & Gallery"),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
