import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  const RoundButton(
      {super.key,
        required this.colour,
        required this.press,
        required this.name});
  final Color colour;
  final VoidCallback press;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(30.0),
        color: colour,
        child: MaterialButton(
          onPressed: press,
          minWidth: 200.0,
          height: 42.0,
          child: Text(name),
        ),
      ),
    );
  }
}