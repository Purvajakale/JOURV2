import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jourv2/views/secondroute.dart';

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  File sampleImage;
  ImagePicker _picker = ImagePicker();

  void getImage() async {
    var tempImage = await _picker.getImage(source: ImageSource.gallery);
    final File file = File(tempImage.path);
    // setState(() {
    sampleImage = file;
    // });
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SecondRoute(
                sampleImage: sampleImage,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: Text("Add a new post"),
        style: ElevatedButton.styleFrom(
          primary: Colors.blueAccent,
          onPrimary: Colors.white,
          onSurface: Colors.grey,
        ),
        onPressed: getImage,
      ),
    );
  }
}
