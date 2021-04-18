import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'views/navigation_view.dart';
import 'package:jourv2/views/first_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:jourv2/views/sign_up_view.dart';
import 'package:jourv2/widget/provider_widget.dart';
import 'package:jourv2/services/auth_service.dart';
import 'package:jourv2/views/onboarding.dart';
import 'dart:async';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      auth: AuthService(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Travel Budget App",
        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.blue,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.red,
          ),
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
      ),
    );
  } // home: HomeController(),
// routes: <String, WidgetBuilder>{
//   '/signUp': (BuildContext context) =>
//       SignUpView(authFormType: AuthFormType.signUp),
//   '/signIn': (BuildContext context) =>
//       SignUpView(authFormType: AuthFormType.signIn),
//   '/home': (BuildContext context) => HomeController(),
// },
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
  bool showHome = false;
  @override
  void initState() {
    // TODO: implement initState
    Timer(Duration(seconds: 3), openOnBoard);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: showHome
          ? HomeController()
          : Center(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/homepage.JPEG'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
    );
  }

  void openOnBoard() {
    setState(() {
      showHome = true;
    });
    // Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => HomeController()));
  }
}
