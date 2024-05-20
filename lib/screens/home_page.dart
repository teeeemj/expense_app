import 'dart:developer';
import 'package:expense/blocs/bloc/expense_tracker_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<ExpenseTrackerBloc>(context)
        .add(GetAllExpenses(expenses: const []));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.dark_mode_outlined),
        ),
        title: const Text('E X P E N S E S'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 50),
          const Center(child: Text('Spent this month')),
          const SizedBox(height: 10),
          BlocBuilder<ExpenseTrackerBloc, ExpenseTrackerState>(
            builder: (context, state) {
              log(state.toString());

              if (state is ExpenseTrackerLoading) {
                return const CircularProgressIndicator();
              } else if (state is ExpenseTrackerSuccess) {
                log(state.expenses.toString());
                if (state.expenses.isEmpty) {
                  return const Text('No Expenses yet');
                } else {
                  return Text('\$${state.totalAmount.toStringAsFixed(2)}');
                }
              } else if (state is ExpenseTrackerError) {
                return Text('Error: ${state.errorText}');
              }

              return Container();
            },
          ),
          const SizedBox(height: 20),
          BlocBuilder<ExpenseTrackerBloc, ExpenseTrackerState>(
            builder: (context, state) {
              if (state is ExpenseTrackerSuccess) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: state.expenses.length,
                    itemBuilder: (context, index) {
                      final expense = state.expenses[index];
                      return Dismissible(
                        key: Key(expense.hashCode.toString()),
                        onDismissed: (direction) {
                          BlocProvider.of<ExpenseTrackerBloc>(context).add(
                            DeleteExpense(expense: expense),
                          );

                          // Удаление элемента из списка
                          state.expenses.removeAt(index);

                          // Обновление состояния виджета
                          setState(() {});
                        },
                        background: Container(color: Colors.red),
                        child: ListTile(
                          leading: Icon(Icons.abc),
                          title: Text('\$${expense.amount.toStringAsFixed(2)}'),
                          subtitle: Text(expense.category),
                        ),
                      );
                    },
                  ),
                );
              }
              return Container();
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Добавить код для добавления нового расхода
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
