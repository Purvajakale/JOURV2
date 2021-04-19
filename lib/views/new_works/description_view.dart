import 'package:flutter/material.dart';
import 'package:jourv2/models/work.dart';
import 'tag_view.dart';
import 'package:intl/intl.dart';

class NewScheduleDescription extends StatefulWidget {
  final details detail;
  NewScheduleDescription({Key key, @required this.detail}) : super(key: key);

  @override
  _NewScheduleDescriptionState createState() => _NewScheduleDescriptionState();
}

class _NewScheduleDescriptionState extends State<NewScheduleDescription> {
  Image getImage(photoReference) {
    final url = "images/description-remove.png";
    return Image.asset(url, fit: BoxFit.cover);
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _titleController = new TextEditingController();
    _titleController.text = widget.detail.description;

    return Scaffold(
      body: Center(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text('Description', style: TextStyle(color: Colors.black)),
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
                        Text("importance : ${widget.detail.importance}"),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.60,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Tab(
                              child: Text(
                                'Description',
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
                            maxLength: 30,
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
                          widget.detail.description = _titleController.text;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NewScheduleTag(
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
