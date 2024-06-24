import 'package:flutter/material.dart';

class BillingAppbar extends StatefulWidget {
  const BillingAppbar({super.key});

  @override
  State<BillingAppbar> createState() => _BillingAppbarState();
}

class _BillingAppbarState extends State<BillingAppbar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: AppBar(
        title: const Text(
          'Billing',
          style: TextStyle(
              fontFamily: 'Roboto-Condensed',
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.black),
        ),
        backgroundColor: Colors.grey[50],
        automaticallyImplyLeading: false,
      ),
    );
  }
}
