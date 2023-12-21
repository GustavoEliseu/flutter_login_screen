import 'dart:convert';

import 'package:flutter_login_screen/models/typed_text.dart';
import 'package:flutter_login_screen/models/user_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobx/mobx.dart';

part 'user.g.dart';

class UserStore = UserStoreBase with _$UserStore;

abstract class UserStoreBase with Store {
  UserStoreBase(this.user, this._prefs) {
    initUserStore(user);
  }
  @observable
  UserTypedTextList? userTypedTextList;
  final SharedPreferences _prefs;
  User? user;

  @action
  Future<void> initUserStore(User? user) async {
    userTypedTextList =
        (user != null ? UserTypedTextList(user.name, []) : null);
    _getUserSavedTypedTexts();
  }

  @action
  void setUserTypedTextList(UserTypedTextList userTypedTextList) {
    this.userTypedTextList = userTypedTextList;
  }

  @action
  void logout() {
    user = null;
    _persistUserListData();
  }

  @action
  Future<void> loginNewUser(User user) async {
    this.user = user;
    userTypedTextList = UserTypedTextList(user.name, []);
    _getUserSavedTypedTexts();
  }

  @action
  void saveCurrentList() {
    if (userTypedTextList != null) {
      _prefs.setString(
          userTypedTextList!.userName, jsonEncode(userTypedTextList!.toJson()));
    }
  }

  @action
  void _persistUserListData() {
    if (userTypedTextList == null) {
      return;
    }

    _prefs.setString(
        userTypedTextList!.userName, jsonEncode(userTypedTextList!.toJson()));
    userTypedTextList = null;
  }

  Future<void> _getUserSavedTypedTexts() async {
    final userList = userTypedTextList != null
        ? (_prefs.getString(userTypedTextList!.userName) ?? '')
        : '';

    if (userList.isNotEmpty) {
      userTypedTextList = UserTypedTextList.fromJson(jsonDecode(userList));
    }
  }
}
