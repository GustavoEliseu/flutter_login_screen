class User {
  User(this.name,
      this.password); //Simplified version of an actual user class... no UID, nor data related to app, nor
  String name;
  String password;

  factory User.fromJson(Map<String, dynamic> userTypedTextList) {
    return User(userTypedTextList['text'], userTypedTextList['id']);
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'password': password};
  }
}
