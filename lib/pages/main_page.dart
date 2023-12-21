import 'package:flutter/material.dart';
import 'package:flutter_login_screen/models/user_data.dart';
import 'package:flutter_login_screen/models/typed_text.dart';
import 'package:flutter_login_screen/store/user.dart';
import 'package:provider/provider.dart';
import 'package:flutter_login_screen/pages/data_page.dart';

class MyMainScreen extends StatefulWidget {
  const MyMainScreen({super.key});

  @override
  State<MyMainScreen> createState() => _MyMainScreenState();
}

class _MyMainScreenState extends State<MyMainScreen> {
  User? _user;

  void _updateUser(User? value) {
    Future.microtask(() async {
      setState(() {
        _user = value;
        if (_user == null) {
          Navigator.pop(context);
        } else {
          navigateToScreen2();
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

  void navigateToScreen2() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => MyDataScreen(() {
                _updateUser(null);
              }, title: 'Data Screen')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userStore = Provider.of<UserStore>(context);
    userStore.loginNewUser(User("bbb", "aaa"));
    return MyDataScreen(() {}, title: 'Data Screen');
    /*return MyLoginScreen((newUser) {
      _updateUser(newUser);
    }, title: 'Login Screen');*/
  }
}
