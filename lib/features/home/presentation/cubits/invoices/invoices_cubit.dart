import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:needs_delivery/core/errors/failure.dart';
import 'package:needs_delivery/features/home/domain/entites/run_sheet_item_entity.dart';
import 'package:needs_delivery/features/home/domain/use_cases/get_run_sheet_invoices.dart';

part 'invoices_state.dart';

class InvoicesCubit extends Cubit<InvoicesState> {
  InvoicesCubit({
    required GetRunSheetInvoicesUseCase getRunSheetInvoicesUseCase
}) :
  _getRunSheetInvoicesUseCase = getRunSheetInvoicesUseCase
  ,super(InvoicesInitial());

  final GetRunSheetInvoicesUseCase _getRunSheetInvoicesUseCase;

  void getRunSheetInvoices({required String token,required String lang,required String runSheetId})async{
    emit(InvoicesLoading());
    final result = await _getRunSheetInvoicesUseCase.call(GetRunSheetInvoicesParams(
        token: token,
        runSheetId: runSheetId,
        lang: lang));
    result.fold((l) {
      emit(InvoicesError(error: l));
    }, (items) async {
      emit(InvoicesLoaded(runSheetItemEntity: items));
    });
  }


}
