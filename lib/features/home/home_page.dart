import 'package:flutter/material.dart';

import '../../common/features/balance/balance.dart';
import '../../common/constants/constants.dart';
import '../../common/extensions/extensions.dart';
import '../../common/widgets/widgets.dart';
import '../../locator.dart';
import 'home_controller.dart';
import 'home_state.dart';
import 'widgets/balance_card_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with CustomModalSheetMixin {
  double get textScaleFactor => MediaQuery.of(context).size.width < 360 ? 0.7 : 1.0;
  double get iconSize => MediaQuery.of(context).size.width < 360 ? 16.0 : 24.0;

  final homeController = locator.get<HomeController>();
  final balanceController = locator.get<BalanceController>();

  @override
  void initState() {
    super.initState();
    homeController.getLatestTransactions();
    balanceController.getBalances();

    homeController.addListener(() {
      if (homeController.state is HomeStateError) {
        if (!mounted) return;

        showCustomModalBottomSheet(
          context: context,
          content: (homeController.state as HomeStateError).message,
          buttonText: 'Go to login',
          isDismissible: false,
          onPressed: () => Navigator.pushNamedAndRemoveUntil(
            context,
            NamedRoute.login,
            ModalRoute.withName(NamedRoute.initial),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const AppHeader(),
          BalanceCardWidget(controller: balanceController),
          Positioned(
            top: 397.h,
            left: 5,
            right: 5,
            bottom: 0,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Histórico de Transações',
                        style: AppTextStyles.mediumText18,
                      ),
                      GestureDetector(
                        onTap: () {
                          homeController.pageController.jumpToPage(2);
                        },
                        child: const Text(
                          'Ver tudo',
                          style: AppTextStyles.inputLabelText,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: AnimatedBuilder(
                      animation: homeController,
                      builder: (context, _) {
                        if (homeController.state is HomeStateLoading) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.green,
                            ),
                          );
                        }
                        if (homeController.state is HomeStateError) {
                          return const Center(
                            child: Text('Erro ao carregar transações'),
                          );
                        }
                        if (homeController.state is HomeStateSuccess && homeController.transactions.isNotEmpty) {
                          return TransactionListView(
                            transactionList: homeController.transactions,
                            itemCount: homeController.transactions.length,
                            onChange: () {
                              homeController.getLatestTransactions().then((_) => balanceController.getBalances());
                            },
                          );
                        }
                        return const Center(
                          child: Text('Não existem transações cadastradas'),
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
