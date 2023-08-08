import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 4, 78, 207),
        centerTitle: true,
        title: const Text('About'),
      ),
      body: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.height * .015),
        child: SingleChildScrollView(
          child: Text(
            textAlign: TextAlign.justify,
            "Welcome to Cash Coach, your personal financial advisor and budgeting tool. Our mission is to help you take control of your finances and achieve your financial goals.Whether you're trying to save up for a big purchase, pay off debt, or just want to be more mindful about your spending, Cash Coach can help. With our user-friendly interface and personalized guidance, you can track your expenses, set budgets, and make smarter financial decisions.Here are just a few of the features that make Cash Coach unique:Customized Budgets: Cash Coach will help you create a personalized budget based on your income, expenses, and financial goals. You can adjust your budget as needed and track your progress over time. Expense Tracking: Keep track of your daily expenses, categorize them, and see where your money is going. Cash Coach will provide insights on your spending habits and offer tips to help you reduce unnecessary expenses.Savings Goals: Set savings goals and track your progress. Whether you're saving up for a vacation or building an emergency fund, Cash Coach will help you stay on track. Financial Insights: Cash Coach provides personalized insights and recommendations based on your financial data. You'll receive tips on how to save money, pay off debt, and improve your credit score. At Cash Coach, we're committed to protecting your privacy and security. We do not sell your data to third parties and we use encryption to keep your information safe. So why wait? Download Cash Coach today and start taking control of your finances!.",
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * .02,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
