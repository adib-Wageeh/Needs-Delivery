import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:needs_delivery/core/errors/failure.dart';
import 'package:needs_delivery/features/home/domain/use_cases/returned_order_usecase.dart';

part 'return_products_state.dart';

class ReturnProductsCubit extends Cubit<ReturnProductsState> {
  ReturnProductsCubit({
    required ReturnedOrderUseCase returnedOrderUseCase
}) :
  _returnedOrderUseCase = returnedOrderUseCase
  ,super(ReturnProductsInitial());

  final ReturnedOrderUseCase _returnedOrderUseCase;

  void changeOrderStatus({required String token,required String lang,required String orderId,
    required String invoiceId,required String reason,required int amount,required int unit})async{
    emit(ReturnProductsLoading());
    final result = await _returnedOrderUseCase.call(ReturnedOrderParams(
        token: token,
        amount: amount.toString(),
        orderId: orderId,
        invoiceId: invoiceId,
        reason: reason, 
        units: unit.toString(),
        lang: lang));
    result.fold((l) {
      emit(ReturnProductsError(error: l));
    }, (token) async {
      emit(ReturnProductsDone());
    });
  }

}
