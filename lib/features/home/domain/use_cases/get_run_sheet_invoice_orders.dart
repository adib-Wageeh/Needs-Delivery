import 'package:needs_delivery/core/usecase/usecase.dart';
import 'package:needs_delivery/core/utils/typedefs.dart';
import 'package:needs_delivery/features/home/domain/entites/order_entity.dart';
import 'package:needs_delivery/features/home/domain/repos/runsheet_repo.dart';

class GetRunSheetInvoiceOrdersUseCase extends FutureUseCaseWithParams<List<OrderEntity>,GetRunSheetInvoiceOrdersParams>{

  final RunSheetRepo runSheetRepo;
  const GetRunSheetInvoiceOrdersUseCase({required this.runSheetRepo});
  
  @override
  ResultFuture<List<OrderEntity>> call(GetRunSheetInvoiceOrdersParams p) async{
    return runSheetRepo.getRunSheetInvoiceOrders(invoiceId: p.invoiceId,token: p.token,lang: p.lang);
  }

}

class GetRunSheetInvoiceOrdersParams {

  final String lang;
  final String token;
  final String invoiceId;

  const GetRunSheetInvoiceOrdersParams({required this.invoiceId,required this.lang,required this.token});
}