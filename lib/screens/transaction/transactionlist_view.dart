import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:money_management/db_functions/transactions/transaction_db.dart';
import 'package:money_management/screens/transaction/view_transaction.dart';
import '../../../models/category/category_model.dart';
import '../../../models/transaction/transaction_model.dart';
import '../edit_transaction/edit_transaction.dart';

// ignore: prefer_typing_uninitialized_variables
late var dropDownVale;

// ignore: must_be_immutable
class TransationListView extends StatefulWidget {
  TransationListView({
    Key? key,
    required this.results,
  }) : super(key: key);

  List<TransactionModel> results = [];

  @override
  State<TransationListView> createState() => _DropdownListState();
}

class _DropdownListState extends State<TransationListView> {
  String parseDate(DateTime date) {
    return DateFormat.MMMd().format(date);
  }

  String dropdownvalue = 'All';
  var items = [
    'All',
    'income',
    'Expense',
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log(widget.results.length.toString());
    return Material(
      color: Colors.white,
      child: widget.results.isNotEmpty
          ? ListView.separated(
              padding: const EdgeInsets.all(10),
              itemBuilder: (context, index) {
                final value = widget.results[index];
                log(value.id.toString(), name: 'valu check');
                return GestureDetector(
                  onTap: () {
                    log(value.id.toString(), name: 'gesture');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => View_Transaction(
                          amount: value.amount,
                          category: value.category.name,
                          description: value.discription,
                          date: value.date,
                        ),
                      ),
                    );
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
                            log(value.id.toString(), name: 'et chec');
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
                                              .deleteTransaction(value.id!);
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
                          height: MediaQuery.of(context).size.height * 0.06,
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
                              left: MediaQuery.of(context).size.width * 0.05),
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
                  height: MediaQuery.of(context).size.width * 0.02,
                );
              },
              itemCount: widget.results.length,
            )
          : Center(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Center(
                      child: Lottie.asset(
                        'images/empty.json',
                      ),
                    ),
                  ),
                  const Text(
                    'Data is empty',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
    );
  }
}
