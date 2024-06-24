// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:eazz_admin/Classes/Receipt/receipt_class.dart';
import 'package:eazz_admin/Configs/config.dart';

class ReceiptService {
  final storage = const FlutterSecureStorage();

  Future<List<ReceiptJsonClass>> getReceipts() async {
    final accessToken = await storage.read(key: 'access_token');
    var url = Uri.parse(ApiConfig.apiUrl + ApiConfig.receipts);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => ReceiptJsonClass.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load receipts');
    }
  }

  Future<ReceiptJsonClass> newReceipt() async {
    final accessToken = await storage.read(key: 'access_token');
    var url = Uri.parse(ApiConfig.apiUrl + ApiConfig.receipts);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      ReceiptJsonClass jsonData =
          ReceiptJsonClass.fromJson(json.decode(response.body));
      return jsonData;
    } else {
      throw Exception('Failed to load receipts');
    }
  }

  Future<ReceiptJsonClass> newReceiptItem(receiptNumber, itemNumber) async {
    final accessToken = await storage.read(key: 'access_token');
    var url = Uri.parse(ApiConfig.apiUrl +
        ApiConfig.itemToReceipt +
        receiptNumber +
        '/$itemNumber');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      ReceiptJsonClass jsonData =
          ReceiptJsonClass.fromJson(json.decode(response.body));
      return jsonData;
    } else {
      throw Exception('Failed to load receipt');
    }
  }
}
