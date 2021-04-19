import 'package:flutter/material.dart';
import 'package:jourv2/widget/provider_widget.dart';
import 'package:intl/intl.dart';
import 'package:jourv2/services/loading.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text('Profile'),
    //   ),

    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Color.fromRGBO(9, 17, 30, 1),
              Color.fromRGBO(76, 139, 248, 1),
            ],
            begin: FractionalOffset.bottomCenter,
            end: FractionalOffset.topCenter,
          )),
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
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 50),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 35,
                    ),
                    Icon(
                      Icons.logout,
                      color: Colors.white,
                      size: 35,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'My\nProfile',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: LayoutBuilder(
                    builder: (context, constraints) => Stack(children: [
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: MediaQuery.of(context).size.height * 0.3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 70,
                              ),
                              Text(
                                "Name: ${user.displayName}",
                                style: TextStyle(
                                    color: Color.fromRGBO(76, 139, 248, 1),
                                    fontSize: 32),
                              ),
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        "Email: ${user.email}",
                                        style: TextStyle(
                                            color: Color.fromRGBO(9, 17, 30, 1),
                                            fontSize: 21),
                                      ),
                                      Text(
                                        "Created: ${DateFormat('MM/dd/yyyy').format(user.metadata.creationTime)}",
                                        style: TextStyle(
                                            color: Color.fromRGBO(9, 17, 30, 1),
                                            fontSize: 21),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: Image.asset(
                            'images/profile_vec.png',
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
              ],
            ),
          )),
        ),
      ],
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
