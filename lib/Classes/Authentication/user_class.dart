import 'dart:convert';

UserClass userClassJson(String str) => UserClass.fromJson(json.decode(str));

class UserClass {
  String? token;
  String? username;
  String? email;

  UserClass({
    this.token,
    this.email,
    this.username,
  });

  UserClass.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    email = json['email'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["token"] = token;
    data["user"]["username"] = username;
    data["user"]["email"] = email;

    return data;
  }
}
