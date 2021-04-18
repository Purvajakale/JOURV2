import 'package:flutter/material.dart';
import 'package:jourv2/models/work.dart';
import 'date_view.dart';

class NewScheduleLog extends StatelessWidget {
  final details detail;
  NewScheduleLog({Key key, @required this.detail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _titleController = new TextEditingController();
    _titleController.text = detail.name;

    return Scaffold(
      appBar: AppBar(
        title: Text('Create new Schedule - name'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Enter the name',
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
                detail.name = _titleController.text;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewScheduleDate(
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
