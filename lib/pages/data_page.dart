import 'package:flutter/material.dart';
import 'package:flutter_login_screen/models/typed_text.dart';
import 'package:flutter_login_screen/store/user.dart';
import 'package:flutter_login_screen/custom_views/custom_dialog.dart';
import 'package:flutter_login_screen/utils/scaffold_messanger_state_extension.dart';
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
  late FocusNode myFocusNode;

  final _dataTextFormKey = GlobalKey<FormFieldState>();
  TextEditingController textEditController = TextEditingController();

  Future<void> _saveList(UserStore userStore) async {
    if (userStore.userTypedTextList != null) {
      userStore.userTypedTextList?.typedTexts = _dataTyped;
      userStore.saveCurrentList();
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) =>
          ScaffoldMessenger.of(context).snackBar(
              "Falha ao salvar list, logue novamente",
              addClose: true));
      widget.logoffFun();
    }
  }

  Future<void> _addValueToList(String textToAdd, UserStore userStore) async {
    var uuid = const Uuid();
    setState(() {
      _dataTyped.add(TypedText(textToAdd, uuid.v4()));
      _saveList(userStore);
    });
  }

  Future<void> _deleteValueFromList(UserStore userStore, int index) async {
    setState(() {
      _dataTyped.removeAt(index);
      _saveList(userStore);
    });
  }

  Future<void> _editValueFromList(
      UserStore userStore, int index, String editedText) async {
    setState(() {
      _dataTyped[index].text = editedText;
      _saveList(userStore);
    });
  }

  _editValue(String id) {
    int index = _dataTyped.indexWhere((element) => element.id == id);
    if (index >= 0) {
      showDialog(
          context: context,
          builder: (context) => CustomDialog(
                "edit",
                _dataTyped[index].text,
                true,
                finishEdt: (text) {
                  if (text.isNotEmpty) {
                    _editValueFromList(userStore, index, text);
                  }
                  myFocusNode.requestFocus();
                },
              ));
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) =>
          ScaffoldMessenger.of(context)
              .snackBar("Falha ao editar o valor", addClose: true));
      myFocusNode.requestFocus();
    }
  }

  _deleteValue(String id, BuildContext context) {
    int index = _dataTyped.indexWhere((element) => element.id == id);
    if (index >= 0) {
      showDialog(
          context: context,
          builder: (context) => CustomDialog(
                "delete",
                _dataTyped[index].text,
                false,
                finish: (delete) {
                  if (delete) {
                    _deleteValueFromList(userStore, index);
                    myFocusNode.requestFocus();
                  }
                },
              ));
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) =>
          ScaffoldMessenger.of(context)
              .snackBar("Falha ao deletar o valor", addClose: true));
      myFocusNode.requestFocus();
    }
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
                  Container(
                      height: 400,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(top: 10),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
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
                                                alignment: Alignment.center,
                                                padding: const EdgeInsets.only(
                                                    left: 16, right: 16),
                                                height: 70,
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                            child:
                                                                Text(v.text)),
                                                        IconButton(
                                                            onPressed: () {
                                                              _editValue(v.id);
                                                            },
                                                            icon: const Icon(
                                                                Icons.edit)),
                                                        IconButton(
                                                            onPressed: () {
                                                              _deleteValue(v.id,
                                                                  context);
                                                            },
                                                            icon: const Icon(
                                                                Icons.close))
                                                      ],
                                                    ),
                                                    const Divider(
                                                        color: Colors.black)
                                                  ],
                                                )),
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
                        autofocus: true,
                        key: _dataTextFormKey,
                        focusNode: myFocusNode,
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
                                  myFocusNode.requestFocus();
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
                            myFocusNode.requestFocus();
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
    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    userStore
        .logout(); //TODO = Check if logout is being called when going back to login Screen
    super.dispose();
  }
}
