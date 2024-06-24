import 'package:flutter/material.dart';

class Greetings extends StatefulWidget {
  const Greetings({super.key});

  @override
  State<Greetings> createState() => _GreetingsState();
}

class _GreetingsState extends State<Greetings> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.deepOrange,
      child: Column(
        children: [
          Container(
              alignment: Alignment.center,
              width: size.width * 0.92,
              height: 60.0,
              decoration: const BoxDecoration(
                color: Colors.deepOrange,
              ),
              child: const Column(
                children: [
                  Text(
                    'Good Morning',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Roboto-Condensed',
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    'Moses',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Roboto-Condensed',
                    ),
                  ),
                ],
              )),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
