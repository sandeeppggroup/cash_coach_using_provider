import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:money_management/db_functions/transactions/transaction_db.dart';
import 'package:money_management/screens/edit_transaction/edit_transaction.dart';
import 'package:money_management/screens/transaction/view_transaction.dart';
import '../../models/category/category_model.dart';
import '../../models/transaction/transaction_model.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 3, 20, 114),
          centerTitle: true,
          title: const Text('Search'),
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.9),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.circular(30)),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      focusedBorder: InputBorder.none,
                      labelText: 'Search',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusColor: Colors.white),
                  onChanged: (purpose) {
                    TransactionDB.instance.search(purpose);
                  },
                ),
              ),
            ),
            ValueListenableBuilder(
              valueListenable: TransactionDB.instance.transactionListNOtifier,
              builder: (BuildContext context, List<TransactionModel> newList,
                  Widget? _) {
                return Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(10),
                    itemBuilder: (context, index) {
                      final value = newList[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => View_Transaction(
                                        amount: value.amount,
                                        category: value.category.name,
                                        description: value.discription,
                                        date: value.date,
                                      )));
                        },
                        child: Slidable(
                          startActionPane: ActionPane(
                            motion: const StretchMotion(),
                            children: [
                              SlidableAction(
                                borderRadius: BorderRadius.circular(30),
                                spacing: 13,
                                padding: const EdgeInsets.all(8),
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                                icon: IconlyLight.edit,
                                label: 'Edit',
                                onPressed: (context) {
                                  final model = TransactionModel(
                                      discription: value.discription,
                                      amount: value.amount,
                                      date: value.date,
                                      category: value.category,
                                      type: value.type,
                                      id: value.id);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditTransaction(
                                        model: model,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              SlidableAction(
                                borderRadius: BorderRadius.circular(30),
                                spacing: 8,
                                backgroundColor: Colors.pink,
                                foregroundColor: Colors.white,
                                icon: IconlyLight.delete,
                                label: 'Delete',
                                onPressed: (context) {
                                  value;

                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Delete'),
                                        content: const Text(
                                            'Are you sure!  Do you want to delete this transaction?'),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('Cancel')),
                                          TextButton(
                                              onPressed: () {
                                                TransactionDB.instance
                                                    .deleteTransaction(
                                                        value.id!);
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('Ok'))
                                        ],
                                      );
                                    },
                                  );
                                },
                              )
                            ],
                          ),
                          child: Card(
                            // elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            color: const Color.fromARGB(255, 4, 78, 207),
                            child: ListTile(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              leading: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.06,
                                width: MediaQuery.of(context).size.width * 0.2,
                                decoration: BoxDecoration(
                                    color: value.type == CategoryType.income
                                        ? Colors.green
                                        : Colors.red,
                                    borderRadius: BorderRadius.circular(50)),
                                child: Center(
                                  child: Text(
                                    parseDate(value.date),
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                              title: Padding(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        0.05),
                                child: Text(
                                  ' ${value.category.name}',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                              ),
                              trailing: Text(
                                "₹ ${value.amount}",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.001,
                      );
                    },
                    itemCount: newList.length,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  String parseDate(DateTime date) {
    final date0 = DateFormat.MMMd().format(date);
    final splitedDate = date0.split(' ');
    return '${splitedDate.last}\n${splitedDate.first}';
  }
}
