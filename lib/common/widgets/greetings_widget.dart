import 'package:despesas_app/common/constants/app_colors.dart';
import 'package:despesas_app/common/constants/app_text_styles.dart';
import 'package:flutter/material.dart';
import '../extensions/extensions.dart';
import 'package:despesas_app/locator.dart';
import 'package:despesas_app/services/services.dart';

class GreetingsWidget extends StatelessWidget {
  const GreetingsWidget({super.key});

  String get _greeting {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return 'Bom dia';
    } else if (hour < 18) {
      return 'Boa Tarde';
    } else {
      return 'Boa Noite';
    }
  }

  @override
  Widget build(BuildContext context) {
    double textScaleFactor = MediaQuery.of(context).size.width < 360 ? 0.7 : 1.1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _greeting,
          textScaleFactor: textScaleFactor,
          style: AppTextStyles.smallText.apply(color: AppColors.white),
        ),
        Text(
          (locator.get<UserDataService>().userData.name ?? '').capitalize().firstWord,
          textScaleFactor: textScaleFactor,
          style: AppTextStyles.mediumText20.apply(color: AppColors.white),
        ),
      ],
    );
  }
}
