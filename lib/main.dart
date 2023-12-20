import 'package:flutter/material.dart';
import 'package:flutter_login_screen/utils/scaffold_messanger_state_extension.dart';
import 'package:flutter_login_screen/utils/string_extension.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_login_screen/views/custom_widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _password = "";
  String _user = "";
  bool disposed = false;

  bool _passwordObscured = true;
  bool _doneButtonDisabled = false;

  bool userHasError = false;
  bool passwordHasError = false;
  String? _userErrorMessage;
  String? _passwordErrorMessage;

  AutovalidateMode _autoValidateUser = AutovalidateMode.disabled;
  AutovalidateMode _autoValidatePassword = AutovalidateMode.disabled;

  final _userKey = GlobalKey<FormFieldState>();
  final _passwordKey = GlobalKey<FormFieldState>();
  final _doneButtonKey = GlobalKey();

  void _updateUserErrorMessage(String? value) {
    userHasError = value != null;
    Future.microtask(() async {
      if (!disposed) {
        setState(() {
          _userErrorMessage = value;
        });
      }
    });
  }

  void _updatePasswordErrorMessage(String? value) {
    passwordHasError = value != null;
    Future.microtask(() async {
      if (!disposed) {
        setState(() {
          _passwordErrorMessage = value;
        });
      }
    });
  }

  void _updatePasswordValidator(bool shouldValidate) {
    Future.microtask(() async {
      setState(() {
        _autoValidatePassword = shouldValidate
            ? AutovalidateMode.always
            : AutovalidateMode.disabled;
        setState(() {});
      });
    });
  }

  void _updateUserValidator(bool shouldValidate) {
    Future.microtask(() async {
      if (!disposed) {
        setState(() {
          _autoValidateUser = shouldValidate
              ? AutovalidateMode.always
              : AutovalidateMode.disabled;
          setState(() {});
        });
      }
    });
  }

  void _launchURL() async {
    final Uri url = Uri.parse('https://www.google.com.br');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  void doneButtonClick() {
    if (!_doneButtonDisabled) {
      bool isValidData = true;
      _doneButtonDisabled = true;
      _passwordKey.currentState?.validate();

      if (passwordHasError) {
        if (_autoValidatePassword != AutovalidateMode.always) {
          _updatePasswordValidator(true);
        }
        isValidData = false;
      }

      _userKey.currentState?.validate();

      if (userHasError) {
        if (_autoValidateUser != AutovalidateMode.always) {
          _updateUserValidator(true);
        }
        isValidData = false;
      }

      if (isValidData) {
        WidgetsBinding.instance.addPostFrameCallback((_) =>
            ScaffoldMessenger.of(context).snackBar("Loading next page", null));
      }
      _doneButtonDisabled = false;
    }
  }

//Color
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),

      //Parent container- has paddings and background gradient
      body: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0, 1],
            colors: [
              Color.fromARGB(255, 33, 76, 95),
              Color.fromARGB(255, 44, 151, 143),
            ],
          ),
        ),
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Spacer(),

              // User TextForm Container - Contains form text and validator data
              MyFormData(
                'Login',
                autoValidate: _autoValidateUser,
                formKey: _userKey,
                textInputAction: TextInputAction.next,
                errorMessage: _userErrorMessage,
                validator: (value) {
                  _updateUserErrorMessage((value == null)
                      ? "User field is needed!"
                      : value.isValidUser());
                  return null;
                },
                prefixIcon: const IconButton(
                  icon: Icon(Icons.person),
                  color: Colors.black,
                  enableFeedback: false,
                  onPressed: null,
                ),
                onChanged: (text) {
                  _user = text;
                },
              ),

              // password Text Container
              MyFormData(
                'Password',
                obscureText: _passwordObscured,
                autoValidate: _autoValidatePassword,
                formKey: _passwordKey,
                errorMessage: _passwordErrorMessage,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) {
                  doneButtonClick();
                },
                validator: (value) {
                  _updatePasswordErrorMessage((value == null)
                      ? "Password field is needed!"
                      : value.isValidPassword());
                  return null;
                },
                prefixIcon: const IconButton(
                  icon: Icon(Icons.lock),
                  color: Colors.black,
                  enableFeedback: false,
                  onPressed: null,
                ),
                suffixIcon: IconButton(
                    icon: Icon(
                        _passwordObscured
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Theme.of(context).primaryColorDark),
                    onPressed: () {
                      setState(() {
                        _passwordObscured = !_passwordObscured;
                      });
                    }),
                onChanged: (text) {
                  _user = text;
                },
              ),

              const SizedBox(height: 16),

              //Login Button
              ElevatedButton(
                  key: _doneButtonKey,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 69, 189, 111),
                  ),
                  onPressed: () {
                    doneButtonClick();
                  },
                  child: const Text(
                    "Logar",
                    style: TextStyle(color: Colors.white),
                  )),

              const Spacer(),

              //Privacy Button
              Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: TextButton(
                      onPressed: _launchURL,
                      child: const Text(
                        "Política de privacidade",
                        style: TextStyle(color: Colors.white),
                      ))),
            ]),
      ),
    );
  }
}
