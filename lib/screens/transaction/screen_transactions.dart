import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_management/db_functions/transactions/transaction_db.dart';
import 'package:money_management/screens/transaction/transactionlist_view.dart';
import 'package:money_management/search/search.dart';

import '../../../models/transaction/transaction_model.dart';
import '../../provider/category_provider/category_provider.dart';

// ignore: camel_case_types
class Screen_Transaction extends StatefulWidget {
  const Screen_Transaction({super.key});

  @override
  State<Screen_Transaction> createState() => _Screen_TransactionState();
}

CategoryProvider categoryProvider = CategoryProvider();

// ignore: camel_case_types
class _Screen_TransactionState extends State<Screen_Transaction>
    with SingleTickerProviderStateMixin {
  Icon cusIcon = const Icon(Icons.search);
  Widget cusSearchBar = const Text("Transactions");
  late TabController _tabController;
  dynamic dropDownVale = 'All';
  @override
  void initState() {
    dropDownVale = 'All';
    results.value.clear();
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    results.notifyListeners();
    results.value = TransactionDB.instance.transactionListNOtifier.value;
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    results.notifyListeners();
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
    _tabController.addListener(() {
      // results.value.clear();

      results.value = TransactionDB.instance.transactionListNOtifier.value;
      // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
      results.notifyListeners();
      setState(
        () {
          filter(dropDownVale);
        },
      );
      // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
      results.notifyListeners();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  DateTime selectedmonth = DateTime.now();
  void _selectDate(context) async {
    final DateTime? picked = await showDatePicker(
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary:
                    Color.fromARGB(213, 20, 27, 38), // header background color
                onPrimary: Colors.white, // header text color
                onSurface: Color.fromARGB(213, 20, 27, 38), // body text color
              ),
            ),
            child: child!,
          );
        },
        context: context,
        initialDate: selectedmonth,
        firstDate: DateTime(2021),
        lastDate: DateTime(2030));

    if (picked != null && picked != selectedmonth) {
      setState(() {
        selectedmonth = picked;
      });
    }
  }

  ValueNotifier<List<TransactionModel>> results = ValueNotifier([]);

  List items = ['All', 'today', 'yesterday', 'week', 'month'];

  String parseDate(DateTime date) {
    return DateFormat.MMMd().format(date);
  }

  @override
  Widget build(BuildContext context) {
    TransactionDB.instance.refresh();
    categoryProvider.refreshUI();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 3, 20, 114),
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: const Text(''),
        title: const Center(
          child: Text('Transactions'),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const Search()));
            },
            icon: const Icon(
              Icons.search,
              size: 35,
            ),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: ValueListenableBuilder(
        valueListenable: TransactionDB.instance.transactionListNOtifier,
        builder: (context, value, child) => ValueListenableBuilder(
          valueListenable: results,
          builder: (context, value, child) => Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.height * 0.33,
                ),
                child: DropdownButton(
                  icon: const Icon(Icons.filter_list_alt),
                  underline: Container(),
                  elevation: 0,
                  borderRadius: BorderRadius.circular(10),
                  items: items.map(
                    (e) {
                      return DropdownMenuItem(
                        value: e,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.height * 0.001),
                          child: Text(e),
                        ),
                      );
                    },
                  ).toList(),
                  onChanged: (newValue) {
                    if (newValue == 'month') {
                      _selectDate(context);
                    }
                    filter(newValue);
                  },
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
                child: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: const Color.fromARGB(255, 4, 78, 207),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 15,
                        offset: Offset(5, 5),
                      ),
                      BoxShadow(
                        color: Colors.white,
                        blurRadius: 15,
                        offset: Offset(-5, -5),
                      ),
                    ],
                  ),
                  labelColor: Colors.white,
                  labelStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),
                  unselectedLabelColor: Colors.black,
                  tabs: const [
                    Tab(
                      text: 'Overview',
                    ),
                    Tab(
                      text: 'Income',
                    ),
                    Tab(
                      text: 'Expense',
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    TransationListView(
                      results: results.value,
                    ),
                    TransationListView(
                      results: results.value,
                    ),
                    TransationListView(
                      results: results.value,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void filter(newValue) {
    log('filter');

    results.value = TransactionDB.instance.transationAll.value;
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    results.notifyListeners();
    setState(
      () {
        dropDownVale = newValue;
      },
    );
    log(results.value.length.toString(), name: 'vvvvvn');
    log(dropDownVale.toString(), name: 'filter');
    final DateTime now = DateTime.now();
    if (dropDownVale == 'All') {
      setState(
        () {
          results.value = (_tabController.index == 0
              ? TransactionDB.instance.transactionListNOtifier.value
              : _tabController.index == 1
                  ? TransactionDB().incomeListenable.value
                  : TransactionDB().expenseListenable.value);
          // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
          results.notifyListeners();
        },
      );
      // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
      results.notifyListeners();
      log(_tabController.index.toString(), name: 'filter_tabe');
    } else if (dropDownVale == 'today') {
      results.value.clear();
      log(dropDownVale);
      setState(
        () {
          results.value = (_tabController.index == 0
                  ? TransactionDB.instance.transactionListNOtifier.value
                  : _tabController.index == 1
                      ? TransactionDB().incomeListenable.value
                      : TransactionDB().expenseListenable.value)
              .where((element) => parseDate(element.date)
                  .toLowerCase()
                  .contains(parseDate(DateTime.now()).toLowerCase()))
              .toList();
          // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
          results.notifyListeners();
        },
      );
      // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
      results.notifyListeners();
      log(_tabController.index.toString(), name: 'filter_tabe');
    } else if (dropDownVale == 'yesterday') {
      results.value.clear();
      setState(
        () {
          DateTime start = DateTime(now.year, now.month, now.day - 1);
          DateTime end = start.add(const Duration(days: 1));
          results.value = (_tabController.index == 0
                  ? TransactionDB.instance.transactionListNOtifier.value
                  : _tabController.index == 1
                      ? TransactionDB().incomeListenable.value
                      : TransactionDB().expenseListenable.value)
              .where((element) =>
                  (element.date.isAfter(start) || element.date == start) &&
                  element.date.isBefore(end))
              .toList();
          // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
          results.notifyListeners();
        },
      );
      // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
      results.notifyListeners();
      log(_tabController.index.toString(), name: 'filter_tabe');
    } else if (dropDownVale == 'week') {
      results.value.clear();
      // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
      results.notifyListeners();
      setState(
        () {
          DateTime start = DateTime(now.year, now.month, now.day - 6);
          DateTime end = DateTime(start.year, start.month, start.day + 7);
          results.value = (_tabController.index == 0
                  ? TransactionDB.instance.transactionListNOtifier.value
                  : _tabController.index == 1
                      ? TransactionDB().incomeListenable.value
                      : TransactionDB().expenseListenable.value)
              .where((element) =>
                  (element.date.isAfter(start) || element.date == start) &&
                  element.date.isBefore(end))
              .toList();
          // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
          results.notifyListeners();
        },
      );
    } else {
      results.value.clear();
      setState(
        () {
          DateTime start = DateTime(selectedmonth.year, selectedmonth.month, 1);
          DateTime end = DateTime(start.year, start.month + 1, start.day);
          results.value = (_tabController.index == 0
                  ? TransactionDB.instance.transactionListNOtifier.value
                  : _tabController.index == 1
                      ? TransactionDB().incomeListenable.value
                      : TransactionDB().expenseListenable.value)
              .where((element) =>
                  (element.date.isAfter(start) || element.date == start) &&
                  element.date.isBefore(end))
              .toList();
          // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
          results.notifyListeners();
        },
      );
    }
  }
}
