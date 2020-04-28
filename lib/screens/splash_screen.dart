import 'package:flutter/material.dart';
import 'package:foody_consumer/providers/user.dart';
import 'package:foody_consumer/screens/home_screen.dart';
import 'package:foody_consumer/screens/login_screen.dart';
import 'package:foody_consumer/services/auth.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  static String id = 'splash_screen';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AuthService _authService = AuthService();

  _pushToLogin(int seconds) {
    Future.delayed(Duration(seconds: seconds), () {
      Navigator.pushReplacementNamed(context, LoginScreen.id);
    });
  }

  _pushToHome(int seconds) {
    Future.delayed(Duration(seconds: seconds), () {
      Navigator.pushReplacementNamed(context, HomeScreen.id);
    });
  }

  _checkAuthState() async {
    _authService.currentUser.then((currentFirebaseUser) async {
      if (currentFirebaseUser != null) {
        Provider.of<UserProvider>(context, listen: false).setCurrentUser(
            await _authService.getLoggedInUserData(currentFirebaseUser));

        _pushToHome(2);
      } else {
        _pushToLogin(2);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _checkAuthState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
              child: LottieBuilder.asset(
                  'assets/splash_screen_anim/food_loader.json'))
        ],
      ),
    );
  }
}
