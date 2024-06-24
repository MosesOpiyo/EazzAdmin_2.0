import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConfig {
  static String apiUrl = dotenv.env['DEV_API_URL']!;
  static String login = '/Service/Authentication/Login';
  static String receipts = '/Service/Receipt/Receipts';
  static String itemToReceipt = '/Service/Receipt/ItemsToReceipt/';
}
