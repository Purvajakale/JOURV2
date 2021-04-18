import 'package:flutter/material.dart';
import 'package:jourv2/models/work.dart';
import 'description_view.dart';
import 'package:intl/intl.dart';

class NewScheduleImportance extends StatefulWidget {
  final details detail;
  NewScheduleImportance({Key key, @required this.detail}) : super(key: key);

  @override
  _NewScheduleImportanceState createState() => _NewScheduleImportanceState();
}

class _NewScheduleImportanceState extends State<NewScheduleImportance> {
  final List<int> imp = [100, 200, 300, 400, 500, 600, 700, 800, 900];

  int _currentimportance = 100;

  @override
  Widget build(BuildContext context) {
    TextEditingController _titleController = new TextEditingController();
    _titleController.text = widget.detail.name;

    return Scaffold(
      appBar: AppBar(
        title: Text(''' 
          Importance'''),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("name : ${widget.detail.name}"),
            Text(
                'start date: ${DateFormat('dd-MM-yyyy').format(widget.detail.startDate).toString()}'),
            Text(
                'end date: ${DateFormat('dd-MM-yyyy').format(widget.detail.endDate).toString()}'),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Enter the importance',
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(30.0),
            //   child: TextField(
            //     controller: _titleController,
            //     autofocus: true,
            //   ),
            // ),

            Slider(
              value: (_currentimportance).toDouble(),
              activeColor: Colors.blueGrey[_currentimportance],
              inactiveColor: Colors.blueGrey[_currentimportance],
              min: 100,
              max: 900,
              divisions: 8,
              label: 'Task Priority',
              onChanged: (val) =>
                  setState(() => _currentimportance = val.round()),
            ),

            RaisedButton(
              child: Text('Continue'),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7.0)),
              color: Colors.blueAccent,
              textColor: Colors.white,
              onPressed: () {
                widget.detail.importance = _currentimportance;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewScheduleDescription(
                        detail: widget.detail,
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
