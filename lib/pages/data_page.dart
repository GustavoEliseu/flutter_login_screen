import 'package:flutter/material.dart';
import 'package:flutter_login_screen/models/typed_text.dart';
import 'package:flutter_login_screen/store/user.dart';
import 'package:uuid/uuid.dart';
import 'package:provider/provider.dart';

class MyDataScreen extends StatefulWidget {
  const MyDataScreen(this.logoffFun, {super.key, required this.title});
  final Function() logoffFun;
  final String title;

  @override
  State<MyDataScreen> createState() => _MyDataScreenState();
}

class _MyDataScreenState extends State<MyDataScreen> {
  late UserStore userStore;
  bool wasListInitialized = false;
  List<TypedText> _dataTyped = [];

  final _dataTextFormKey = GlobalKey<FormFieldState>();
  TextEditingController textEditController = TextEditingController();

  Future<void> _saveList(UserStore userStore) async {
    if (userStore.userTypedTextList != null) {
      userStore.userTypedTextList?.typedTexts = _dataTyped;
      userStore.saveCurrentList();
    } //TODO - add warning and create userTypedTextList if it's null for some reason
  }

  Future<void> _addValueToList(String textToAdd, UserStore userStore) async {
    var uuid = const Uuid();
    setState(() {
      _dataTyped.add(TypedText(textToAdd,
          uuid.v5(Uuid.NAMESPACE_URL, userStore.userTypedTextList!.userName)));
      _saveList(userStore);
    });
  }

  @override
  Widget build(BuildContext context) {
    userStore = Provider.of<UserStore>(context);
    if (!wasListInitialized) {
      _dataTyped = userStore.userTypedTextList?.typedTexts ?? [];
      wasListInitialized = true;
    }
    return Scaffold(
        extendBodyBehindAppBar: true,
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
            child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              return Column(
                children: <Widget>[
                  const Spacer(),
                  SingleChildScrollView(
                      child: Container(
                          height: 400,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.only(top: 10),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Column(
                              mainAxisAlignment: _dataTyped.isNotEmpty
                                  ? MainAxisAlignment.start
                                  : MainAxisAlignment.center,
                              crossAxisAlignment: _dataTyped.isNotEmpty
                                  ? CrossAxisAlignment.start
                                  : CrossAxisAlignment.center,
                              children: _dataTyped.isNotEmpty
                                  ? _dataTyped
                                      .map<Widget>((v) => Column(children: [
                                            Container(
                                                width: 300,
                                                decoration: const BoxDecoration(
                                                  color: Colors.grey,
                                                ),
                                                alignment: Alignment.center,
                                                height: 50,
                                                child: Text(v.text)),
                                            const SizedBox(height: 10),
                                          ]))
                                      .toList()
                                  : [
                                      const Text(
                                          "Seems empty here... Type something!")
                                    ]))),
                  const SizedBox(height: 16),
                  SizedBox(
                      height: 84,
                      width: 300,
                      child: TextFormField(
                        key: _dataTextFormKey,
                        controller: textEditController,
                        decoration: InputDecoration(
                          error: null,
                          fillColor: Colors.white,
                          filled: true,
                          suffixIcon: IconButton(
                              onPressed: () {
                                if (textEditController.text.isNotEmpty) {
                                  _addValueToList(
                                      textEditController.text, userStore);
                                  textEditController.clear();
                                }
                              },
                              icon: const Icon(Icons.send)),
                          border: const OutlineInputBorder(),
                          labelText: '',
                        ),
                        onFieldSubmitted: (text) {
                          if (text.isNotEmpty) {
                            _addValueToList(text, userStore);
                            textEditController.clear();
                          }
                        },
                      )),
                  const Spacer(),
                ],
              );
            })));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    userStore
        .logout(); //TODO = Check if logout is being called when going back to login Screen
    super.dispose();
  }
}
