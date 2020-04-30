import 'package:flutter/material.dart';
import 'package:foody_consumer/providers/order_provider.dart';
import 'package:foody_consumer/providers/user.dart';
import 'package:foody_consumer/screens/cart_screen.dart';
import 'package:foody_consumer/screens/home_screen.dart';
import 'package:foody_consumer/screens/login_screen.dart';
import 'package:foody_consumer/screens/registration_screen.dart';
import 'package:foody_consumer/screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      MyApp(),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
        ChangeNotifierProvider<OrderProvider>(create: (_) => OrderProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: SplashScreen.id,
        theme: ThemeData.light().copyWith(primaryColor: Color(0xffff2d55)),
        routes: {
          SplashScreen.id: (context) => SplashScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          RegistrationScreen.id: (context) => RegistrationScreen(),
          HomeScreen.id: (context) => HomeScreen(),
          CartScreen.id: (context) => CartScreen(),
        },
      ),
    );
  }
}
