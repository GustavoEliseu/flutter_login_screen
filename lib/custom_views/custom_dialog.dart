import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog(this.title, this.text, this.isEdit,
      {this.finish, this.finishEdt, super.key})
      : assert(finish != null || finishEdt != null,
            "At last one of the parameters must not be null");
  final bool isEdit;
  final Function(bool)? finish;
  final Function(String)? finishEdt;
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditController =
        TextEditingController(); //Not entirely good, since it's using memory when it's not needed... but it's not a real app so its ok.
    if (isEdit) {
      textEditController.text = text;
    }
    return Center(
        child: AlertDialog(
      title: Text(title),
      content: isEdit
          ? getFormField(text, textEditController, (value) {
              if (finishEdt != null) {
                finishEdt!(value);
              }
              Navigator.of(context).pop();
            })
          : Text("Do you really wish to delete the text: $text"),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text('Close'),
          onPressed: () {
            if (finish != null) {
              finish!(false);
            }
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: Text(title),
          onPressed: () {
            if (finish != null) {
              finish!(true);
            }
            if (finishEdt != null) {
              finishEdt!(textEditController.text);
            }
            Navigator.of(context).pop();
          },
        ),
      ],
    ));
  }

  TextFormField getFormField(String text,
      TextEditingController textEditController, Function(String) onSubmitted) {
    return TextFormField(
      autofocus: true,
      controller: textEditController,
      decoration: InputDecoration(
        error: null,
        fillColor: Colors.white,
        filled: true,
        suffixIcon: IconButton(
            onPressed: () {
              if (textEditController.text.isNotEmpty) {
                onSubmitted(textEditController.text);
              }
            },
            icon: const Icon(Icons.send)),
        border: const OutlineInputBorder(),
        labelText: '',
      ),
      onFieldSubmitted: (text) {
        if (text.isNotEmpty) {
          onSubmitted(text);
        }
      },
    );
  }
}
