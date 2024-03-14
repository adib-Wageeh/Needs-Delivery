import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:needs_delivery/core/enums/exception_types.dart';
import 'package:needs_delivery/core/errors/failure.dart';
import 'package:needs_delivery/features/home/domain/entites/order_entity.dart';
import 'package:needs_delivery/features/home/domain/use_cases/damaged_order_usecase.dart';

part 'damaged_products_state.dart';

class DamagedProductsCubit extends Cubit<DamagedProductsState> {
  DamagedProductsCubit({
    required DamagedOrderUseCase damagedOrderUseCase
}) :
        _damagedOrderUseCase = damagedOrderUseCase
  ,super(DamagedProductsInitial());

  final DamagedOrderUseCase _damagedOrderUseCase;

  void returnOrder({required String token,required String lang
    ,required List<OrderEntity> orders,
    required String invoiceId,required String reason
    ,required List<TextEditingController> amounts
    ,required List<TextEditingController> units})async{
    emit(DamagedProductsLoading());
    bool flag = false;

    for(OrderEntity order in orders) {
      int currentIndex = orders.indexOf(order);
      if(amounts[currentIndex].text.trim() != '0' ||
          units[currentIndex].text.trim() != '0') {
        flag = true;
        final result = await _damagedOrderUseCase.call(DamagedOrderParams(
            token: token,
            amount: amounts[currentIndex].text.trim(),
            orderId: order.id.toString(),
            invoiceId: invoiceId,
            reason: reason,
            units: units[currentIndex].text.trim(),
            lang: lang));
        result.fold((l) {
          emit(DamagedProductsError(error: l));
        }, (_) => null);
      }
    }
    if(flag == false)
      {
      emit(const DamagedProductsError(error: ApiFailure(type: ExceptionType.noReturnProducts)));
      }else {
      emit(DamagedProductsDone());
    }
  }

}
