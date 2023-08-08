import 'package:flutter/material.dart';
import 'package:money_management/provider/category_provider/category_provider.dart';
import 'package:provider/provider.dart';

class ExpenseCategoryList extends StatelessWidget {
  const ExpenseCategoryList({super.key});
  // CategoryProvider categoryProvider = CategoryProvider();  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(
      builder: (context, newList, child) => ListView.separated(
        itemBuilder: (ctx, index) {
          final category = newList.expenseCategoryList[index];
          return Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            elevation: 30,
            child: ListTile(
              title: Text(category.name),
              trailing: Wrap(
                spacing: 2, // space between two icons
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      showDeleteDialog(context, category.id);
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ), // icon-2
                ],
              ),
            ),
          );
        },
        separatorBuilder: (ctx, index) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * .015,
          );
        },
        itemCount: newList.expenseCategoryList.length,
      ),
    );
  }

  void showDeleteDialog(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete category'),
          content: const Text('Are you sure you want to delete this category?'),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('DELETE'),
              onPressed: () {
                Provider.of<CategoryProvider>(context, listen: false)
                    .deleteCategory(id);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
