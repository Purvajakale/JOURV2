import 'package:flutter/material.dart';
import 'package:jourv2/models/work.dart';
import 'tag_view.dart';
import 'package:intl/intl.dart';

class NewScheduleDescription extends StatelessWidget {
  final details detail;
  NewScheduleDescription({Key key, @required this.detail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _titleController = new TextEditingController();
    _titleController.text = detail.description;

    return Scaffold(
      appBar: AppBar(
        title: Text('''
          Description'''),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("name : ${detail.name}"),
            Text(
                'start date: ${DateFormat('dd-MM-yyyy').format(detail.startDate).toString()}'),
            Text(
                'end date: ${DateFormat('dd-MM-yyyy').format(detail.endDate).toString()}'),
            Text("importance : ${detail.importance}"),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Enter the Description',
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: TextField(
                controller: _titleController,
                autofocus: true,
              ),
            ),
            RaisedButton(
              child: Text('Continue'),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7.0)),
              color: Colors.blueAccent,
              textColor: Colors.white,
              onPressed: () {
                detail.description = _titleController.text;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewScheduleTag(
                        detail: detail,
                      ),
                    ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
