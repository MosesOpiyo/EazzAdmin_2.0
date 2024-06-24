import 'package:flutter/material.dart';

class SignUpButton extends StatefulWidget {
  final Function onPressed;
  const SignUpButton({super.key, required this.onPressed});

  @override
  State<SignUpButton> createState() => _SignUpButtonState();
}

class _SignUpButtonState extends State<SignUpButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(children: [
                TextSpan(
                    text: 'By continuing, you are agreeing to our ',
                    style: TextStyle(color: Colors.grey)),
                TextSpan(
                    text: "User Agreement ",
                    style: TextStyle(color: Colors.deepOrange)),
                TextSpan(
                    text: "and Acknowledge that you understand our ",
                    style: TextStyle(color: Colors.grey)),
                TextSpan(
                    text: "Privacy Policy",
                    style: TextStyle(color: Colors.deepOrange))
              ]),
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 50,
          child: FloatingActionButton.extended(
            tooltip: 'Sign Up',
            heroTag: "Registration",
            backgroundColor: Colors.grey[200],
            onPressed: () {
              widget.onPressed();
            },
            label: const Text(
              'Sign Up',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }
}
