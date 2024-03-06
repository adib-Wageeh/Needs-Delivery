import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:needs_delivery/core/errors/failure.dart';
import 'package:needs_delivery/features/home/domain/entites/order_entity.dart';
import 'package:needs_delivery/features/home/domain/use_cases/get_run_sheet_invoice_orders.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit({
    required GetRunSheetInvoiceOrdersUseCase getRunSheetInvoiceOrdersUseCase
}) :
  _getRunSheetInvoiceOrdersUseCase = getRunSheetInvoiceOrdersUseCase
  ,super(OrdersInitial());

  final GetRunSheetInvoiceOrdersUseCase _getRunSheetInvoiceOrdersUseCase;

  void getInvoiceOrders({required String token,required String lang,required String invoiceId})async{
    emit(OrdersLoading());
    final result = await _getRunSheetInvoiceOrdersUseCase.call(GetRunSheetInvoiceOrdersParams(
        token: token,
        invoiceId: invoiceId,
        lang: lang));
    result.fold((l) {
      emit(OrdersError(error: l));
    }, (orders) async {
      emit(OrdersLoaded(orders: orders));
    });
  }


}
