import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foody_consumer/models/user.dart';
import 'package:foody_consumer/providers/user.dart';
import 'package:foody_consumer/screens/home_screen.dart';
import 'package:foody_consumer/screens/login_screen.dart';
import 'package:foody_consumer/services/auth.dart';
import 'package:foody_consumer/widget/input_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String _username,
      _email,
      _fullName,
      _password,
      _phone,
      _confirmPassword,
      _address,
      _city;

  File _image;
  AuthService _authService = AuthService();

  bool _isLoading = false;

  _showMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.white,
      fontSize: 16.0,
      gravity: ToastGravity.BOTTOM,
      textColor: Colors.black,
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  _getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  bool _validateFields() {
    if (_fullName == null ||
        _address == null ||
        _username == null ||
        _email == null ||
        _password == null ||
        _confirmPassword == null ||
        _phone == null ||
        _city == null) {
      _showMessage('Please fill all the fields');
      return false;
    }
    if (_password.length < 8) {
      _showMessage('Password must be at least 8 characters long');
      return false;
    }
    if (!EmailValidator.validate(_email)) {
      _showMessage('Please provide a valid email.');
      return false;
    }
    if (_image == null) {
      _showMessage('Kindly provide an image');
      return false;
    }
    if (_password != _confirmPassword) {
      _showMessage('Both passwod do not match');
      return false;
    }
    if (_username.length < 4) {
      _showMessage('Username can not be less than 4 characters.');
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.redAccent,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 40.0),
                        child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(.9),
                                  blurRadius: 20.0,
                                  offset: Offset(0, 10),
                                )
                              ]),
                          child: Column(
                            children: <Widget>[
                              InputField(
                                showDivider: true,
                                hint: 'Username',
                                inputType: TextInputType.text,
                                isObscure: false,
                                onTextChange: (value) {
                                  setState(() {
                                    _username = value;
                                  });
                                },
                              ),
                              InputField(
                                showDivider: true,
                                hint: 'Email',
                                inputType: TextInputType.text,
                                isObscure: false,
                                onTextChange: (value) {
                                  setState(() {
                                    _email = value;
                                  });
                                },
                              ),
                              InputField(
                                showDivider: true,
                                hint: 'Full Name',
                                inputType: TextInputType.text,
                                isObscure: false,
                                onTextChange: (value) {
                                  setState(() {
                                    _fullName = value;
                                  });
                                },
                              ),
                              InputField(
                                showDivider: true,
                                hint: 'Password',
                                inputType: TextInputType.text,
                                isObscure: false,
                                onTextChange: (value) {
                                  setState(() {
                                    _password = value;
                                  });
                                },
                              ),
                              InputField(
                                showDivider: true,
                                hint: 'Confirm Password',
                                inputType: TextInputType.text,
                                isObscure: false,
                                onTextChange: (value) {
                                  setState(() {
                                    _confirmPassword = value;
                                  });
                                },
                              ),
                              InputField(
                                showDivider: true,
                                hint: 'Contact Number',
                                inputType: TextInputType.text,
                                isObscure: false,
                                onTextChange: (value) {
                                  setState(() {
                                    _phone = value;
                                  });
                                },
                              ),
                              InputField(
                                showDivider: true,
                                hint: 'Address',
                                inputType: TextInputType.text,
                                isObscure: false,
                                onTextChange: (value) {
                                  setState(() {
                                    _address = value;
                                  });
                                },
                              ),
                              InputField(
                                showDivider: false,
                                hint: 'City',
                                inputType: TextInputType.text,
                                isObscure: false,
                                onTextChange: (value) {
                                  setState(() {
                                    _city = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0.0,
                        right: 0.0,
                        left: 0.0,
                        child: GestureDetector(
                          onTap: () {
                            _getImage();
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 35.0,
                            child: _image == null
                                ? Icon(
                                    Icons.account_circle,
                                    size: 60.0,
                                    color: Colors.redAccent,
                                  )
                                : Icon(
                                    Icons.check,
                                    size: 50.0,
                                  ),
                          ),
                        ),
                      ),
                      Positioned(
                          top: 40.0,
                          left: 0.0,
                          bottom: 0.0,
                          right: 0.0,
                          child: Center(
                            child:
                                _isLoading ? CircularProgressIndicator() : null,
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: MaterialButton(
                          onPressed: () async {
                            if (_validateFields()) {
                              setState(() {
                                _isLoading = true;
                              });
                              User user = User(
                                email: _email,
                                fullName: _fullName,
                                password: _password,
                                phone: _phone,
                                address: _address,
                                city: _city,
                                username: _username,
                                type: 'Consumer',
                              );
                              try {
                                FirebaseUser firebaseUser =
                                    await _authService.createUser(user, _image);
                                if (firebaseUser != null) {
                                  _showMessage('User successfully created.');
                                  Provider.of<UserProvider>(context,
                                          listen: false)
                                      .setCurrentUser(await _authService
                                          .getLoggedInUserData(firebaseUser));
                                }
                                setState(() {
                                  _isLoading = false;
                                });
                                Navigator.pushNamed(context, HomeScreen.id);
                              } catch (e) {
                                setState(() {
                                  _isLoading = false;
                                });
                                _showMessage('Some error occured');
                                print(
                                    'Registration Screen: error: ${e.toString()}');
                              }

                              setState(() {
                                _isLoading = false;
                              });
                              _showMessage('User successfully created');
                            }
                          }, //since this is only a UI app
                          child: Text(
                            'Register',
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'SFUIDisplay',
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          color: Colors.white.withOpacity(.9),
                          elevation: 4.0,
                          minWidth: 400,
                          height: 50,
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Already have an account? ',
                            style:
                                TextStyle(color: Colors.black, fontSize: 16.0),
                          ),
                          SizedBox(
                            width: 4.0,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, LoginScreen.id);
                            },
                            child: Text(
                              'Sign In',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16.0),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
