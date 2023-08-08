import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:money_management/account/balance.dart';
import 'package:money_management/models/category/category_model.dart';
import 'package:money_management/models/transaction/transaction_model.dart';
import 'package:money_management/provider/transaction_provider/transaction_provider.dart';
import 'package:money_management/screens/drawer_pages/about.dart';
import 'package:money_management/screens/drawer_pages/privacy_policy.dart';
import 'package:money_management/screens/drawer_pages/terms.dart';
import 'package:money_management/screens/edit_transaction/edit_transaction.dart';
import 'package:money_management/screens/screen_splash/splash_two.dart';
import 'package:money_management/screens/transaction/screen_transactions.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../provider/category_provider/category_provider.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

CategoryProvider categoryProvider = CategoryProvider();

class _ScreenHomeState extends State<ScreenHome> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<TransactionProvider>(context, listen: false).refresh();

    balanceAmount();
    categoryProvider.refreshUI();
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 3, 20, 114),
        title: const Text(
          'Welcome To Cash Coach',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 3, 20, 114),
              ),
              child: Center(
                child: Text(
                  'Cash Coach',
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
              ),
            ),
            ListTile(
              title: Row(
                children: [
                  const Icon(Icons.person),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.03,
                  ),
                  const Text('About'),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutScreen()),
                );
              },
            ),
            ListTile(
              title: Row(
                children: [
                  const Icon(Icons.restore_page_outlined),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.03,
                  ),
                  const Text('Reset'),
                ],
              ),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Reset data?'),
                        content: const Text(
                            'Are you sure?Do you want to reset entire data'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Cancel')),
                          TextButton(
                              onPressed: () async {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                await prefs.clear();
                                SharedPreferences textcontrol =
                                    await SharedPreferences.getInstance();
                                await textcontrol.clear();
                                final transactionDb =
                                    await Hive.openBox<TransactionModel>(
                                        'transaction-db');
                                final categorydb =
                                    await Hive.openBox<CategoryModel>(
                                        'category_database');

                                categorydb.clear();
                                transactionDb.clear();
                                incomeNotifier = ValueNotifier(0);
                                expenseNotifier = ValueNotifier(0);
                                totalNotifier = ValueNotifier(0);

                                // ignore: use_build_context_synchronously
                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                  builder: (context) => const ScreenSplashTwo(),
                                ));
                              },
                              child: const Text('Ok'))
                        ],
                      );
                    });
              },
            ),
            ListTile(
              title: Row(
                children: [
                  const Icon(Icons.share),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.03,
                  ),
                  const Text('Share'),
                ],
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Row(
                children: [
                  const Icon(Icons.money_outlined),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.03,
                  ),
                  const Text('Terms and conditions'),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TermsConditions()),
                );
              },
            ),
            ListTile(
              title: Row(
                children: [
                  const Icon(Icons.privacy_tip),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.03,
                  ),
                  const Text('Privacy policy'),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PrivacyPolicy()),
                );
              },
            ),
            ListTile(
              title: Row(
                children: [
                  const Icon(Icons.arrow_back),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.03,
                  ),
                  const Text('Back to app'),
                ],
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .18,
            ),
            const Center(
              child: Text(
                'Version 1.0.1',
                style: TextStyle(fontSize: 13),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.325,
            // width: MediaQuery.of(context).size.width * 0.7,
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 3, 20, 114),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.001,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Current balance',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w700),
                      ),
                      ValueListenableBuilder(
                        valueListenable: totalNotifier,
                        builder: (context, value, child) {
                          return Text(
                            totalNotifier.value.toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 35,
                                fontWeight: FontWeight.w500),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: MediaQuery.of(context).size.width * 0.41,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(255, 4, 78, 207),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: CircleAvatar(
                                backgroundColor: Colors.green,
                                child: Icon(
                                  Icons.arrow_downward,
                                  color: Colors.white,
                                  size: MediaQuery.of(context).size.width * 0.1,
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.02,
                                ),
                                const Text(
                                  'Income',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.005,
                                ),
                                ValueListenableBuilder(
                                  valueListenable: incomeNotifier,
                                  builder: (context, value, child) {
                                    return Text(
                                      incomeNotifier.value.toString(),
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 22),
                                    );
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: MediaQuery.of(context).size.width * 0.41,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(255, 4, 78, 207),
                        ),
                        child: Row(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.red,
                                    child: Icon(
                                      Icons.arrow_upward,
                                      color: Colors.white,
                                      size: MediaQuery.of(context).size.width *
                                          0.1,
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.02,
                                    ),
                                    const Text(
                                      'Expenses',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.005,
                                    ),
                                    ValueListenableBuilder(
                                      valueListenable: expenseNotifier,
                                      builder: (context, value, child) {
                                        return Text(
                                          expenseNotifier.value.toString(),
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 22),
                                        );
                                      },
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.001,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recent transactions',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Screen_Transaction(),
                        ));
                  },
                  child: const Text(
                    'View all',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Consumer<TransactionProvider>(
              builder: (context, newList, child) => ListView.builder(
                itemCount: newList.transactionList.length,
                // values
                itemBuilder: (BuildContext context, int index) {
                  final values = newList.transactionList[index];
                  log(newList.transactionList[index].id.toString(),
                      name: 'home list');
                  return Slidable(
                    key: Key(values.id.toString()),
                    startActionPane: ActionPane(
                      motion: const StretchMotion(),
                      children: [
                        SlidableAction(
                            spacing: 8,
                            flex: 5,
                            borderRadius: BorderRadius.circular(40),
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            icon: IconlyLight.edit,
                            label: 'Edit',
                            onPressed: (context) {
                              final model = TransactionModel(
                                  discription: values.discription,
                                  amount: values.amount,
                                  date: values.date,
                                  category: values.category,
                                  type: values.type,
                                  id: values.id);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          EditTransaction(model: model)));
                            }),
                        SlidableAction(
                          borderRadius: BorderRadius.circular(40),
                          flex: 4,
                          spacing: 8,
                          backgroundColor: Colors.pink,
                          foregroundColor: Colors.white,
                          icon: IconlyLight.delete,
                          label: 'Delete',
                          onPressed: (context) {
                            values.id;

                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Delete'),
                                  content: const Text(
                                      'Are you sure?Do you want to delete this transaction?'),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Cancel')),
                                    TextButton(
                                        onPressed: () {
                                          newList.deleteTransaction(values.id!);
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
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 8, right: 8, bottom: 5),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.09,
                        child: Card(
                          color: const Color.fromARGB(255, 4, 78, 207),
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          child: Center(
                            child: ListTile(
                              title: Padding(
                                padding: const EdgeInsets.only(left: 30),
                                child: Text(
                                  ' ${values.category.name}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: values.type == CategoryType.income
                                        ? Colors.white
                                        : Colors.white,
                                  ),
                                ),
                              ),
                              leading: CircleAvatar(
                                radius: 28,
                                backgroundColor:
                                    values.type == CategoryType.income
                                        ? Colors.green
                                        : Colors.red,
                                child: Text(
                                  parseDateForHomeRecentTransaction(
                                      values.date),
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                              ),
                              trailing: Text(
                                "₹ ${values.amount}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: values.type == CategoryType.income
                                      ? Colors.white
                                      : Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  String parseDateForHomeRecentTransaction(DateTime date) {
    final date0 = DateFormat.MMMd().format(date);
    final splitedDate = date0.split(' ');
    return '  ${splitedDate.last} \n ${splitedDate.first}';
  }
}
