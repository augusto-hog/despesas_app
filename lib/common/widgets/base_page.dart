import 'package:despesas_app/common/constants/app_colors.dart';
import 'package:flutter/material.dart';

class BasePage extends StatelessWidget {
  const BasePage({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(
            30.0,
          ),
          right: Radius.circular(
            30.0,
          ),
        ),
      ),
      child: child,
    );
  }
}
