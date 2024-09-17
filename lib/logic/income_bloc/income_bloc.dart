import 'package:exam_6/logic/income_bloc/income_event.dart';
import 'package:exam_6/logic/income_bloc/income_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:exam_6/data/services/income_local_service.dart';





class IncomeCrudBloc extends Bloc<IncomeCrudEvent, IncomeCrudState> {
  final IncomeLocalService _incomeLocalService;

  IncomeCrudBloc(this._incomeLocalService) : super(IncomeCrudInitial()) {
    on<LoadIncomes>(_onLoadIncomes);
    on<AddIncome>(_onAddIncome);
    on<UpdateIncome>(_onUpdateIncome);
    on<DeleteIncome>(_onDeleteIncome);
  }

  Future<void> _onLoadIncomes(
      LoadIncomes event, Emitter<IncomeCrudState> emit) async {
    emit(IncomeCrudLoading());
    try {
      final incomes = await _incomeLocalService.getAllIncomes();
      emit(IncomeCrudLoaded(incomes));
    } catch (e) {
      emit(IncomeCrudError("Failed to load incomes: ${e.toString()}"));
    }
  }

  Future<void> _onAddIncome(
      AddIncome event, Emitter<IncomeCrudState> emit) async {
    emit(IncomeCrudLoading());
    try {
      await _incomeLocalService.insertIncome(event.income);
      final incomes = await _incomeLocalService.getAllIncomes();
      emit(IncomeCrudLoaded(incomes));
    } catch (e) {
      emit(IncomeCrudError("Failed to add income: ${e.toString()}"));
    }
  }

  Future<void> _onUpdateIncome(
      UpdateIncome event, Emitter<IncomeCrudState> emit) async {
    emit(IncomeCrudLoading());
    try {
      await _incomeLocalService.updateIncome(event.income);
      final incomes = await _incomeLocalService.getAllIncomes();
      emit(IncomeCrudLoaded(incomes));
    } catch (e) {
      emit(IncomeCrudError("Failed to update income: ${e.toString()}"));
    }
  }

  Future<void> _onDeleteIncome(
      DeleteIncome event, Emitter<IncomeCrudState> emit) async {
    emit(IncomeCrudLoading());
    try {
      await _incomeLocalService.deleteIncome(event.id);
      final incomes = await _incomeLocalService.getAllIncomes();
      emit(IncomeCrudLoaded(incomes));
    } catch (e) {
      emit(IncomeCrudError("Failed to delete income: ${e.toString()}"));
    }
  }
}