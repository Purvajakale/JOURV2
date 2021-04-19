import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jourv2/models/work.dart';
import 'package:jourv2/views/new_works/edit_notes_view.dart';
import 'package:jourv2/views/new_works/edit_budget_view.dart';

class DetailScheduleView extends StatefulWidget {
  final details work;
  DetailScheduleView({Key key, @required this.work}) : super(key: key);

  @override
  _DetailScheduleViewState createState() => _DetailScheduleViewState();
}

class _DetailScheduleViewState extends State<DetailScheduleView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text('Schedule Details',
                  style: TextStyle(color: Colors.black)),
              backgroundColor: Colors.blue.shade200,
              expandedHeight: 350.0,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset("images/listimage.png"),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                workDetails(),
                daysOutCard(),
                notesCard(context),
                budgetCard(context),
                Container(
                  height: 200,
                )
              ]),
            )
          ],
        ),
      ),
    );
  }

  // TRIP DETAILS
  Widget workDetails() {
    return Card(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.work.name,
                  style: TextStyle(fontSize: 30, color: Colors.blueAccent),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                child: Text(
                  "Description: ${widget.work.description}",
                  style: TextStyle(color: Colors.orange),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                child: Text(
                  "Label :" + " ${widget.work.tag}".toUpperCase(),
                  style: TextStyle(color: Colors.blueGrey[800], fontSize: 20),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // DAYS TILL TRIP CARD
  Widget daysOutCard() {
    return Card(
      color: Colors.blue.shade400,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text("${getDaysUntilSchedule()}",
                    style: TextStyle(fontSize: 45)),
                Text(": days until your schedule",
                    style: TextStyle(fontSize: 17))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text("${getTotalScheduleDays()}",
                    style: TextStyle(fontSize: 45)),
                Text(": total number of schedule days",
                    style: TextStyle(fontSize: 17))
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget notesCard(context) {
    return Hero(
      tag: "Notes-${widget.work.name}",
      transitionOnUserGestures: true,
      child: Card(
        color: Colors.blue.shade600,
        child: InkWell(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                child: Row(
                  children: <Widget>[
                    Text("Quick Notes",
                        style: TextStyle(fontSize: 35, color: Colors.white)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(children: setNoteText()),
              )
            ],
          ),
          onTap: () {
            Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditNotesView(work: widget.work)))
                .then((value) {
              setState(() {});
            });
          },
        ),
      ),
    );
  }

  List<Widget> setNoteText() {
    if (widget.work.notes == null) {
      return [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Icon(Icons.add_circle_outline, color: Colors.grey[300]),
        ),
        Text("Click To Add Notes", style: TextStyle(color: Colors.grey[300])),
      ];
    } else {
      return [
        Text(
          widget.work.notes,
          style: TextStyle(color: Colors.grey[300]),
          overflow: TextOverflow.ellipsis,
        )
      ];
    }
  }

  Widget budgetCard(context) {
    return Hero(
      tag: "Budget-${widget.work.name}",
      transitionOnUserGestures: true,
      child: Card(
        color: Colors.blue.shade800,
        child: InkWell(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                child: Row(
                  children: <Widget>[
                    Text("Budget",
                        style: TextStyle(fontSize: 34, color: Colors.white)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: setBudgetText(),
                  ),
                ),
              )
            ],
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        EditBudgetView(work: widget.work))).then((value) {
              setState(() {});
            });
          },
        ),
      ),
    );
  }

  List<Widget> setBudgetText() {
    if (widget.work.budget == null) {
      return [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Icon(Icons.add_circle_outline, color: Colors.grey[300]),
        ),
        Text("Click To Enter budget",
            style: TextStyle(color: Colors.grey[300])),
      ];
    } else {
      return [
        Text('Rs. ' + widget.work.budget,
            style: TextStyle(fontSize: 20, color: Colors.grey[300]))
      ];
    }
  }

  int getTotalScheduleDays() {
    return widget.work.endDate.difference(widget.work.startDate).inDays;
  }

  int getDaysUntilSchedule() {
    int diff = widget.work.startDate.difference(DateTime.now()).inDays;
    if (diff < 0) {
      diff = 0;
    }
    return diff;
  }
}
