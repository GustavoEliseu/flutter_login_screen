// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UserStore on UserStoreBase, Store {
  late final _$userTypedTextListAtom =
      Atom(name: 'UserStoreBase.userTypedTextList', context: context);

  @override
  UserTypedTextList? get userTypedTextList {
    _$userTypedTextListAtom.reportRead();
    return super.userTypedTextList;
  }

  @override
  set userTypedTextList(UserTypedTextList? value) {
    _$userTypedTextListAtom.reportWrite(value, super.userTypedTextList, () {
      super.userTypedTextList = value;
    });
  }

  late final _$initUserStoreAsyncAction =
      AsyncAction('UserStoreBase.initUserStore', context: context);

  @override
  Future<void> initUserStore(User? user) {
    return _$initUserStoreAsyncAction.run(() => super.initUserStore(user));
  }

  late final _$loginNewUserAsyncAction =
      AsyncAction('UserStoreBase.loginNewUser', context: context);

  @override
  Future<void> loginNewUser(User user) {
    return _$loginNewUserAsyncAction.run(() => super.loginNewUser(user));
  }

  late final _$UserStoreBaseActionController =
      ActionController(name: 'UserStoreBase', context: context);

  @override
  void setUserTypedTextList(UserTypedTextList userTypedTextList) {
    final _$actionInfo = _$UserStoreBaseActionController.startAction(
        name: 'UserStoreBase.setUserTypedTextList');
    try {
      return super.setUserTypedTextList(userTypedTextList);
    } finally {
      _$UserStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void logout() {
    final _$actionInfo = _$UserStoreBaseActionController.startAction(
        name: 'UserStoreBase.logout');
    try {
      return super.logout();
    } finally {
      _$UserStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void saveCurrentList() {
    final _$actionInfo = _$UserStoreBaseActionController.startAction(
        name: 'UserStoreBase.saveCurrentList');
    try {
      return super.saveCurrentList();
    } finally {
      _$UserStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _persistUserListData() {
    final _$actionInfo = _$UserStoreBaseActionController.startAction(
        name: 'UserStoreBase._persistUserListData');
    try {
      return super._persistUserListData();
    } finally {
      _$UserStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
userTypedTextList: ${userTypedTextList}
    ''';
  }
}
