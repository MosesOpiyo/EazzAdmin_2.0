import 'package:flutter/material.dart';

class HomepageAppBar extends StatefulWidget implements PreferredSizeWidget {
  const HomepageAppBar({super.key});

  @override
  State<HomepageAppBar> createState() => _HomepageAppBarState();

  @override
  Size get preferredSize => AppBar().preferredSize;
}

class _HomepageAppBarState extends State<HomepageAppBar> {
  final personName = "Moses";
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.deepOrange,
      automaticallyImplyLeading: false,
      expandedHeight: 40,
      actions: [
        IconButton(
          color: Colors.white,
          icon: const Icon(Icons.notifications_outlined),
          onPressed: () {
            // Handle settings button pressed
          },
        ),
        IconButton(
          color: Colors.white,
          icon: const Icon(Icons.more_vert),
          onPressed: () {
            // Handle settings button pressed
          },
        ),
      ],
    );
  }
}

class Appbar2 extends StatefulWidget {
  const Appbar2({super.key});

  @override
  State<Appbar2> createState() => _Appbar2State();
}

class _Appbar2State extends State<Appbar2> {
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(top: 10),
      sliver: SliverAppBar(
        pinned: true,
        title: const Text(
          'Dashboard',
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
