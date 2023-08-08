import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_management/models/category/category_model.dart';
import 'package:money_management/models/transaction/transaction_model.dart';
import 'package:money_management/provider/category_provider/category_provider.dart';
import 'package:money_management/provider/transaction_provider/transaction_provider.dart';
import 'package:money_management/screens/category/screen_category.dart';
import 'package:provider/provider.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({super.key});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final _amountController = TextEditingController();

  final _categoryController = TextEditingController();

  final _discriptionController = TextEditingController();

  final _dateController = TextEditingController();

  DateTime? _selectedDate;

  CategoryType? _selectedCategoryType;

  CategoryModel? _selectedCategoryModel;

  String? _categoryID;

  final _formKey = GlobalKey<FormState>();

  String? _inputValue;

  @override
  void initState() {
    _selectedCategoryType = CategoryType.income;
    super.initState();
  }

  // final newValue = CategoryType.income;
  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionProvider>(
      builder: (context, value, _) => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 4, 78, 207),
          centerTitle: true,
          title: const Text(
            'Add Transaction',
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .05,
                ),
                // Textformfield for amount *******************************************  1
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Amount',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    _inputValue == value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter amount';
                    }
                    // Ensure input contains only digits and at most one decimal point
                    final RegExp regex = RegExp(r'^.');
                    if (!regex.hasMatch(value)) {
                      return 'Input must contain only numbers';
                    }

                    // Ensure input is a valid decimal value
                    if (double.tryParse(value) == null) {
                      return 'Input must be a valid decimal value';
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.done,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .03,
                ),
                // Textformfield for Discription *******************************************   2
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Discription',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  controller: _discriptionController,
                  keyboardType: TextInputType.text,
                  onChanged: (value) {},
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your discription';
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.done,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .03,
                ),
                // Textformfield for Date picker *******************************************  3
                // if (_selectedDate == null)
                TextFormField(
                  onTap: () {},
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        selectDate(context);
                      },
                      icon: const Icon(Icons.calendar_today),
                    ),
                    labelText: 'Pick your date',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  readOnly: true,
                  controller: _dateController,
                  keyboardType: TextInputType.text,
                  onChanged: (value) {},
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please select a date';
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.done,
                ),
                // else

                SizedBox(
                  height: MediaQuery.of(context).size.height * .05,
                ),

                // Radiobutton and elevatedButtons *******************************************
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Radio(
                      value: CategoryType.income,
                      groupValue: _selectedCategoryType,
                      onChanged: (newValue) {
                        // setState(() {});
                        _selectedCategoryType = CategoryType.income;
                        _categoryID = null;
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .04,
                      child: ElevatedButton(
                        onPressed: () {
                          // setState(() {});
                          _selectedCategoryType = CategoryType.income;
                          _categoryID = null;
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text('Income'),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .04,
                      child: ElevatedButton(
                        onPressed: () {
                          // setState(() {});
                          _selectedCategoryType = CategoryType.expense;
                          _categoryID = null;
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text('Expense'),
                      ),
                    ),
                    Radio(
                      value: CategoryType.expense,
                      groupValue: _selectedCategoryType,
                      onChanged: (newValue) {
                        // setState(() {});
                        _selectedCategoryType = CategoryType.expense;
                        _categoryID = null;
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .04,
                ),

                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ScreenCategory(),
                        ),
                      );
                    },
                    child: const Text('Add Category')),

                // Textformfield for category *******************************************   4

                DropdownButtonFormField<String>(
                  borderRadius: BorderRadius.circular(20),
                  value: _categoryID,
                  items: (_selectedCategoryType == CategoryType.income
                          ? Provider.of<CategoryProvider>(context,
                                  listen: false)
                              .incomeCategoryList
                          : Provider.of<CategoryProvider>(context,
                                  listen: false)
                              .expenseCategoryList)
                      .map((e) {
                    return DropdownMenuItem(
                      value: e.id,
                      child: Text(e.name),
                      onTap: () {
                        _selectedCategoryModel = e;
                      },
                    );
                  }).toList(),
                  onChanged: (selectedValue) {
                    // setState(() {});
                    _categoryID = selectedValue;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a category option';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: 'Select Category',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.height * .03,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .07,
                  width: MediaQuery.of(context).size.width * .9,
                  child: ElevatedButton(
                    onPressed: () {
                      addTransactionOnclicked();

                      _amountController.clear();

                      _discriptionController.clear();

                      _dateController.clear();

                      _categoryController.clear();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 4, 78, 207),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Submit',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 60)),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      // setState(() {});
      _selectedDate = picked;
      _dateController.text = DateFormat('dd-MMM-yyyy').format(_selectedDate!);
    }
  }

  Future<void> addTransactionOnclicked() async {
    final amountText = _amountController.text;
    final discriptionText = _discriptionController.text;

    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      final amount = _amountController.text;
      if (amount.isEmpty) {
        return;
      }
    }

    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      final discription = _discriptionController.text;
      if (discription.isEmpty) {
        return;
      }
    }

    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      final date = _dateController.text;
      if (date.isEmpty) {
        return;
      }
    }

    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();

      if (_selectedCategoryType == null) {
        return;
      }
    }

    final parsedAmount = double.tryParse(amountText);
    if (parsedAmount == null) {
      return;
    }

    if (_selectedCategoryModel == null ||
        _selectedCategoryType == null ||
        _selectedDate == null) {
      return;
    }

    final model = TransactionModel(
        amount: parsedAmount,
        discription: discriptionText,
        date: _selectedDate!,
        type: _selectedCategoryType!,
        category: _selectedCategoryModel!,
        id: DateTime.now().millisecondsSinceEpoch.toString());
    log(model.id.toString(), name: 'add transation id check');
    await Provider.of<TransactionProvider>(context, listen: false)
        .addTransaction(model);
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
    // ignore: use_build_context_synchronously
    Provider.of<TransactionProvider>(context, listen: false).refresh();
  }
}
