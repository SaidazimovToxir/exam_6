import '../../data/models/income_model.dart';

abstract class IncomeCrudEvent {}

class LoadIncomes extends IncomeCrudEvent {}

class AddIncome extends IncomeCrudEvent {
  final IncomeModel income;
  AddIncome(this.income);
}

class UpdateIncome extends IncomeCrudEvent {
  final IncomeModel income;
  UpdateIncome(this.income);
}

class DeleteIncome extends IncomeCrudEvent {
  final String id;
  DeleteIncome(this.id);
}
