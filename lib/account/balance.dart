import 'package:flutter/foundation.dart';
import 'package:money_management/models/category/category_model.dart';
import 'package:money_management/provider/transaction_provider/transaction_provider.dart';

ValueNotifier<num> incomeNotifier = ValueNotifier(0);
ValueNotifier<num> expenseNotifier = ValueNotifier(0);
ValueNotifier<num> totalNotifier = ValueNotifier(0);
TransactionProvider transactionProvider = TransactionProvider();
Future<void> balanceAmount() async {
  await transactionProvider.getAllTransaction().then((value) {
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
