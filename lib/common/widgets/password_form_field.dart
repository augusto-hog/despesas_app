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
  final FocusNode? focusNode;
  final VoidCallback? onTap;
  final ValueSetter<PointerEvent>? onTapOutside;
  final VoidCallback? onEditingComplete;

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
    this.focusNode,
    this.onTap,
    this.onTapOutside,
    this.onEditingComplete,
  });

  @override
  State<PasswordFormField> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  bool isHidden = true;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
        onTap: widget.onTap,
        onEditingComplete: widget.onEditingComplete ??
            () {
              FocusScope.of(context).nextFocus();
            },
        focusNode: widget.focusNode,
        onTapOutside: widget.onTapOutside ??
            (_) {
              if (FocusScope.of(context).hasFocus) {
                FocusScope.of(context).unfocus();
              }
            },
        validator: widget.validator,
        obscureText: isHidden,
        controller: widget.controller,
        padding: widget.padding,
        helperText: widget.helperText,
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
