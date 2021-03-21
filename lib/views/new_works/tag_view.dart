import 'package:flutter/material.dart';
import 'package:jourv2/models/work.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:jourv2/widget/provider_widget.dart';

class NewScheduleTag extends StatefulWidget {
  final details detail;

  NewScheduleTag({Key key, @required this.detail}) : super(key: key);

  @override
  _NewScheduleTagState createState() => _NewScheduleTagState();
}

class _NewScheduleTagState extends State<NewScheduleTag> {
  final db = FirebaseFirestore.instance;
  String _selectedTag = 'official';
  final List<String> meet = ['official', 'unofficial', 'family', 'health'];

  @override
  Widget build(BuildContext context) {
    TextEditingController _titleController = new TextEditingController();
    _titleController.text = widget.detail.description;

    return Scaffold(
      appBar: AppBar(
        title: Text('''Create new Schedule - 
          tag'''),
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
            Text("importance : ${widget.detail.importance}"),
            Text("description : ${widget.detail.description}"),
            Text('Select a tag'),
            DropdownButtonFormField(
              value: _selectedTag,
              items: meet.map((work) {
                return DropdownMenuItem(
                  value: work,
                  child: Text('$work meeting'),
                );
              }).toList(),
              onChanged: (val) => setState(() => _selectedTag = val),
            ),
            RaisedButton(
              child: Text('Finish'),
              onPressed: () async {
                widget.detail.tag = _selectedTag;
                //save data to firebase
                final uid = await Provider.of(context).auth.getCurrentUID();
                await db
                    .collection("userData")
                    .doc(uid)
                    .collection("works")
                    .add(widget.detail.toJson());
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            ),
          ],
        ),
      ),
    );
  }
}
