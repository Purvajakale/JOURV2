import 'package:flutter/material.dart';
import 'package:jourv2/widget/provider_widget.dart';
import 'package:intl/intl.dart';
import 'package:jourv2/services/loading.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              FutureBuilder(
                future: Provider.of(context).auth.getCurrentUser(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return displayUserInformation(context, snapshot);
                  } else {
                    return Loading();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget displayUserInformation(context, snapshot) {
    final user = snapshot.data;
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Name: ${user.displayName}",
            style: TextStyle(fontSize: 20),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Email: ${user.email}",
            style: TextStyle(fontSize: 20),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Created: ${DateFormat('MM/dd/yyyy').format(user.metadata.creationTime)}",
            style: TextStyle(fontSize: 20),
          ),
        ),
        showSignOut(context),
      ],
    );
  }

  Widget showSignOut(context) {
    return RaisedButton(
      child: Text("Sign Out"),
      onPressed: () async {
        try {
          // Navigator.pop(context);
          await Provider.of(context).auth.signOut();
        } catch (e) {
          print(e);
        }
      },
    );
  }
}
