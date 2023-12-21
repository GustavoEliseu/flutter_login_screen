import 'dart:convert';

class TypedText {
  TypedText(this.text, this.id);
  String text;
  String id;

  factory TypedText.fromJson(Map<String, dynamic> userTypedTextList) {
    return TypedText(userTypedTextList['text'], userTypedTextList['id']);
  }

  Map<String, dynamic> toJson() {
    return {'text': text, 'id': id};
  }
}

class UserTypedTextList {
  String userName;
  List<TypedText> typedTexts;
  UserTypedTextList(this.userName, this.typedTexts);

  factory UserTypedTextList.fromJson(Map<String, dynamic> userTypedTextList) {
    return UserTypedTextList(
        userTypedTextList['userName'],
        (userTypedTextList['typedTexts'] as List<dynamic>)
            .map((e) => TypedText.fromJson(e))
            .toList());
  }

  Map<String, dynamic> toJson() {
    return {'userName': userName, 'typedTexts': typedTexts};
  }
}
