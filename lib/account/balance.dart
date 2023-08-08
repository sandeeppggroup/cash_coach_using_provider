import 'package:flutter/foundation.dart';
import 'package:money_management/db_functions/transactions/transaction_db.dart';
import 'package:money_management/models/category/category_model.dart';

ValueNotifier<num> incomeNotifier = ValueNotifier(0);
ValueNotifier<num> expenseNotifier = ValueNotifier(0);
ValueNotifier<num> totalNotifier = ValueNotifier(0);

Future<void> balanceAmount() async {
  await TransactionDB.instance.getAllTransaction().then((value) {
    incomeNotifier.value = 0;
    expenseNotifier.value = 0;
    totalNotifier.value = 0;

    for (var item in value) {
      if (item.type == CategoryType.income) {
        incomeNotifier.value += item.amount;
      } else {
        expenseNotifier.value += item.amount;
      }
    }
    totalNotifier.value = incomeNotifier.value - expenseNotifier.value;
  });
}
