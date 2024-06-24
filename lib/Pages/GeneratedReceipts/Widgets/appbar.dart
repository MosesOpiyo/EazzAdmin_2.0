import 'package:flutter/material.dart';

class GeneratedReceiptsAppbar extends StatelessWidget {
  const GeneratedReceiptsAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(top: 10),
      sliver: SliverAppBar(
        pinned: true,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Receipts',
          style: TextStyle(
              fontFamily: 'Roboto-Condensed',
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.black),
        ),
        backgroundColor: Colors.grey[50],
        expandedHeight: 50,
        actions: [
          IconButton(
            color: Colors.grey,
            icon: const Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
