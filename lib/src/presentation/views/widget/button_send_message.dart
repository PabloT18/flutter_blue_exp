import 'package:flutter/material.dart';

class ButtonMessageCustom extends StatelessWidget {
  const ButtonMessageCustom({
    Key? key,
    required this.onTap,
    required this.message,
  }) : super(key: key);

  final GestureTapCallback onTap;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ElevatedButton(
        child: Text(message),
        onPressed: onTap,
      ),
    );
  }
}
