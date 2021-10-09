import 'package:flutter/material.dart';
import 'package:FirebaseEcommerce/screen/authentication/auth_screen.dart';
import 'package:FirebaseEcommerce/screen/error_screen/error_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import '../splash_screen.dart';
import '../wrapper.dart';

class InitializingApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.blue,
      body: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          // there is error
          if (snapshot.hasError) {
            return ErrorPage();
          }
          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            // StreamBuilder for checking auth state
            return StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, userSnapshot) {
                // there is error
                if (userSnapshot.hasError) {
                  return ErrorPage();
                }
                // if status if waiting so show splash screen
                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  return SplashScreen();
                }
                // if there is a existed user
                if (userSnapshot.hasData) {
                  // to move to Home screen
                  return Wrapper();
                  // return HomeScreen();
                }
                return AuthScreen();
              },
            );
          }
          // Otherwise, show something whilst waiting for initialization to complete
          return SplashScreen();
        },
      ),
    );
  }
}
