import 'package:despesas_app/features/home/home.dart';
import 'package:despesas_app/locator.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../extensions/extensions.dart';

class GreetingsWidget extends StatelessWidget {
  const GreetingsWidget({
    super.key,
  });

  String get _greeting {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return 'Bom dia';
    } else if (hour < 18) {
      return 'Boa tarde';
    } else {
      return 'Boa noite';
    }
  }

  @override
  Widget build(BuildContext context) {
    double textScaleFactor = MediaQuery.of(context).size.width < 360 ? 0.7 : 1.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _greeting,
          textScaleFactor: textScaleFactor,
          style: AppTextStyles.mediumText20.apply(color: AppColors.white),
        ),
        Text(
          (locator.get<HomeController>().userData.name ?? '').capitalize().firstWord,
          textScaleFactor: textScaleFactor,
          style: AppTextStyles.mediumText20.apply(color: AppColors.white),
        ),
      ],
    );
  }
}
