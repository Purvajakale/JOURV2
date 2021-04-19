import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jourv2/views/sign_up_view.dart';
import 'package:jourv2/widget/provider_widget.dart';
import 'package:intl/intl.dart';
import 'package:jourv2/services/loading.dart';

class ProfileView extends StatelessWidget {
  User user = FirebaseAuth.instance.currentUser;
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
              Color.fromRGBO(75, 138, 250, 1),
              Color.fromRGBO(237, 243, 255, 1),
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
          appBar: AppBar(
            actions: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: IconButton(
                  icon: Icon(
                    Icons.logout,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpView()),
                    );
                  },
                ),
              ),
            ],
          ),
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 50),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  'My\nProfile',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
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
                                "${user.displayName}",
                                style: TextStyle(
                                    color: Color.fromRGBO(75, 138, 250, 1),
                                    fontSize: 32),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        "Created",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color.fromRGBO(9, 17, 30, 1),
                                          fontSize: 17,
                                        ),
                                      ),
                                      Text(
                                        "${DateFormat('MM/dd/yyyy').format(user.metadata.creationTime)}",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color:
                                              Color.fromRGBO(75, 138, 250, 1),
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0, vertical: 38),
                                    child: Container(
                                      height: 40,
                                      width: 5,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Email",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color.fromRGBO(9, 17, 30, 1),
                                          fontSize: 17,
                                        ),
                                      ),
                                      Text(
                                        "${user.email}",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color:
                                              Color.fromRGBO(76, 139, 248, 1),
                                          fontSize: 15,
                                        ),
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
      children: <Widget>[],
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
