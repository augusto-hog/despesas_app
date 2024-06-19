import 'dart:developer';

import 'package:despesas_app/common/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class PasswordFormField extends StatefulWidget {
  final EdgeInsetsGeometry? padding;
  final String? hintText;
  final String? labelText;
  final TextCapitalization? textCapitalization;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final int? maxLength;
  final TextInputAction? textInputAction;
  final Widget? suffixIcon;
  final String? helperText;
  final FormFieldValidator<String>? validator;

  const PasswordFormField({
    super.key,
    this.padding,
    this.hintText,
    this.labelText,
    this.textCapitalization,
    this.controller,
    this.keyboardType,
    this.maxLength,
    this.textInputAction,
    this.helperText,
    this.suffixIcon,
    this.validator,
  });

  @override
  State<PasswordFormField> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  bool isHidden = true;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      validator: widget.validator,
        obscureText: isHidden,
        controller: widget.controller,
        padding: widget.padding,
        hintText: widget.hintText,
        labelText: widget.labelText,
        suffixIcon: InkWell(
          borderRadius: BorderRadius.circular(23),
          onTap: () {
            log("Olhinho");
            setState(() {
              isHidden = !isHidden;
            });
          },
          child: Icon(isHidden ? Icons.visibility : Icons.visibility_off),
        ));
  }
}
