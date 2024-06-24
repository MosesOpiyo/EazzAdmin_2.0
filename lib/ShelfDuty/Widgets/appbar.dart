import 'package:flutter/material.dart';

class ShelfDutyAppbar extends StatelessWidget {
  const ShelfDutyAppbar({super.key});

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
          'Shelf Duty',
          style: TextStyle(
              fontFamily: 'Roboto-Condensed',
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.black),
        ),
        backgroundColor: Colors.grey[50],
        automaticallyImplyLeading: false,
        expandedHeight: 50,
        actions: [
          IconButton(
            color: Colors.grey,
            icon: const Icon(Icons.search),
            onPressed: () {
              // Handle settings button pressed
            },
          )
        ],
      ),
    );
  }
}

class ShelfScanAppbar extends StatelessWidget {
  const ShelfScanAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Scan',
          style: TextStyle(
              fontFamily: 'Roboto-Condensed',
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.white),
        ),
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
      ),
    );
  }
}
