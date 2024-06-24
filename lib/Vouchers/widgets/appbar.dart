import 'package:flutter/material.dart';

class VouchersAppbar extends StatelessWidget {
  const VouchersAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(top: 10),
      sliver: SliverAppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Vouchers',
          style: TextStyle(
              fontFamily: 'Roboto-Condensed',
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.black),
        ),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
    );
  }
}
