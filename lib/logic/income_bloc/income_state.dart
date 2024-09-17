import '../../data/models/income_model.dart';

abstract class IncomeCrudState {}

class IncomeCrudInitial extends IncomeCrudState {}

class IncomeCrudLoading extends IncomeCrudState {}

class IncomeCrudLoaded extends IncomeCrudState {
  final List<IncomeModel> incomes;
  IncomeCrudLoaded(this.incomes);
}

class IncomeCrudError extends IncomeCrudState {
  final String message;
  IncomeCrudError(this.message);
}
