import 'package:flutter/material.dart';

class CommonTextIconButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function function;
  const CommonTextIconButton({super.key, required this.text, required this.icon, required this.function});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        onPressed: () =>function(),
        icon: Icon(icon),
        label: Text(text));
  }
}
