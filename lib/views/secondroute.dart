import 'package:flutter/material.dart';

class SecondRoute extends StatelessWidget {
  final func;
  SecondRoute({this.func});

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
          child: func,
        ));
  }
}
