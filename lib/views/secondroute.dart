import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:intl/intl.dart';

class SecondRoute extends StatelessWidget {
  // final func;
  // SecondRoute({this.func});
  final formKey = GlobalKey<FormState>();
  final File sampleImage;
  final FirebaseAuth auth = FirebaseAuth.instance;
  String myvalue;

  SecondRoute({
    this.sampleImage,
  });

  void saveToDatabase(imageURL, myvalue) {
    var dbTimeKey = DateTime.now();
    var formatDate = DateFormat('MMM d, yyyy');
    var formatTime = DateFormat('EEEE, hh:mm aaa');

    String date = formatDate.format(dbTimeKey);
    String time = formatTime.format(dbTimeKey);

    CollectionReference posts = FirebaseFirestore.instance
        .collection('Posts')
        .doc('${auth.currentUser.uid}')
        .collection("UsersPosts");
    posts
        .add({
          "image": imageURL,
          "description": myvalue,
          // "description": _myValue,
          "date": date,
          "time": time,
        })
        .then((value) => print("Post Added"))
        .catchError((error) => print("Failed to add post: $error"));
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData media = MediaQuery.of(context);

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("add note"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          reverse: true,
          padding: EdgeInsets.only(bottom: media.viewInsets.bottom),
          child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  Image.file(
                    sampleImage,
                    height: 273.0,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Description'),
                      minLines: 2,
                      maxLines: 25,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Blog Description is required';
                        }
                        return null;
                      },
                      onSaved: (String value) {
                        // onsaved(value);
                        myvalue = value;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  ElevatedButton(
                    child: Text("Add a new post"),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.lightBlue,
                      onPrimary: Colors.white,
                      onSurface: Colors.grey,
                    ),
                    onPressed: () async {
                      if (formKey.currentState.validate()) {
                        formKey.currentState.save();

                        var timeKey = DateTime.now();
                        String name = timeKey.toString() + ".jpg";
                        TaskSnapshot taskSnapshot = await FirebaseStorage
                            .instance
                            .ref('Post Images/$name')
                            .putFile(sampleImage);

                        String imageURL =
                            await taskSnapshot.ref.getDownloadURL();

                        print("Image url=" + imageURL);
                        saveToDatabase(imageURL, myvalue);
                        Navigator.pop(context);
                      }
                    },
                  ),
                ],
              )),
        ));
  }
}
