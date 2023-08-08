import 'package:flutter/material.dart';
import 'package:money_management/provider/category_provider/category_provider.dart';
import 'package:money_management/screens/category/expense_category_list.dart';
import 'package:money_management/screens/category/income_category_list.dart';
import 'package:provider/provider.dart';

import 'category_add_popup.dart';

class ScreenCategory extends StatefulWidget {
  const ScreenCategory({super.key});

  @override
  State<ScreenCategory> createState() => _ScreenCategoryState();
}

class _ScreenCategoryState extends State<ScreenCategory>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);

    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CategoryProvider categoryProvider = Provider.of<CategoryProvider>(context);
    categoryProvider.refreshUI();
    return SafeArea(
      child: Card(
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MediaQuery.of(context).size.width *
                    0.930, // set width to 80% of screen width
                height: MediaQuery.of(context).size.height * 1, //
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.white,
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Card(
                      child: TabBar(
                        indicator: BoxDecoration(
                          color: const Color.fromARGB(255, 4, 78, 207),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        labelColor: Colors.white,
                        labelStyle: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                        unselectedLabelColor:
                            const Color.fromARGB(255, 4, 78, 207),
                        controller: _tabController,
                        tabs: const [
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
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: IncomeCategoryList(),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: ExpenseCategoryList(),
                          ),
                        ],
                      ),
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        showCategoryAddPopup(context);
                      },
                      child: Icon(Icons.add),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
