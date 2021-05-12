import 'package:flutter/material.dart';
import 'package:jourv2/models/work.dart';
import 'description_view.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NewScheduleImportance extends StatefulWidget {
  final details detail;
  NewScheduleImportance({Key key, @required this.detail}) : super(key: key);

  @override
  _NewScheduleImportanceState createState() => _NewScheduleImportanceState();
}

class _NewScheduleImportanceState extends State<NewScheduleImportance> {
  final List<int> imp = [100, 200, 300, 400, 500, 600, 700, 800, 900];
    TextEditingController _titleController = new TextEditingController();
  int _currentimportance = 100;
  Image getImage(photoReference) {
    final url = "images/importance-remove.png";
    return Image.asset(url, fit: BoxFit.cover);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text('Importance', style: TextStyle(color: Colors.black)),
              backgroundColor: Colors.blue.shade200,
              expandedHeight: 400.0,
              flexibleSpace: FlexibleSpaceBar(
                background: getImage(widget.detail.photoReference),
              ),
            ),
            SliverFixedExtentList(
              itemExtent: 250.00,
              delegate: SliverChildListDelegate([
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("name : ${widget.detail.name}"),
                        Text(
                            'start date: ${DateFormat('dd-MM-yyyy').format(widget.detail.startDate).toString()}'),
                        Text(
                            'end date: ${DateFormat('dd-MM-yyyy').format(widget.detail.endDate).toString()}'),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.60,
                          child: Tab(
                            child: Text(
                              'Enter the Importance',
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
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
                      ],
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.60,
                      child: RaisedButton(
                        child: Text('Continue',
                            style: TextStyle(color: Colors.white)),
                        color: Colors.blueAccent,
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
                    ),
                  ],
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
