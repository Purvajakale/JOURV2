import 'package:flutter/material.dart';
import 'package:jourv2/models/work.dart';
import 'date_view.dart';

class NewScheduleLog extends StatefulWidget {
  final details detail;
  NewScheduleLog({Key key, @required this.detail}) : super(key: key);

  @override
  _NewScheduleLog createState() => _NewScheduleLog();
}

class _NewScheduleLog extends State<NewScheduleLog> {
  Image getImage(photoReference) {
    final url = "images/name.png";
    return Image.asset(url, fit: BoxFit.cover);
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _titleController = new TextEditingController();
    _titleController.text = widget.detail.name;

    return Scaffold(
      body: Center(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text('New Schedule'),
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
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.60,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Tab(
                              child: Text(
                                'Enter name',
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.60,
                          child: TextField(
                            controller: _titleController,
                          ),
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
                          widget.detail.name = _titleController.text;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NewScheduleDate(
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
