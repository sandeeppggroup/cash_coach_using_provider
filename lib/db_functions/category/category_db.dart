// // ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

// import 'package:flutter/material.dart';
// import 'package:hive_flutter/adapters.dart';
// import 'package:money_management/models/category/category_model.dart';

// // ignore: constant_identifier_names
// const CATEGORY_DB_NAME = 'category_database';

// abstract class CategoryDbFunctions {
//   Future<List<CategoryModel>> getCategories();
//   Future<void> insertCategory(CategoryModel value);
//   Future<void> deleteCategory(String categoryID);
//   Future<void> editCategory(CategoryModel updatedCategory);
// }

// class CategoryDB implements CategoryDbFunctions {
//   CategoryDB._internal();
//   static CategoryDB instance = CategoryDB._internal();
//   factory CategoryDB() {
//     return CategoryDB.instance;
//   }

//   ValueNotifier<List<CategoryModel>> incomeCategoryListListener =
//       ValueNotifier([]);
//   ValueNotifier<List<CategoryModel>> expenseCategoryListListener =
//       ValueNotifier([]);

//   @override
//   Future<void> insertCategory(CategoryModel value) async {
//     final categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
//     await categoryDB.put(value.id, value);
//     refreshUI();
//   }

//   @override
//   Future<List<CategoryModel>> getCategories() async {
//     final categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
//     return categoryDB.values.toList();
//   }

//   Future<void> refreshUI() async {
//     final allCategories = await getCategories();
//     incomeCategoryListListener.value.clear();
//     expenseCategoryListListener.value.clear();
//     await Future.forEach(
//       allCategories,
//       (CategoryModel category) {
//         if (category.type == CategoryType.income) {
//           incomeCategoryListListener.value.add(category);
//         } else {
//           expenseCategoryListListener.value.add(category);
//         }
//       },
//     );

//     incomeCategoryListListener.notifyListeners();
//     expenseCategoryListListener.notifyListeners();
//   }

//   @override
//   Future<void> deleteCategory(String categoryID) async {
//     final categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
//     await categoryDB.delete(categoryID);
//     refreshUI();
//   }

//   @override
//   Future<void> editCategory(CategoryModel updatedCategory) async {
//     final categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
//     await categoryDB.put(updatedCategory.id, updatedCategory);
//     refreshUI();
//   }
// }
