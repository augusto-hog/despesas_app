import 'package:despesas_app/common/models/transaction_model.dart';
import 'package:despesas_app/features/home/home_state.dart';
import 'package:despesas_app/repositories/transaction_repository.dart';
import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {

  final TransactionRepository _transactionRepository;

  HomeState _state = HomeStateInitial();

  HomeController(this._transactionRepository);

  HomeState get state => _state;

  List<TransactionModel> _transactions = [];
  List<TransactionModel> get transactions => _transactions;

  void _changeState(HomeState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> getAllTransactions() async {
    _changeState(HomeStateLoading());
    try {
      _transactions = await _transactionRepository.getAllTransactions();
      _changeState(HomeStateSuccess());
    } catch (e) {
      _changeState(HomeStateError());
    }
  }
}