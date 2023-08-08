import 'package:hive_flutter/adapters.dart';
import 'package:money_management/models/category/category_model.dart';
part 'transaction_model.g.dart';

@HiveType(typeId: 3)
class TransactionModel {
  @HiveField(0)
  final double amount;

  @HiveField(1)
  final String discription;

  @HiveField(2)
  final DateTime date;

  @HiveField(3)
  final CategoryType type;

  @HiveField(4)
  final CategoryModel category;

  @HiveField(5)
  String? id;

  TransactionModel(
      {required this.amount,
      required this.discription,
      required this.date,
      required this.type,
      required this.category,
      required this.id});
}
