import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'expense_model.g.dart';

@HiveType(typeId: 0)
class ExpenseModel {
  ExpenseModel({
    required this.icon,
    required this.amount,
    required this.category,
  });

  @HiveField(0)
  IconData icon;

  @HiveField(1)
  double amount;

  @HiveField(2)
  String category;
}
