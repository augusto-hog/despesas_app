
import 'package:despesas_app/common/models/balances_model.dart';
import 'package:despesas_app/repositories/transaction_repository.dart';
import 'balance_card_widget_state.dart';
import 'package:flutter/material.dart';

class BalanceCardWidgetController extends ChangeNotifier {
  final TransactionRepository transactionRepository;
  BalanceCardWidgetController( {
    required this.transactionRepository,
  });

  BalanceCardWidgetState _state = BalanceCardWidgetStateInitial();

  BalanceCardWidgetState get state => _state;

  BalancesModel _balances = BalancesModel(
    totalIncome: 0,
    totalOutcome: 0,
    totalBalance: 0,
  );

  BalancesModel get balances => _balances;

  void _changeState(BalanceCardWidgetState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> getBalances() async {
    _changeState(BalanceCardWidgetStateLoading());
    try {
      await Future.delayed(const Duration(seconds: 2));
      _balances = await transactionRepository.getBalances();
      _changeState(BalanceCardWidgetStateSuccess());
    } catch (e) {
      _changeState(BalanceCardWidgetStateError());
    }
  }
}
