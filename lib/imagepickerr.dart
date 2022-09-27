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
        appBar: AppBar(
          title: Text('ImagePicker'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 15),
                Card(
                  elevation: 9,
                  child: iimage != null
                      ? Image.file(
                    iimage!,
                    height: 340,
                    width: MediaQuery.of(context).size.width,
                    //scale: MediaQuery.of(context).size.aspectRatio * 5,
                  )
                      : Image.network(
                    "https://www.logolynx.com/images/logolynx/s_30/30e85a8b425c27e64feb9832decfd757.png",
                    height: 340,
                    width: 340,
                  ),
                ),
                SizedBox.fromSize(size: Size.fromHeight(50)),
                MaterialButton(
                    color: Colors.deepOrange,
                    child: const Text("Pick Image from Gallery",
                        style: TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.bold,
                            fontSize: 24)),
                    onPressed: () {
                      getImage(ImageSource.gallery);
                    }),
                SizedBox.fromSize(size: Size.fromHeight(50)),
                MaterialButton(
                  color: Colors.green,
                  child: const Text("Pick Image from Camera",
                      style: TextStyle(
                          color: Colors.white70,
                          fontWeight: FontWeight.bold,
                          fontSize: 24)),
                  onPressed: () {
                    getImage(ImageSource.camera);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}