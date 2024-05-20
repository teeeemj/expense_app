part of 'expense_tracker_bloc.dart';

@immutable
sealed class ExpenseTrackerState {}

final class ExpenseTrackerInitial extends ExpenseTrackerState {}

final class ExpenseTrackerLoading extends ExpenseTrackerState {}

final class ExpenseTrackerSuccess extends ExpenseTrackerState {
  final List<ExpenseModel> expenses;
  final double totalAmount;

  ExpenseTrackerSuccess({this.expenses = const [], this.totalAmount = 0.0});
}

final class ExpenseTrackerError extends ExpenseTrackerState {
  final String errorText;

  ExpenseTrackerError({required this.errorText});
}
