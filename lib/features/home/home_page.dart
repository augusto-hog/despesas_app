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

  final _homeController = locator.get<HomeController>();
  final _balanceController = locator.get<BalanceController>();

  @override
  void initState() {
    super.initState();

    _homeController.getUserData();
    _homeController.getLatestTransactions();
    _balanceController.getBalances();

    _homeController.addListener(_handleHomeStateChange);
  }

  @override
  void dispose() {
    _homeController.removeListener(_handleHomeStateChange);
    super.dispose();
  }

  void _handleHomeStateChange() {
    final state = _homeController.state;
    switch (state.runtimeType) {
      case HomeStateError _:
        if (!mounted) return;

        showCustomModalBottomSheet(
          context: context,
          content: (_homeController.state as HomeStateError).message,
          buttonText: 'Ir para o Login',
          isDismissible: false,
          onPressed: () => Navigator.pushNamedAndRemoveUntil(
            context,
            NamedRoute.login,
            ModalRoute.withName(NamedRoute.initial),
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const AppHeader(),
          BalanceCardWidget(controller: _balanceController),
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
                          _homeController.pageController.jumpToPage(2);
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
                      animation: _homeController,
                      builder: (context, _) {
                        if (_homeController.state is HomeStateLoading) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.green,
                            ),
                          );
                        }
                        if (_homeController.state is HomeStateError) {
                          return const Center(
                            child: Text('Erro ao carregar transações'),
                          );
                        }
                        if (_homeController.state is HomeStateSuccess && _homeController.transactions.isNotEmpty) {
                          return TransactionListView(
                            transactionList: _homeController.transactions,
                            itemCount: _homeController.transactions.length,
                            onChange: () {
                              _homeController.getLatestTransactions();
                              _balanceController.getBalances();
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
