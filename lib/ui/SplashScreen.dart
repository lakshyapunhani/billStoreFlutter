import 'dart:async';
import 'package:billstore/common/SessionManager.dart';
import 'package:billstore/ui/Login.dart';
import 'package:billstore/ui/MainScreen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() =>  _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final int splashDuration = 2;

  startTime() async {
    return Timer(
        Duration(seconds: splashDuration),
            () async {
          if (await isLoggedIn() == true) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen()));
          } else {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
          }

        }
    );
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    var drawer = Drawer();

    return Scaffold(drawer: drawer,
        body: Container(
            decoration: BoxDecoration(color: Colors.white),
            child:
            Center(child: new Image(
                image: AssetImage("assets/images/splash.png"),
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.35,
                alignment: AlignmentDirectional.center))
        )
    );
  }
}