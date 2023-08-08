// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_management/account/balance.dart';
import 'package:money_management/models/category/category_model.dart';
import 'package:money_management/models/transaction/transaction_model.dart';

// ignore: constant_identifier_names
const TRANSACTION_DB_NAME = 'transaction-db';

abstract class TransactionDbFunctions {
  Future<void> addTransaction(TransactionModel obj);
  Future<List<TransactionModel>> getAllTransaction();
  Future<void> deleteTransaction(String id);
  Future<void> editTransaction(TransactionModel model);
}

class TransactionDB implements TransactionDbFunctions {
  TransactionDB._internal();
  static TransactionDB instance = TransactionDB._internal();

  factory TransactionDB() {
    return instance;
  }

  ValueNotifier<List<TransactionModel>> transactionListNOtifier =
      ValueNotifier([]);

  ValueNotifier<List<TransactionModel>> incomeListenable = ValueNotifier([]);
  ValueNotifier<List<TransactionModel>> expenseListenable = ValueNotifier([]);
  ValueNotifier<List<TransactionModel>> transationAll = ValueNotifier([]);

  @override
  Future<void> addTransaction(TransactionModel obj) async {
    final transactionDB =
        await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    transactionDB.put(obj.id, obj);
    log(obj.id.toString(),name:'db func id check');
    refresh();
  }

  Future<void> refresh() async {
    final list = await getAllTransaction();
    incomeListenable.value.clear();
    expenseListenable.value.clear();
    transationAll.value.clear();
    await Future.forEach(list, (TransactionModel transation) {
      if (transation.category.type == CategoryType.income) {
        incomeListenable.value.add(transation);
        // totalAmountVarible = totalAmountVarible + transation.amount;
        // totalIncomeVarible = totalIncomeVarible + transation.amount;
      } else if (transation.category.type == CategoryType.expense) {
        expenseListenable.value.add(transation);
        // totalAmountVarible = totalAmountVarible - transation.amount;
        // totalExpenseVarible = totalExpenseVarible + transation.amount;
      }
      // totalAmountNotifer = ValueNotifier(totalAmountVarible);
      // totalExpenseNotifer = ValueNotifier(totalExpenseVarible);
      // totalIncomeNotifer = ValueNotifier(totalIncomeVarible);
      // totalExpenseNotifer.notifyListeners();
      // totalIncomeNotifer.notifyListeners();
      // totalAmountNotifer.notifyListeners();
    });
    incomeListenable.notifyListeners();
    expenseListenable.notifyListeners();
    list.sort((first, second) => second.date.compareTo(first.date));
    transactionListNOtifier.value.clear();
    transactionListNOtifier.value.addAll(list);
     transactionListNOtifier.notifyListeners();
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

    transactionListNOtifier.value.clear();
    transactionListNOtifier.value.addAll(transactionDB.values
        .where((element) => element.discription.contains(text)));
    transactionListNOtifier.notifyListeners();
  }
}
