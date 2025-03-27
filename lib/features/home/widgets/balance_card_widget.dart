import 'dart:developer';

import 'package:despesas_app/common/constants/app_colors.dart';
import 'package:despesas_app/common/constants/app_text_styles.dart';
import 'package:despesas_app/common/extensions/sizes.dart';
import 'package:flutter/material.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({
    super.key,
    required this.totalAmount,
    required this.incomeAmount,
    required this.outcomeAmount,
  });

  final double totalAmount;
  final double incomeAmount;
  final double outcomeAmount;

  @override
  Widget build(BuildContext context) {
    double textScaleFactor =
        MediaQuery.of(context).size.width < 360 ? 0.7 : 1.0;

    return Positioned(
        left: 24.w,
        right: 24.w,
        top: 155.h,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 24.w,
            vertical: 32.h,
          ),
          decoration: const BoxDecoration(
            color: AppColors.darkGreen,
            borderRadius: BorderRadius.all(
              Radius.circular(16.0),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Saldo',
                          textScaleFactor: textScaleFactor,
                          style: AppTextStyles.mediumText16w600.apply(
                            color: AppColors.white,
                          )),
                      ConstrainedBox(
                        constraints: BoxConstraints.tightFor(width: 250.0.w),
                        child: Text(
                          'R\$ $totalAmount',
                          textScaleFactor: textScaleFactor,
                          style: AppTextStyles.mediumText30.apply(
                            color: AppColors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                  GestureDetector(
                    onTap: () => log('options'),
                    child: PopupMenuButton(
                      padding: EdgeInsets.zero,
                      child: const Icon(
                        Icons.more_horiz,
                        color: AppColors.white,
                      ),
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          height: 24.0,
                          child: Text('Item 1'),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 36.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TransactionValueWidget(amount: incomeAmount),
                  TransactionValueWidget(amount: outcomeAmount),
                ],
              ),
            ],
          ),
        ));
  }
}

class TransactionValueWidget extends StatelessWidget {
  const TransactionValueWidget({
    super.key,
    required this.amount,
  });

  final double amount;

  @override
  Widget build(BuildContext context) {
    double textScaleFactor =
        MediaQuery.sizeOf(context).width <= 360 ? 0.8 : 1.0;

    double iconSize = MediaQuery.sizeOf(context).width <= 360 ? 16.0 : 24.0;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            color: AppColors.white.withOpacity(0.06),
            borderRadius: const BorderRadius.all(
              Radius.circular(16.0),
            ),
          ),
          child: Icon(
            amount.isNegative ? Icons.arrow_upward : Icons.arrow_downward,
            color: AppColors.white,
            size: iconSize,
          ),
        ),
        const SizedBox(width: 4.0),
        Flexible(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                amount.isNegative ? 'Gastos' : 'Receita',
                textScaler: TextScaler.linear(textScaleFactor),
                style: AppTextStyles.mediumText16w500
                    .apply(color: AppColors.white),
              ),
              ConstrainedBox(
                constraints: BoxConstraints.tightFor(width: 120.0.w),
                child: Text(
                  'R\$ ${amount.toStringAsFixed(2)}',
                  textScaler: TextScaler.linear(textScaleFactor),
                  style:
                      AppTextStyles.mediumText16.apply(color: AppColors.white),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
