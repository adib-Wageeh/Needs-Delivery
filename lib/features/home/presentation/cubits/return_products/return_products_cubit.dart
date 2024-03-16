import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:needs_delivery/core/enums/exception_types.dart';
import 'package:needs_delivery/core/errors/failure.dart';
import 'package:needs_delivery/features/home/domain/entites/order_entity.dart';
import 'package:needs_delivery/features/home/domain/use_cases/returned_order_usecase.dart';

part 'return_products_state.dart';

class ReturnProductsCubit extends Cubit<ReturnProductsState> {
  ReturnProductsCubit({
    required ReturnedOrderUseCase returnedOrderUseCase
}) :
  _returnedOrderUseCase = returnedOrderUseCase
  ,super(ReturnProductsInitial());

  final ReturnedOrderUseCase _returnedOrderUseCase;

  void returnOrder({required String token,required String lang
    ,required List<OrderEntity> orders,
    required String invoiceId,required String reason
    ,required List<TextEditingController> amounts
    ,required List<TextEditingController> units})async{
    emit(ReturnProductsLoading());
    bool flag = false;
    bool error = false;

    for(OrderEntity order in orders) {
      int currentIndex = orders.indexOf(order);
      if(amounts[currentIndex].text.trim() != '0' ||
          units[currentIndex].text.trim() != '0') {
        flag = true;
        final result = await _returnedOrderUseCase.call(ReturnedOrderParams(
            token: token,
            amount: amounts[currentIndex].text.trim(),
            orderId: order.id.toString(),
            invoiceId: invoiceId,
            reason: reason,
            units: units[currentIndex].text.trim(),
            lang: lang));
        result.fold((l) {
          error = true;
          emit(ReturnProductsError(error: l));
        }, (_) => null);
      }
    }
    if(flag == false)
      {
      emit(const ReturnProductsError(error: ApiFailure(type: ExceptionType.noReturnProducts)));
      }else {
      if(error != true) {
        emit(ReturnProductsDone());
      }
    }
  }

}
