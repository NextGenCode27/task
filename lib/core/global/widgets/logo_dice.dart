import 'package:flutter/material.dart';

class LogoDice extends StatelessWidget {
  const LogoDice({
    super.key,
    required this.backgroundColor,
    required this.lable,
  });
  final Color backgroundColor;
  final String lable;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10),
      height: 60,
      width: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: backgroundColor),
      child: Text(
        lable,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onPrimary,
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
