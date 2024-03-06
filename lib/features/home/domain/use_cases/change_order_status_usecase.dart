import 'package:needs_delivery/core/usecase/usecase.dart';
import 'package:needs_delivery/core/utils/typedefs.dart';
import 'package:needs_delivery/features/home/domain/repos/order_status_repo.dart';

class ChangeOrderStatusUseCase extends FutureUseCaseWithParams<void,ChangeOrderStatusParams>{

  final OrderStatusRepo orderStatusRepo;
  const ChangeOrderStatusUseCase({required this.orderStatusRepo});
  
  @override
  ResultFuture<void> call(ChangeOrderStatusParams p) async{
    return orderStatusRepo.changeOrderStatus(invoiceId: p.invoiceId,
        status: p.status,token: p.token,lang: p.lang);
  }

}

class ChangeOrderStatusParams {

  final String lang;
  final String token;
  final String invoiceId;
  final String status;

  const ChangeOrderStatusParams({required this.invoiceId,
  required this.status,required this.lang,required this.token});
}