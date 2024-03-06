import 'package:needs_delivery/core/usecase/usecase.dart';
import 'package:needs_delivery/core/utils/typedefs.dart';
import 'package:needs_delivery/features/home/domain/entites/run_sheet_entity.dart';
import 'package:needs_delivery/features/home/domain/repos/runsheet_repo.dart';

class GetAllRunSheetsUseCase extends FutureUseCaseWithParams<List<RunSheetEntity>
  ,GetAllRunSheetsParams>{

  final RunSheetRepo runSheetRepo;
  const GetAllRunSheetsUseCase({required this.runSheetRepo});
  
  @override
  ResultFuture<List<RunSheetEntity>> call(GetAllRunSheetsParams p) async{
    return runSheetRepo.getAllRunSheets(token: p.token,lang: p.lang);
  }

}

class GetAllRunSheetsParams {

  final String lang;
  final String token;

  const GetAllRunSheetsParams({required this.lang,required this.token});
}