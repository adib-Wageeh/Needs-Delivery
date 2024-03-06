import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:needs_delivery/core/errors/failure.dart';
import 'package:needs_delivery/features/home/domain/use_cases/change_order_status_usecase.dart';

part 'change_status_state.dart';

class ChangeStatusCubit extends Cubit<ChangeStatusState> {
  ChangeStatusCubit({
    required ChangeOrderStatusUseCase changeOrderStatusUseCase,
}) :
  _changeOrderStatusUseCase = changeOrderStatusUseCase
  ,super(ChangeStatusInitial());

  final ChangeOrderStatusUseCase _changeOrderStatusUseCase;

  void changeOrderStatus({required String token,required String lang,required String status,
  required String invoiceId})async{
    emit(ChangeStatusLoading());
    final result = await _changeOrderStatusUseCase.call(ChangeOrderStatusParams(
        token: token,
        status: status,
        invoiceId: invoiceId,
        lang: lang));
    result.fold((l) {
      emit(ChangeStatusError(error: l));
    }, (token) async {
      emit(const ChangeStatusDone());
    });
  }


}
