import 'dart:convert';

TokenClass tokenClassJson(String str) => TokenClass.fromJson(json.decode(str));

class TokenClass {
  String? accessToken;
  String? refreshToken;
  String? message;

  TokenClass({this.accessToken, this.refreshToken, this.message});

  TokenClass.fromJson(Map<String, dynamic> json) {
    accessToken = json['access'];
    refreshToken = json['refresh'];
    message = json['message'];
  }
}
