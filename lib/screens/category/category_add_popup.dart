// ignore_for_file: invalid_use_of_visible_for_testing_member
import 'package:flutter/material.dart';
import 'package:money_management/models/category/category_model.dart';
import 'package:money_management/provider/category_provider/category_provider.dart';
import 'package:provider/provider.dart';

ValueNotifier<CategoryType> selectedCategoryNotifier =
    ValueNotifier(CategoryType.income);

Future<void> showCategoryAddPopup(BuildContext context) async {
  final nameEditingController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  showDialog(
    context: context,
    builder: (ctx) {
      return Consumer<CategoryProvider>(
        builder: (context, categoryProvider, _) => Form(
          key: formKey,
          child: SimpleDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            backgroundColor: Colors.white,
            elevation: 100,
            title: const Center(child: Text('Add Category')),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.multiline,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter category name';
                    }
                    return null;
                  },
                  controller: nameEditingController,
                  decoration: InputDecoration(
                    hintText: 'Category Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(right: 40, left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RadioButton(title: 'Income', type: CategoryType.income),
                    RadioButton(title: 'Expense', type: CategoryType.expense),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState?.save();
                      final categoryName = nameEditingController.text;

                      final check =
                          selectedCategoryNotifier.value == CategoryType.income
                              ? categoryProvider.incomeCategoryList
                                  .where((element) {
                                  return element.name.contains(categoryName);
                                })
                              : categoryProvider.expenseCategoryList
                                  .where((element) {
                                  return element.name.contains(categoryName);
                                });

                      if (check.isNotEmpty) {
                        return;
                      }
                      if (categoryName.isEmpty) {
                        return;
                      }
                      final type = selectedCategoryNotifier.value;
                      final category = CategoryModel(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        name: categoryName,
                        type: type,
                      );
                      categoryProvider.insertCategory(category);
                      Navigator.of(ctx).pop();
                    }
                  },
                  child: const Text('Add'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: const Text('Close'),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;
  const RadioButton({super.key, required this.title, required this.type});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
          valueListenable: selectedCategoryNotifier,
          builder: (BuildContext ctx, CategoryType newCategory, Widget? _) {
            return Radio<CategoryType>(
              value: type,
              groupValue: newCategory,
              onChanged: (value) {
                if (value == null) {
                  return;
                }
                selectedCategoryNotifier.value = value;
                // ignore: invalid_use_of_protected_member
                selectedCategoryNotifier.notifyListeners();
              },
            );
          },
        ),
        Text(title),
      ],
    );
  }
}
