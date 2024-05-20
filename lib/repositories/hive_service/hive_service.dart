// import 'package:expense/repositories/expense_model/expense_model.dart';
// import 'package:hive/hive.dart';

// class HiveService {

//   static void addExpense(ExpenseModel model) {
//     Hive.box('expenses').add(model);
//   }

//   static List<ExpenseModel> getAllExpenses() {
//     final result = Hive.box<ExpenseModel>('expenses').values.toList();

//     return result;
//   }
// }

import 'package:expense/repositories/expense_model/expense_model.dart';
import 'package:expense/repositories/hive_service/icon_adapter.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class HiveService {
  static Future<void> initHive() async {
    final applicationDocumentDir =
        await path_provider.getApplicationDocumentsDirectory();

    Hive
      ..init(applicationDocumentDir.path)
      ..registerAdapter(ExpenseModelAdapter())
      ..registerAdapter(IconDataAdapter());

    await Hive.openBox<ExpenseModel>('expenses');
  }

  static void addExpense(ExpenseModel model) {
    final box = Hive.box<ExpenseModel>('expenses');
    box.add(model);
  }

  static List<ExpenseModel> getAllExpenses() {
    final box = Hive.box<ExpenseModel>('expenses');
    final result = box.values.toList();
    return result;
  }

  // static void deleteExpense(ExpenseModel model) {
  //   final box = Hive.box<ExpenseModel>('expenses');
  //   box.delete(model);
  // }

  static void deleteExpense(ExpenseModel model) {
    final box = Hive.box<ExpenseModel>('expenses');
    final index = box.values.toList().indexWhere((item) => item == model);
    if (index != -1) {
      box.deleteAt(index);
    }
  }
}
