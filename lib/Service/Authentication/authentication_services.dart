import 'dart:convert';
import 'package:eazz_admin/Classes/Authentication/token_class.dart';
import 'package:http/http.dart' as http;
import 'package:eazz_admin/Configs/config.dart';

class APIService {
  var client = http.Client();

  Future<TokenClass> login(String email, String password) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var url = Uri.parse(ApiConfig.apiUrl + ApiConfig.login);
    var response = await http.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({"email": email, "password": password}),
    );
    return tokenClassJson(response.body);
  }
}
