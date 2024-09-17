import 'package:exam_6/data/services/income_local_service.dart';
import 'package:exam_6/logic/income_bloc/income_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ui/home/screen/home_screen.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  final incomeLocalService = IncomeLocalService();
  await incomeLocalService.database;
  runApp(MyApp(incomeLocalService: incomeLocalService));
}

class MyApp extends StatelessWidget {
  final IncomeLocalService incomeLocalService;

  const MyApp({super.key, required this.incomeLocalService});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => IncomeCrudBloc(incomeLocalService),
      child: const MaterialApp(
        home: HomeScreen(),
      ),
    );
  }
}
