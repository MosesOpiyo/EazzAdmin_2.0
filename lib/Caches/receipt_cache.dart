// ignore_for_file: prefer_final_fields

import 'package:eazz_admin/Classes/Receipt/receipt_class.dart';
import 'package:eazz_admin/Service/Receipt/receipt_service.dart';
import 'package:flutter/material.dart';

class ReceiptCache extends ChangeNotifier {
  List<ReceiptJsonClass> _receipts = [];

  List<ReceiptJsonClass> get receipts => _receipts;

  void setData(List<ReceiptJsonClass> newReceipts) {
    _receipts = newReceipts;
    notifyListeners();
  }

  void fetchData() async {
    if (_receipts.isEmpty) {
      List<ReceiptJsonClass> response = await ReceiptService().getReceipts();
      setData(response);
    }
  }
}
