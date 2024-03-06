part of 'invoices_cubit.dart';

@immutable
abstract class InvoicesState {
  const InvoicesState();
}

class InvoicesInitial extends InvoicesState {}

class InvoicesLoading extends InvoicesState {

}

class InvoicesLoaded extends InvoicesState {
  final List<RunSheetItemEntity> runSheetItemEntity;
  const InvoicesLoaded({required this.runSheetItemEntity});
}

class InvoicesError extends InvoicesState {
  final Failure error;
  const InvoicesError({required this.error});
}