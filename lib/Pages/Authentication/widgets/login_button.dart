import 'package:flutter/material.dart';

class LoginButton extends StatefulWidget {
  final Function onPressed;

  const LoginButton({super.key, required this.onPressed});

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  bool isClicked = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 50,
          child: FloatingActionButton.extended(
            tooltip: 'Login',
            backgroundColor: Colors.deepOrange,
            onPressed: () {
              widget.onPressed();
            },
            label: isClicked
                ? const CircularProgressIndicator(color: Colors.white)
                : const Text(
                    'Login',
                    style: TextStyle(color: Colors.white),
                  ),
          ),
        ),
      ],
    );
  }
}
