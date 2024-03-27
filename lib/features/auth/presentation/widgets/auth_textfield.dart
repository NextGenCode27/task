import 'package:flutter/material.dart';
import 'package:task/core/themes/color.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.onFieldSubmitted,
    this.focusNode,
    required this.textInputAction,
    this.obScureText = false,
  });
  final String hintText;
  final TextEditingController controller;
  final Function(String)? onFieldSubmitted;
  final FocusNode? focusNode;
  final TextInputAction textInputAction;
  final bool obScureText;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 10,
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: transpanrentColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: transpanrentColor),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: transpanrentColor),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: transpanrentColor),
          ),
          errorStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w300,
          ),
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w300,
          ),
          fillColor: Theme.of(context).colorScheme.background,
          filled: true,
        ),
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        onFieldSubmitted: onFieldSubmitted,
        obscureText: obScureText,
        style: Theme.of(context).textTheme.bodySmall,
        textInputAction: textInputAction,
        validator: (value) {
          if (value!.isEmpty) {
            return '$hintText can not be empty.';
          }
          return null;
        },
      ),
    );
  }
}
