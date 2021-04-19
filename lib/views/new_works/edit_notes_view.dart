// import 'package:flutter/material.dart';
// import 'package:jourv2/models/work.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:jourv2/widget/provider_widget.dart';
//
// class EditNotesView extends StatefulWidget {
//   final details work;
//
//   EditNotesView({Key key, @required this.work}) : super(key: key);
//
//   @override
//   _EditNotesViewState createState() => _EditNotesViewState();
// }
//
// class _EditNotesViewState extends State<EditNotesView> {
//   TextEditingController _notesController = new TextEditingController();
//
//   final db = FirebaseFirestore.instance;
//
//   @override
//   void initState() {
//     super.initState();
//     _notesController.text = widget.work.notes;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         height: MediaQuery.of(context).size.height,
//         width: MediaQuery.of(context).size.width,
//         color: Colors.deepPurpleAccent,
//         child: Hero(
//           tag: "TripNotes-${widget.work.name}",
//           transitionOnUserGestures: true,
//           child: SafeArea(
//             child: SingleChildScrollView(
//               child: Column(
//                 children: <Widget>[
//                   buildHeading(context),
//                   buildNotesText(),
//                   buildSubmitButton(context),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget buildHeading(context) {
//     return Material(
//       color: Colors.deepPurpleAccent,
//       child: Padding(
//         padding: const EdgeInsets.only(left: 20.0, top: 10.0),
//         child: Row(
//           children: <Widget>[
//             Expanded(
//               child: Text(
//                 "Trip Notes",
//                 style: TextStyle(fontSize: 24, color: Colors.white),
//               ),
//             ),
//             FlatButton(
//               child: Icon(Icons.close, color: Colors.white, size: 30),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget buildNotesText() {
//     return Material(
//       color: Colors.deepPurpleAccent,
//       child: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: TextField(
//           maxLines: null,
//           controller: _notesController,
//           decoration: InputDecoration(
//             border: InputBorder.none,
//           ),
//           cursorColor: Colors.white,
//           autofocus: true,
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//     );
//   }
//
//   Widget buildSubmitButton(context) {
//     return Material(
//       color: Colors.deepPurpleAccent,
//       child: RaisedButton(
//         child: Text("Save"),
//         color: Colors.blueAccent,
//         onPressed: () async {
//           widget.work.notes = _notesController.text;
//           final uid = await Provider.of(context).auth.getCurrentUID();
//           await db
//               .collection("userData")
//               .doc(uid)
//               .collection("works")
//               .doc(widget.work.documentId)
//               .update({'notes': _notesController.text});
//           Navigator.of(context).pop();
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:jourv2/models/work.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jourv2/widget/provider_widget.dart';

class EditNotesView extends StatefulWidget {
  final details work;

  EditNotesView({Key key, @required this.work}) : super(key: key);

  @override
  _EditNotesViewState createState() => _EditNotesViewState();
}

class _EditNotesViewState extends State<EditNotesView> {
  TextEditingController _notesController = new TextEditingController();

  final db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _notesController.text = widget.work.notes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.blue.shade600,
        child: Hero(
          tag: "Notes-${widget.work.name}",
          transitionOnUserGestures: true,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  buildHeading(context),
                  buildNotesText(),
                  buildSubmitButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildHeading(context) {
    return Material(
      color: Colors.blue.shade600,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, top: 10.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                "Quick Notes",
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
            FlatButton(
              child: Icon(Icons.close, color: Colors.white, size: 30),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ),
    );
  }

  Widget buildNotesText() {
    return Material(
      color: Colors.blue.shade600,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: TextField(
          maxLines: null,
          controller: _notesController,
          decoration: InputDecoration(
            border: InputBorder.none,
          ),
          cursorColor: Colors.white,
          autofocus: true,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget buildSubmitButton(context) {
    return Material(
      color: Colors.blue.shade600,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.60,
        child: RaisedButton(
          child: Text("Save",
              style: TextStyle(fontSize: 24, color: Colors.blue.shade600)),
          color: Colors.white,
          onPressed: () async {
            widget.work.notes = _notesController.text;

            final uid = await Provider.of(context).auth.getCurrentUID();

            await db
                .collection("userData")
                .doc(uid)
                .collection("works")
                .doc(widget.work.documentId)
                .update({'notes': _notesController.text});

            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}
