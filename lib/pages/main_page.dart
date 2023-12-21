import 'package:flutter/material.dart';
import 'package:flutter_login_screen/models/user_data.dart';
import 'package:flutter_login_screen/pages/data_page.dart';
import 'package:flutter_login_screen/pages/login_page.dart';
import 'package:flutter_login_screen/utils/scaffold_messanger_state_extension.dart';
import 'package:provider/provider.dart';
import 'package:flutter_login_screen/store/user.dart';

class MyMainScreen extends StatefulWidget {
  const MyMainScreen({super.key});

  @override
  State<MyMainScreen> createState() => _MyMainScreenState();
}

class _MyMainScreenState extends State<MyMainScreen> {
  User? _user;

  void _updateUser(User? value, BuildContext context) {
    Future.microtask(() async {
      setState(() {
        _user = value;
        if (_user == null) {
          Navigator.pop(context);
        } else {
          navigateToScreen2(context);
        }
      });
    });
  }

  void _clearUser(bool clear) {
    Future.microtask(() async {
      setState(() {
        _user = null;
      });
    });
  }

  void navigateToScreen2(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => MyDataScreen(() {
                ScaffoldMessenger.of(context)
                    .snackBar("Logging out", addClose: true);
                _clearUser(true);
                _updateUser(null, context);
              }, title: 'Data Screen')),
    );
  }

  @override
  Widget build(BuildContext context) {
    UserStore userStore = Provider.of<UserStore>(context);
    return MyLoginScreen((newUser) {
      userStore.loginNewUser(newUser);
      _updateUser(newUser, context);
    }, title: 'Login Screen');
  }
}
