import 'package:despesas_app/common/models/transaction_model.dart';

abstract class TransactionRepository {
  Future<void> addTransaction();
  Future<List<TransactionModel>> getAllTransactions();
}

class TransactionRepositoryImpl implements TransactionRepository {
  @override
  Future<void> addTransaction() {
    // TODO: implement addTransaction
    throw UnimplementedError();
  }

  @override
  Future<List<TransactionModel>> getAllTransactions() async {
    await Future.delayed(const Duration(seconds: 2));
    return [
      TransactionModel(
        title: 'Salário',
        value: 1000.0,
        date: DateTime.now().millisecondsSinceEpoch,
      ),
      TransactionModel(
        title: 'Conta de Luz',
        value: -100.0,
        date: DateTime.now()
            .subtract(const Duration(days: 7))
            .millisecondsSinceEpoch,
      ),
      TransactionModel(
        title: 'Conta de Água',
        value: -50.0,
        date: DateTime.now().millisecondsSinceEpoch,
      ),
    ];
  }
}
