import 'package:flutter/material.dart';
import 'package:foody_consumer/models/user.dart';
import 'package:foody_consumer/providers/user.dart';
import 'package:foody_consumer/screens/cart_screen.dart';
import 'package:foody_consumer/screens/login_screen.dart';
import 'package:foody_consumer/services/auth.dart';
import 'package:provider/provider.dart';

class NavigationDrawer extends StatelessWidget {
  AuthService _authService = AuthService();
  User currentUser;
  @override
  Widget build(BuildContext context) {
    currentUser = Provider.of<UserProvider>(context, listen: false).currentUser;
    return Drawer(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountEmail: Text('${currentUser.email}',
                style: TextStyle(fontWeight: FontWeight.w400)),
            accountName: Text(
              'Hey, ${currentUser.username}',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            // decoration: BoxDecoration(color: Colors.green),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(currentUser.image),
            ),
            arrowColor: Colors.greenAccent,
          ),
          ListTile(
            title: Text(
              'Cart',
              style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.black.withOpacity(.7),
                  fontWeight: FontWeight.bold),
            ),
            leading: Icon(
              Icons.restaurant,
              color: Colors.red,
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.red,
            ),
            onTap: () {
              Navigator.pushNamed(context, CartScreen.id);
            },
          ),
          Expanded(child: Container()),
          Divider(
            color: Colors.redAccent,
          ),
          ListTile(
            leading: Icon(
              Icons.exit_to_app,
              color: Colors.red,
            ),
            title: Text(
              'Sign out',
              style: TextStyle(
                  fontSize: 20.0, color: Colors.black.withOpacity(.8)),
            ),
            onTap: () async {
              await _authService.singOut();
              Navigator.of(context).pushNamedAndRemoveUntil(
                  LoginScreen.id, (Route<dynamic> route) => false);
            },
          )
        ],
      ),
    );
  }
}
