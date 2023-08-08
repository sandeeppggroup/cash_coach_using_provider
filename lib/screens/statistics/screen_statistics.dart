import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:money_management/db_functions/transactions/transaction_db.dart';
import 'package:money_management/graph/graph_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../Account/balance.dart';
import '../../chart_function/chart_function.dart';

// ignore: camel_case_types
class Statistics_Screen extends StatefulWidget {
  const Statistics_Screen({Key? key}) : super(key: key);

  @override
  State<Statistics_Screen> createState() => _Statistics_ScreenState();
}

// ignore: camel_case_types
class _Statistics_ScreenState extends State<Statistics_Screen>
    with TickerProviderStateMixin {
  List<ChartDatas> dataExpense = chartLogic(expenseNotifier1.value);
  List<ChartDatas> dataIncome = chartLogic(incomeNotifier1.value);
  List<ChartDatas> overview = chartLogic(overviewNotifier.value);
  List<ChartDatas> yesterday = chartLogic(yesterdayNotifier.value);
  List<ChartDatas> today = chartLogic(todayNotifier.value);
  List<ChartDatas> month = chartLogic(lastMonthNotifier.value);
  List<ChartDatas> week = chartLogic(lastWeekNotifier.value);
  List<ChartDatas> todayIncome = chartLogic(incomeTodayNotifier.value);
  List<ChartDatas> incomeYesterday = chartLogic(incomeYesterdayNotifier.value);
  List<ChartDatas> incomeweek = chartLogic(incomeLastWeekNotifier.value);
  List<ChartDatas> incomemonth = chartLogic(incomeLastMonthNotifier.value);
  List<ChartDatas> todayExpense = chartLogic(expenseTodayNotifier.value);
  List<ChartDatas> expenseYesterday =
      chartLogic(expenseYesterdayNotifier.value);
  List<ChartDatas> expenseweek = chartLogic(expenseLastWeekNotifier.value);
  List<ChartDatas> expensemonth = chartLogic(expenseLastMonthNotifier.value);
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    filterFunction();
    chartdivertFunctionExpense();
    chartdivertFunctionIncome();

    super.initState();
  }

  String categoryId2 = 'All';
  int touchIndex = 1;

  @override
  Widget build(BuildContext context) {
    TransactionDB.instance.refresh();

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 3, 20, 114),
        title: const Text(
          'Statistics',
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
        valueListenable: expenseNotifier,
        builder: (context, value, Widget? _) => Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 16,
              ),
              child: Material(
                shadowColor: Colors.grey,
                borderRadius: BorderRadius.circular(18),
                elevation: 10,
                child: Container(
                  height: height * 0.0657,
                  width: width * 0.83,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 4, 78, 207),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 15,
                          offset: Offset(5, 5),
                        ),
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 15,
                          offset: Offset(-5, -5),
                        ),
                      ]),
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: MediaQuery.of(context).size.height * 0.03,
                      left: MediaQuery.of(context).size.height * 0.03,
                    ),
                    child: DropdownButton<String>(
                      dropdownColor: Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                      isExpanded: true,
                      underline: const Divider(
                        color: Colors.transparent,
                      ),
                      value: categoryId2,
                      items: <String>[
                        'All',
                        'Today',
                        'Yesterday',
                        'This week',
                        'month',
                      ]
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          categoryId2 = value.toString();
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: TabBar(
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
                        color: Colors.grey,
                        blurRadius: 15,
                        offset: Offset(-5, -5),
                      ),
                    ]),
                controller: tabController,
                labelColor: Colors.white,
                labelStyle:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
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
              width: double.maxFinite,
              height: MediaQuery.of(context).size.height * 0.55,
              child: TabBarView(
                controller: tabController,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(
                      16,
                    ),
                    child: chartdivertFunctionOverview().isEmpty
                        ? Center(
                            child: Column(
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.4,
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: Center(
                                    child: Lottie.asset(
                                      'images/empty.json',
                                    ),
                                  ),
                                ),
                                const Text(
                                  'Data is empty',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          )
                        : SfCircularChart(
                            legend: Legend(
                              isVisible: true,
                              overflowMode: LegendItemOverflowMode.wrap,
                              position: LegendPosition.bottom,
                            ),
                            series: <CircularSeries>[
                              PieSeries<ChartDatas, String>(
                                dataLabelSettings: const DataLabelSettings(
                                  color: Colors.green,
                                  isVisible: true,
                                  connectorLineSettings: ConnectorLineSettings(
                                      type: ConnectorType.curve),
                                  overflowMode: OverflowMode.shift,
                                  showZeroValue: false,
                                  labelPosition: ChartDataLabelPosition.outside,
                                ),
                                dataSource: chartdivertFunctionOverview(),
                                xValueMapper: (ChartDatas data, _) =>
                                    data.category,
                                yValueMapper: (ChartDatas data, _) =>
                                    data.amount,
                                explode: true,
                              )
                            ],
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(
                      16,
                    ),
                    child: chartdivertFunctionIncome().isEmpty
                        ? Center(
                            child: Column(
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.4,
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: Center(
                                    child: Lottie.asset(
                                      'images/empty.json',
                                    ),
                                  ),
                                ),
                                const Text(
                                  'Data is empty',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          )
                        : SfCircularChart(
                            legend: Legend(
                              isVisible: true,
                              overflowMode: LegendItemOverflowMode.wrap,
                              position: LegendPosition.bottom,
                            ),
                            series: <CircularSeries>[
                              PieSeries<ChartDatas, String>(
                                dataLabelSettings: const DataLabelSettings(
                                  isVisible: true,
                                  connectorLineSettings: ConnectorLineSettings(
                                      type: ConnectorType.curve),
                                  overflowMode: OverflowMode.shift,
                                  showZeroValue: false,
                                  labelPosition: ChartDataLabelPosition.outside,
                                ),
                                dataSource: chartdivertFunctionIncome(),
                                xValueMapper: (ChartDatas data, _) =>
                                    data.category,
                                yValueMapper: (ChartDatas data, _) =>
                                    data.amount,
                                explode: true,
                              )
                            ],
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(
                      16,
                    ),
                    child: chartdivertFunctionExpense().isEmpty
                        ? Center(
                            child: Column(
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.4,
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: Center(
                                    child: Lottie.asset(
                                      'images/empty.json',
                                    ),
                                  ),
                                ),
                                const Text(
                                  'Data is empty',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          )
                        : SfCircularChart(
                            legend: Legend(
                              isVisible: true,
                              overflowMode: LegendItemOverflowMode.wrap,
                              position: LegendPosition.bottom,
                            ),
                            series: <CircularSeries>[
                              PieSeries<ChartDatas, String>(
                                dataLabelSettings: const DataLabelSettings(
                                  isVisible: true,
                                  connectorLineSettings: ConnectorLineSettings(
                                      type: ConnectorType.curve),
                                  overflowMode: OverflowMode.shift,
                                  showZeroValue: false,
                                  labelPosition: ChartDataLabelPosition.outside,
                                ),
                                dataSource: chartdivertFunctionExpense(),
                                xValueMapper: (ChartDatas data, _) =>
                                    data.category,
                                yValueMapper: (ChartDatas data, _) =>
                                    data.amount,
                                explode: true,
                              )
                            ],
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  chartdivertFunctionOverview() {
    if (categoryId2 == 'All') {
      return overview;
    }
    if (categoryId2 == 'Today') {
      return today;
    }
    if (categoryId2 == 'Yesterday') {
      return yesterday;
    }
    if (categoryId2 == 'This week') {
      return week;
    }
    if (categoryId2 == 'month') {
      return month;
    }
  }

  chartdivertFunctionIncome() {
    if (categoryId2 == 'All') {
      return dataIncome;
    }
    if (categoryId2 == 'Today') {
      return todayIncome;
    }
    if (categoryId2 == 'Yesterday') {
      return incomeYesterday;
    }
    if (categoryId2 == 'This week') {
      return incomeweek;
    }
    if (categoryId2 == 'month') {
      return incomemonth;
    }
  }

  chartdivertFunctionExpense() {
    if (categoryId2 == 'All') {
      return dataExpense;
    }
    if (categoryId2 == 'Today') {
      return todayExpense;
    }
    if (categoryId2 == 'Yesterday') {
      return expenseYesterday;
    }
    if (categoryId2 == 'This week') {
      return expenseweek;
    }
    if (categoryId2 == 'month') {
      return expensemonth;
    }
  }
}
