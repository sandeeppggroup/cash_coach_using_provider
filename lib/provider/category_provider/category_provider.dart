import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import '../../models/category/category_model.dart';

const CATEGORY_DB_NAME = 'category_database';

class CategoryProvider with ChangeNotifier {
  List<CategoryModel> incomeCategoryList = [];
  List<CategoryModel> expenseCategoryList = [];

  @override
  Future<void> insertCategory(CategoryModel value) async {
    final categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await categoryDB.put(value.id, value);
    refreshUI();
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    final categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    return categoryDB.values.toList();
  }

  Future<void> refreshUI() async {
    final allCategories = await getCategories();
    incomeCategoryList.clear();
    expenseCategoryList.clear();
    notifyListeners();
    await Future.forEach(
      allCategories,
      (CategoryModel category) {
        if (category.type == CategoryType.income) {
          incomeCategoryList.add(category);
        } else {
          expenseCategoryList.add(category);
        }
      },
    );

    notifyListeners();
  }

  @override
  Future<void> deleteCategory(String categoryID) async {
    final categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await categoryDB.delete(categoryID);
    refreshUI();
  }

  @override
  Future<void> editCategory(CategoryModel updatedCategory) async {
    final categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await categoryDB.put(updatedCategory.id, updatedCategory);
    refreshUI();
  }
}
