import 'package:corona_user/screeens/details.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 4),
        () => Navigator.pushReplacementNamed(context, Details.routeName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.center,
                colors: [
              Color.fromRGBO(210, 34, 45, 0.8),
              //Color.fromRGBO(210, 34, 45, 1),
              Color.fromRGBO(210, 34, 45, 1),
            ])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Text(
              'Corona ++',
              textScaleFactor: MediaQuery.of(context).textScaleFactor,
              style: GoogleFonts.aclonica(
                color: Colors.white,
                fontSize: 40,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SpinKitFadingCube(
              itemBuilder: (BuildContext context, int index) {
                return DecoratedBox(
                  decoration: BoxDecoration(
                    image:
                        DecorationImage(image: AssetImage('assets/icon2.png')),
                    color: index.isEven ? Colors.white : Colors.white70,
                  ),
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 110,
                    width: 110,
                    child: Image.asset('assets/main_logo.png'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
