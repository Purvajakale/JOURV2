import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'views/navigation_view.dart';
import 'package:jourv2/views/first_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:jourv2/views/sign_up_view.dart';
import 'package:jourv2/views/authenticaionRequired.dart';
import 'package:jourv2/widget/provider_widget.dart';
import 'package:jourv2/services/auth_service.dart';
import 'package:jourv2/views/onboarding.dart';
import 'dart:async';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var localAuth = LocalAuthentication();
  bool didAuthenticate = false;

  void doAuthentication() async {
    didAuthenticate = await localAuth.authenticate(
        localizedReason: 'Please authenticate to start the day');
    setState(() {});
  }

  @override
  void initState() {
    doAuthentication();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return didAuthenticate
        ? Provider(
            auth: AuthService(),
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: "JOUR",
              theme: ThemeData(
                  brightness: Brightness.light,
                  primarySwatch: Colors.blue,
                  appBarTheme: AppBarTheme(
                    backgroundColor: Colors.blueAccent,
                  ),
                  floatingActionButtonTheme: FloatingActionButtonThemeData(
                    backgroundColor: Colors.blueAccent,
                  )),
              darkTheme: ThemeData(
                brightness: Brightness.dark,
                primarySwatch: Colors.blue,
              ),
              home: MyHomePage(),
            ),
          )
        : AuthenticationRequired();
  }
}

// class HomeController extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final AuthService auth = Provider.of(context).auth;
//     return StreamBuilder<String>(
//       stream: auth.onAuthStateChanged,
//       builder: (context, AsyncSnapshot<String> snapshot) {
//         if (snapshot.connectionState == ConnectionState.active) {
//           final bool signedIn = snapshot.hasData;
//           return signedIn ? Home() : FirstView();
//         }
//         return CircularProgressIndicator();
//       },
//     );
//   }
// }

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // bool showHome = false;
  // @override
  // void initState() {
  //   Timer(Duration(seconds: 3), openOnBoard);
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
            // showHome
            //     ?
            HomeController()
        // :
        // Center(
        //     child: Container(
        //       height: MediaQuery.of(context).size.height,
        //       width: MediaQuery.of(context).size.width,
        //       decoration: BoxDecoration(
        //         image: DecorationImage(
        //           image: AssetImage('images/homepage.JPEG'),
        //           fit: BoxFit.cover,
        //         ),
        //       ),
        //     ),
        //   ),
        );
  }

  // void openOnBoard() {
  //   setState(() {
  //     showHome = true;
  //   });
  //   // Navigator.push(
  //   //     context, MaterialPageRoute(builder: (context) => HomeController()));
  // }
}
