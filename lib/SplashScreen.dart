import 'package:flutter/material.dart';
import 'Ui/Home/HomeScreen.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = 'SplashScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (BuildContext context) {
          Future.delayed(Duration(seconds: 2), () {
            Navigator.of(context).pushNamed(HomeScreen.routeName);
          });

          return Image(
            fit: BoxFit.fill,
            width: double.infinity,
            image: AssetImage('assets/images/splash.png'),
          );
        },
      ),
    );
  }
}
