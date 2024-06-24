import 'package:eazz_admin/Pages/Alerts/alerts.dart';
import 'package:eazz_admin/Pages/GeneratedReceipts/generated_receipts.dart';
import 'package:eazz_admin/Pages/Homepage/widgets/greetings.dart';
import 'package:eazz_admin/Pages/NewReceipt/new_receipt.dart';
import 'package:eazz_admin/ShelfDuty/shelf_duty.dart';
import 'package:eazz_admin/Vouchers/vouchers.dart';
import 'package:flutter/material.dart';

class ButtonItem {
  final String name;
  final Icon icon;
  final Widget navigationWidget;

  ButtonItem({
    required this.name,
    required this.icon,
    required this.navigationWidget,
  });
}

final List<ButtonItem> buttons = [
  ButtonItem(
      name: 'New Receipt',
      icon: const Icon(Icons.add_box_outlined, color: Colors.green),
      navigationWidget: const NewReceipt()),
  ButtonItem(
      name: 'Receipts Generated',
      icon: const Icon(Icons.assessment_outlined, color: Colors.deepOrange),
      navigationWidget: const ReceiptStatistics()),
  ButtonItem(
      name: 'Shelf Duty',
      icon: const Icon(Icons.shelves, color: Colors.blue),
      navigationWidget: const ShelfDuty()),
  ButtonItem(
      name: 'Cover Shift',
      icon: const Icon(Icons.switch_account_outlined, color: Colors.deepOrange),
      navigationWidget: const Greetings()),
  ButtonItem(
      name: 'Vouchers Available',
      icon: const Icon(Icons.inventory_2_outlined, color: Colors.deepOrange),
      navigationWidget: const Vouchers()),
  ButtonItem(
      name: 'View Alerts',
      icon: const Icon(Icons.announcement_outlined, color: Colors.red),
      navigationWidget: const Alerts()),
];
