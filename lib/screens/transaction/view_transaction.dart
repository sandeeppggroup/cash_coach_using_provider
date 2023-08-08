import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: camel_case_types, must_be_immutable
class View_Transaction extends StatelessWidget {
  double amount;
  String category;
  String description;
  DateTime date;

  View_Transaction(
      {super.key,
      required this.amount,
      required this.category,
      required this.description,
      required this.date});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          
          backgroundColor: const Color.fromARGB(255, 3, 20, 114),
          
          title: const Text(
            'Transaction Details',
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.w700),
          ),
          centerTitle: true,
          
          
        ),
        backgroundColor: Colors.white,
        body: Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.9),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.circular(30),
                gradient: const LinearGradient(colors: [
                  Colors.white,
                  Colors.white,
                ])),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Details',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w800,
                        color: Color.fromARGB(255, 4, 78, 207))),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: ListTile(
                    leading: const Icon(
                      Icons.note_add,
                      color: Color.fromARGB(255, 4, 78, 207),
                      size: 30,
                    ),
                    title: Text(
                      'Notes : $description',
                      style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 4, 78, 207)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: ListTile(
                    leading: const Icon(
                      Icons.currency_rupee,
                      color: Color.fromARGB(255, 4, 78, 207),
                      size: 30,
                    ),
                    title: Text(
                      'Amount : $amount',
                      style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 4, 78, 207)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: ListTile(
                    leading: const Icon(
                      Icons.calendar_month,
                      color: Color.fromARGB(255, 4, 78, 207),
                      size: 30,
                    ),
                    title: Text(
                      'Date : ${parseDate(date)}',
                      style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 4, 78, 207)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: ListTile(
                    leading: const Icon(
                      Icons.dashboard,
                      color: Color.fromARGB(255, 4, 78, 207),
                      size: 30,
                    ),
                    title: Text(
                      'Category : $category',
                      style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 4, 78, 207)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  String parseDate(DateTime date) {
    final date0 = DateFormat.MMMd().format(date);
    final splitedDate = date0.split(' ');
    return '${splitedDate.last}${splitedDate.first}';
  }
}
