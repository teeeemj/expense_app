import 'package:expense/blocs/bloc/expense_tracker_bloc.dart';
import 'package:expense/core/route/app_router.dart';
import 'package:expense/repositories/hive_service/hive_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveService.initHive();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => HiveService(),
      child: BlocProvider(
        create: (context) => ExpenseTrackerBloc(),
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: router,
        ),
      ),
    );
  }
}
