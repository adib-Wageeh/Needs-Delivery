import 'package:needs_delivery/core/usecase/usecase.dart';
import 'package:needs_delivery/core/utils/typedefs.dart';
import 'package:needs_delivery/features/home/domain/entites/run_sheet_item_entity.dart';
import 'package:needs_delivery/features/home/domain/repos/runsheet_repo.dart';

class GetRunSheetInvoicesUseCase extends FutureUseCaseWithParams
<List<RunSheetItemEntity>,GetRunSheetInvoicesParams>{

  final RunSheetRepo runSheetRepo;
  const GetRunSheetInvoicesUseCase({required this.runSheetRepo});
  
  @override
  ResultFuture<List<RunSheetItemEntity>> call(GetRunSheetInvoicesParams p) async{
    return runSheetRepo.getRunSheetInvoices(runSheetId: p.runSheetId,token: p.token,lang: p.lang);
  }

}

class GetRunSheetInvoicesParams {

  final String lang;
  final String token;
  final String runSheetId;

  const GetRunSheetInvoicesParams({required this.runSheetId,required this.lang,required this.token});
}