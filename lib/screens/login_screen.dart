import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foody_consumer/providers/user.dart';
import 'package:foody_consumer/screens/home_screen.dart';
import 'package:foody_consumer/screens/registration_screen.dart';
import 'package:foody_consumer/services/auth.dart';
import 'package:foody_consumer/widget/input_field.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;
  String _email, _password;
  AuthService _authService = AuthService();

  _showMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.red,
      fontSize: 16.0,
      gravity: ToastGravity.BOTTOM,
      textColor: Colors.black,
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  bool _validateFields() {
    if (_email == null || _password == null) {
      _showMessage('Kindly fill both the fields.');
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.redAccent,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 40.0,
                left: 15.0,
                child: Text(
                  'LOGIN',
                  style: Theme.of(context)
                      .textTheme
                      .display2
                      .copyWith(color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 30.0),
                      height: size.height * 0.35,
                      child: SvgPicture.asset('assets/svgs/burger_pic.svg'),
                    ),
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(143, 148, 251, .2),
                              blurRadius: 20.0,
                              offset: Offset(0, 10),
                            )
                          ]),
                      child: Column(
                        children: <Widget>[
                          InputField(
                            hint: 'Email',
                            showDivider: true,
                            inputType: TextInputType.emailAddress,
                            isObscure: false,
                            onTextChange: (value) {
                              setState(() {
                                _email = value;
                              });
                            },
                          ),
                          InputField(
                            hint: 'Password',
                            showDivider: false,
                            inputType: TextInputType.text,
                            isObscure: true,
                            onTextChange: (value) {
                              setState(() {
                                _password = value;
                              });
                            },
                          )
                        ],
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: MaterialButton(
                        onPressed: () async {
                          if (_validateFields()) {
                            setState(() {
                              _isLoading = true;
                            });
                            try {
                              FirebaseUser firebaseUser =
                                  await _authService.signIn(_email, _password);

                              if (firebaseUser != null) {
                                _showMessage('Successfully logged in');

                                Provider.of<UserProvider>(context,
                                        listen: false)
                                    .setCurrentUser(await _authService
                                        .getLoggedInUserData(firebaseUser));
                                setState(() {
                                  _isLoading = false;
                                });
                                Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    HomeScreen.id,
                                    (Route<dynamic> route) => false);
                              } else {
                                _showMessage('Invalid credentials');
                                setState(() {
                                  _isLoading = false;
                                });
                              }
                            } catch (e) {
                              print('Login Screen: error: ${e.toString()}');
                              _showMessage('Invalid credentials');
                              setState(() {
                                _isLoading = false;
                              });
                            }
                          }
                        },
                        //since this is only a UI app
                        child: Text(
                          'SIGN IN',
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'SFUIDisplay',
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // color: Color(0xffff2d55),
                        color: Colors.white.withOpacity(.9),
                        elevation: 6.0,
                        minWidth: 400,
                        height: 50,
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Don\'t have an account? ',
                          style: TextStyle(color: Colors.black, fontSize: 16.0),
                        ),
                        SizedBox(
                          width: 4.0,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, RegistrationScreen.id);
                          },
                          child: Text(
                            'Sign up',
                            style:
                                TextStyle(color: Colors.white, fontSize: 16.0),
                          ),
                        )
                      ],
                    ),
                    Spacer(),
                  ],
                ),
              ),
              Positioned(
                  top: 40.0,
                  left: 0.0,
                  bottom: 0.0,
                  right: 0.0,
                  child: Center(
                    child: _isLoading ? CircularProgressIndicator() : null,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
