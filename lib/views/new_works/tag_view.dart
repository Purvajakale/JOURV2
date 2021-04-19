import 'package:flutter/material.dart';
import 'package:jourv2/models/work.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:jourv2/views/home_view.dart';
import 'package:provider/provider.dart';

class NewScheduleTag extends StatefulWidget {
  final details detail;

  NewScheduleTag({Key key, @required this.detail}) : super(key: key);

  @override
  _NewScheduleTagState createState() => _NewScheduleTagState();
}

class _NewScheduleTagState extends State<NewScheduleTag> {
  int count = 0;

  final db = FirebaseFirestore.instance;
  String _selectedTag = 'official';
  final List<String> meet = ['official', 'unofficial', 'family', 'health'];

  Image getImage(photoReference) {
    final url = "images/tag-remove.png";
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
              title: Text('Tag', style: TextStyle(color: Colors.black)),
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
                        Text("description : ${widget.detail.description}"),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.60,
                          child: Tab(
                            child: Text(
                              'Choose the Tag',
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: DropdownButtonFormField(
                            value: _selectedTag,
                            items: meet.map((work) {
                              return DropdownMenuItem(
                                value: work,
                                child: Text('$work meeting'),
                              );
                            }).toList(),
                            onChanged: (val) =>
                                setState(() => _selectedTag = val),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.60,
                      child: RaisedButton(
                        child: Text('Finish'),
                        onPressed: () async {
                          widget.detail.tag = _selectedTag;
                          //save data to firebase
                          final uid =
                              await Provider.of(context).auth.getCurrentUID();
                          await db
                              .collection("userData")
                              .doc(uid)
                              .collection("works")
                              .add(widget.detail.toJson());
                          // Navigator.of(context).pop();
                          Navigator.popUntil(context, (route) {
                            return count++ == 5;
                          });

                          // Navigator.of(context).popUntil((route) => route.isFirst);
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

    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text('''Create new Schedule -
    //       tag'''),
    //   ),
    //   body: Center(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: <Widget>[
    //         Text("name : ${widget.detail.name}"),
    //         Text(
    //             'start date: ${DateFormat('dd-MM-yyyy').format(widget.detail.startDate).toString()}'),
    //         Text(
    //             'end date: ${DateFormat('dd-MM-yyyy').format(widget.detail.endDate).toString()}'),
    //         Text("importance : ${widget.detail.importance}"),
    //         Text("description : ${widget.detail.description}"),
    //         Text('Select a tag'),
    //         DropdownButtonFormField(
    //           value: _selectedTag,
    //           items: meet.map((work) {
    //             return DropdownMenuItem(
    //               value: work,
    //               child: Text('$work meeting'),
    //             );
    //           }).toList(),
    //           onChanged: (val) => setState(() => _selectedTag = val),
    //         ),
    //         RaisedButton(
    //           child: Text('Finish'),
    //           onPressed: () async {
    //             widget.detail.tag = _selectedTag;
    //             //save data to firebase
    //             final uid = await Provider.of(context).auth.getCurrentUID();
    //             await db
    //                 .collection("userData")
    //                 .doc(uid)
    //                 .collection("works")
    //                 .add(widget.detail.toJson());
    //             // Navigator.of(context).pop();
    //             Navigator.popUntil(context, (route) {
    //               return count++ == 5;
    //             });
    //
    //             // Navigator.of(context).popUntil((route) => route.isFirst);
    //           },
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
