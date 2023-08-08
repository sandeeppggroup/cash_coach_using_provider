import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';

import '../../Account/balance.dart';
import '../../models/category/category_model.dart';
import '../../models/transaction/transaction_model.dart';

const TRANSACTION_DB_NAME = 'transaction-db';

class TransactionProvider with ChangeNotifier {
  List<TransactionModel> transactionList = [];

  List<TransactionModel> incomeListenable = [];
  List<TransactionModel> expenseListenable = [];
  List<TransactionModel> transationAll = [];

  @override
  Future<void> addTransaction(TransactionModel obj) async {
    final transactionDB =
        await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    transactionDB.put(obj.id, obj);

    refresh();
  }

  Future<void> refresh() async {
    final list = await getAllTransaction();
    incomeListenable.clear();
    expenseListenable.clear();
    transationAll.clear();
    await Future.forEach(list, (TransactionModel transation) {
      if (transation.category.type == CategoryType.income) {
        incomeListenable.add(transation);
      } else if (transation.category.type == CategoryType.expense) {
        expenseListenable.add(transation);
      }
    });

    list.sort((first, second) => second.date.compareTo(first.date));
    transactionList.clear();
    transactionList.addAll(list);
    notifyListeners();
    balanceAmount();
  }

  @override
  Future<List<TransactionModel>> getAllTransaction() async {
    final transactionDB =
        await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);

    return transactionDB.values.toList();
  }

  @override
  Future<void> deleteTransaction(String id) async {
    final transactionDB =
        await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await transactionDB.delete(id);
    refresh();
  }

  @override
  Future<void> editTransaction(TransactionModel model) async {
    final transactionDB =
        await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await transactionDB.put(model.id, model);
    refresh();
  }

  Future<void> search(String text) async {
    final transactionDB =
        await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);

    transactionList.clear();
    transactionList.addAll(transactionDB.values
        .where((element) => element.discription.contains(text)));
    notifyListeners();
  }
}
