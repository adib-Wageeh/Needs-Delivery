import 'package:needs_delivery/core/usecase/usecase.dart';
import 'package:needs_delivery/core/utils/typedefs.dart';
import 'package:needs_delivery/features/home/domain/entites/run_sheet_entity.dart';
import 'package:needs_delivery/features/home/domain/repos/runsheet_repo.dart';

class GetRunSheetsByDateUseCase extends FutureUseCaseWithParams<
    List<RunSheetEntity>,GetRunSheetsByDateParams>{

  final RunSheetRepo runSheetRepo;
  const GetRunSheetsByDateUseCase({required this.runSheetRepo});
  
  @override
  ResultFuture<List<RunSheetEntity>> call(GetRunSheetsByDateParams p) async{
    return runSheetRepo.getRunSheetsByDate(date: p.date,token: p.token,lang: p.lang);
  }

}

class GetRunSheetsByDateParams {

  final String lang;
  final String token;
  final String date;

  const GetRunSheetsByDateParams({required this.date,required this.lang,required this.token});
}