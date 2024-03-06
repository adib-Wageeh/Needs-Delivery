import 'package:needs_delivery/core/usecase/usecase.dart';
import 'package:needs_delivery/core/utils/typedefs.dart';
import 'package:needs_delivery/features/home/domain/repos/order_status_repo.dart';

class ReturnedOrderUseCase extends FutureUseCaseWithParams<void,ReturnedOrderParams>{

  final OrderStatusRepo orderStatusRepo;
  const ReturnedOrderUseCase({required this.orderStatusRepo});
  
  @override
  ResultFuture<void> call(ReturnedOrderParams p) async{
    return orderStatusRepo.returnedOrder(invoiceId: p.invoiceId,
        amount: p.amount,orderId: p.orderId,token: p.token,lang: p.lang,
    units: p.units,reason: p.reason);
  }

}

class ReturnedOrderParams {

  final String lang;
  final String token;
  final String invoiceId;
  final String orderId;
  final String amount;
  final String units;
  final String reason;

  const ReturnedOrderParams({required this.invoiceId,required this.orderId,
  required this.amount,required this.lang,required this.token,
  required this.units,required this.reason});
}