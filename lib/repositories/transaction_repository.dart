import 'dart:developer';

import 'package:despesas_app/common/constants/queries/get_all_transactions.dart';
import 'package:despesas_app/common/models/transaction_model.dart';
import 'package:despesas_app/locator.dart';
import 'package:despesas_app/services/graphql_service.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

abstract class TransactionRepository {
  Future<void> addTransaction();
  Future<List<TransactionModel>> getAllTransactions();
}

class TransactionRepositoryImpl implements TransactionRepository {
  final client = locator.get<GraphQLService>().client;

  TransactionRepositoryImpl(GraphQLService graphQLService);

  @override
  Future<void> addTransaction() {
    // TODO: implement addTransaction
    throw UnimplementedError();
  }

  @override
  Future<List<TransactionModel>> getAllTransactions() async {
    try{
      final response = 
        await client.query(QueryOptions(document: gql(qGetAllTransactions)));

        final parsedData = List.from(response.data?['transaction'] ?? []);

        final transactions = parsedData.map((e) => TransactionModel.fromMap(e)).toList();

        return transactions;
    } catch(e) {
      rethrow;
    }
  }
}
