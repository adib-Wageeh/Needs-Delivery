part of 'run_sheet_cubit.dart';

abstract class RunSheetState extends Equatable {
  const RunSheetState();
  @override
  List<Object> get props => [];
}

class RunSheetInitial extends RunSheetState {

}

class RunSheetLoading extends RunSheetState {

}

class RunSheetsLoaded extends RunSheetState {
  final List<RunSheetEntity> runSheets;
  const RunSheetsLoaded({required this.runSheets});
}

class RunSheetsError extends RunSheetState {
  final Failure error;
  const RunSheetsError({required this.error});
}