import 'package:bloc/bloc.dart';
import 'package:expense/repositories/expense_model/expense_model.dart';
import 'package:expense/repositories/hive_service/hive_service.dart';
import 'package:meta/meta.dart';

part 'expense_tracker_event.dart';
part 'expense_tracker_state.dart';

class ExpenseTrackerBloc
    extends Bloc<ExpenseTrackerEvent, ExpenseTrackerState> {
  ExpenseTrackerBloc() : super(ExpenseTrackerInitial()) {
    on<GetAllExpenses>(_getAllExpenses);
    on<AddExpense>(_addExpense);
    on<DeleteExpense>(_deleteExpense);
  }

  void _getAllExpenses(
      GetAllExpenses event, Emitter<ExpenseTrackerState> emit) {
    try {
      final expenses = HiveService.getAllExpenses();
      final totalAmount =
          expenses.fold(0.0, (sum, expense) => sum + expense.amount);
      emit(
        ExpenseTrackerSuccess(expenses: expenses, totalAmount: totalAmount),
      );
    } catch (e) {
      emit(ExpenseTrackerError(errorText: e.toString()));
    }
  }

  void _addExpense(AddExpense event, Emitter<ExpenseTrackerState> emit) {
    HiveService.addExpense(event.expense);
    add(
      GetAllExpenses(
        expenses: HiveService.getAllExpenses(),
      ),
    );
  }

  void _deleteExpense(DeleteExpense event, Emitter<ExpenseTrackerState> emit) {
    HiveService.deleteExpense(event.expense);
    add(
      GetAllExpenses(
        expenses: HiveService.getAllExpenses(),
      ),
    );
  }
}
