import 'package:flutter/material.dart';
import 'package:jourv2/models/work.dart';
import 'importance_view.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';

class NewScheduleDate extends StatefulWidget {
  final details detail;
  NewScheduleDate({Key key, @required this.detail}) : super(key: key);

  @override
  _NewScheduleDateState createState() => _NewScheduleDateState();
}

class _NewScheduleDateState extends State<NewScheduleDate> {
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(Duration(days: 7));

  Future displayRangeDatePicker(BuildContext context) async {
    final DateTimeRange picked = await showDateRangePicker(
        context: context, firstDate: _startDate, lastDate: _endDate);
    // final List<DateTime> picked = await DateRangePicker.showDatePicker(
    //   context: context,
    //   initialFirstDate: _startDate,
    //   initialLastDate: _endDate,
    //   firstDate: new DateTime(DateTime.now().year),
    //   lastDate: new DateTime(DateTime.now().year + 50),
    // );
    if (picked != null && picked.duration >= Duration(days: 1)) {
      setState(() {
        _startDate = picked.start;
        _endDate = picked.end;
      });
    }
  }

  Image getImage(photoReference) {
    final url = "images/date-remove.png";
    return Image.asset(url, fit: BoxFit.cover);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text('Date Range', style: TextStyle(color: Colors.black)),
              backgroundColor: Colors.blue.shade200,
              expandedHeight: 350.0,
              flexibleSpace: FlexibleSpaceBar(
                background: getImage(widget.detail.photoReference),
              ),
            ),
            SliverFixedExtentList(
              itemExtent: 200.00,
              delegate: SliverChildListDelegate([
                buildSelectedDetails(context, widget.detail),
                buildButtons(),
              ]),
            )
          ],
        ),
      ),
    );
  }

  Widget buildButtons() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.60,
          child: RaisedButton(
            child: Text("Change Date Range"),
            color: Colors.deepPurpleAccent,
            textColor: Colors.white,
            onPressed: () async {
              await displayRangeDatePicker(context);
            },
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.60,
          child: RaisedButton(
            child: Text('Continue'),
            color: Colors.amberAccent,
            onPressed: () {
              widget.detail.startDate = _startDate;
              widget.detail.endDate = _endDate;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewScheduleImportance(
                    detail: widget.detail,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildingSelectedDates() {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Start Date"),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    "${DateFormat('dd-MM').format(_startDate).toString()}",
                    style: TextStyle(fontSize: 35, color: Colors.deepPurple),
                  ),
                ),
                Text(
                  "${DateFormat('yyyy').format(_startDate).toString()}",
                  style: TextStyle(color: Colors.deepPurple),
                ),
              ],
            ),
            Container(
                child: Icon(
              Icons.arrow_forward,
              color: Colors.deepOrange,
              size: 45,
            )),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("End Date"),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    "${DateFormat('dd-MM').format(_endDate).toString()}",
                    style: TextStyle(fontSize: 35, color: Colors.deepPurple),
                  ),
                ),
                Text(
                  "${DateFormat('yyyy').format(_endDate).toString()}",
                  style: TextStyle(color: Colors.deepPurple),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSelectedDetails(BuildContext context, details work) {
    return Hero(
      tag: "Schedule-${work.name}",
      transitionOnUserGestures: true,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 8.0,
            right: 8.0,
          ),
          child: SingleChildScrollView(
            child: Card(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 16.0, left: 16.0, bottom: 16.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Flexible(
                                child: AutoSizeText(work.name,
                                    maxLines: 3,
                                    style: TextStyle(fontSize: 25.0)),
                              ),
                            ],
                          ),
                          buildingSelectedDates(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
