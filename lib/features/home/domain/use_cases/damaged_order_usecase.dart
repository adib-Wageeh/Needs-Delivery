import 'package:needs_delivery/core/usecase/usecase.dart';
import 'package:needs_delivery/core/utils/typedefs.dart';
import 'package:needs_delivery/features/home/domain/repos/order_status_repo.dart';

class DamagedOrderUseCase extends FutureUseCaseWithParams<void,DamagedOrderParams>{

  final OrderStatusRepo orderStatusRepo;
  const DamagedOrderUseCase({required this.orderStatusRepo});
  
  @override
  ResultFuture<void> call(DamagedOrderParams p) async{
    return orderStatusRepo.damagedOrder(invoiceId: p.invoiceId,
        amount: p.amount,orderId: p.orderId,token: p.token,lang: p.lang,
    reason: p.reason,units: p.units);
  }

}

class DamagedOrderParams {

  final String lang;
  final String token;
  final String invoiceId;
  final String orderId;
  final String amount;
  final String units;
  final String reason;

  const DamagedOrderParams({required this.invoiceId,required this.orderId,
  required this.amount,required this.lang,required this.token,
  required this.units,required this.reason});
}