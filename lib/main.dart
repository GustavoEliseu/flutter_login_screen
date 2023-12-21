import 'package:flutter/material.dart';
import 'package:flutter_login_screen/pages/main_page.dart';
import 'package:flutter_login_screen/store/user.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  runApp(MyApp(prefs));
}

class MyApp extends StatelessWidget {
  const MyApp(this.prefs, {super.key});
  final SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return Provider(
        create: (_) => UserStore(null, prefs),
        child: MaterialApp(
            title: 'My Flutter Sample',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: const MyMainScreen()));
  }
}
