import 'package:flutter/material.dart';
import 'package:task/core/global/widgets/custom_button.dart';

Future<void> showCustomDialogue(
  BuildContext context,
  Size size, {
  required String title,
  required String content,
  required VoidCallback onPressed,
  required String buttonLable,
}) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return Dialog(
        child: Container(
          width: size.width,
          height: size.width * 1.1,
          padding: EdgeInsets.all(size.width * 0.08),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 2.0,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    content,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 2.0,
                    ),
                  ),
                ],
              ),
              CustomButton(
                size: size,
                lable: buttonLable,
                backgroundColor: Theme.of(context).primaryColor,
                onPressed: onPressed,
              ),
            ],
          ),
        ),
      );
    },
  );
}
