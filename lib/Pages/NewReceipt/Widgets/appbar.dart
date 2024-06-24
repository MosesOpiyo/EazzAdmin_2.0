import 'package:flutter/material.dart';

class ReceiptAppBar extends StatefulWidget implements PreferredSizeWidget {
  const ReceiptAppBar({super.key});

  @override
  State<ReceiptAppBar> createState() => _ReceiptAppBarState();

  @override
  Size get preferredSize => AppBar().preferredSize;
}

class _ReceiptAppBarState extends State<ReceiptAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.only(top: 10),
      child: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
    );
  }
}
