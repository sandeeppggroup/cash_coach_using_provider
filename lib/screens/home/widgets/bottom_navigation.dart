import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:money_management/screens/home/screen_main.dart';

class MoneyManagerBottomNavigation extends StatelessWidget {
  const MoneyManagerBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ScreenMain.selectedIndexNotifier,
      builder: (BuildContext ctx, int updatedIndex, Widget? _) {
        return BottomNavigationBar(
          selectedIconTheme: const IconThemeData(size: 40),
          selectedItemColor: Colors.indigo,
          unselectedItemColor: Colors.grey,
          currentIndex: updatedIndex,
          onTap: (newIndex) {
            ScreenMain.selectedIndexNotifier.value = newIndex;
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(IconlyBold.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(IconlyBold.category), label: 'Category'),
            BottomNavigationBarItem(
                icon: Icon(IconlyBold.paper), label: 'Transactions'),
            BottomNavigationBarItem(
                icon: Icon(IconlyBold.graph), label: 'Statistics'),
          ],
        );
      },
    );
  }
}
