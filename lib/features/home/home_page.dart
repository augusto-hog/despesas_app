import 'package:despesas_app/common/widgets/app_header.dart';
import 'package:despesas_app/features/home/home_controller.dart';
import 'package:despesas_app/features/home/home_state.dart';
import 'package:despesas_app/common/widgets/transaction_listview.dart';
import 'package:despesas_app/features/home/widgets/balance_card/balance_card_widget.dart';
import 'package:despesas_app/features/home/widgets/balance_card/balance_card_widget_controller.dart';
import 'package:despesas_app/locator.dart';
import 'package:flutter/material.dart';

import '../../common/constants/app_colors.dart';
import '../../common/constants/app_text_styles.dart';
import '../../common/extensions/sizes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double get textScaleFactor =>
      MediaQuery.of(context).size.width < 360 ? 0.7 : 1.0;
  double get iconSize => MediaQuery.of(context).size.width < 360 ? 16.0 : 24.0;

  final controller = locator.get<HomeController>();
  final balanceController = locator.get<BalanceCardWidgetController>();

  @override
  void initState() {
    super.initState();
    controller.getAllTransactions();
    balanceController.getBalances();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const AppHeader(),
          Positioned(
            left: 24.w,
            right: 24.w,
            top: 155.h,
            child: BalanceCard(
              controller: balanceController,
            ),
          ),
          Positioned(
            top: 397.h,
            left: 5,
            right: 5,
            bottom: 0,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Histórico de Transações',
                        style: AppTextStyles.mediumText18,
                      ),
                      Text(
                        'Ver tudo',
                        style: AppTextStyles.inputLabelText,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: AnimatedBuilder(
                      animation: controller,
                      builder: (context, _) {
                        if (controller.state is HomeStateLoading) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.green,
                            ),
                          );
                        }
                        if (controller.state is HomeStateError) {
                          return const Center(
                            child: Text('Erro ao carregar transações'),
                          );
                        }
                        if (controller.transactions.isEmpty) {
                          return const Center(
                            child: Text('Nenhuma transação encontrada'),
                          );
                        }
                        return TransactionListView(
                          transactionList: controller.transactions,
                          itemCount: 5,
                        );
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
