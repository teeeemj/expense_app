part of 'expense_tracker_bloc.dart';

@immutable
sealed class ExpenseTrackerEvent {}

class GetAllExpenses extends ExpenseTrackerEvent {
  final List<ExpenseModel> expenses;

  GetAllExpenses({required this.expenses});
}

class AddExpense extends ExpenseTrackerEvent {
  final ExpenseModel expense;

  AddExpense({required this.expense});
}

class DeleteExpense extends ExpenseTrackerEvent {
  final ExpenseModel expense;

  DeleteExpense({required this.expense});
}
