import 'package:needs_delivery/core/usecase/usecase.dart';
import 'package:needs_delivery/core/utils/typedefs.dart';
import 'package:needs_delivery/features/home/domain/entites/daily_items_statics_entity.dart';
import 'package:needs_delivery/features/home/domain/repos/daily_items_statics_repo.dart';

class DailyItemsStaticsUseCase extends FutureUseCaseWithParams<DailyItemsStaticsEntity,DailyItemsStaticsParams>{

  final DailyItemsStaticsRepo dailyItemsStaticsRepo;
  const DailyItemsStaticsUseCase({required this.dailyItemsStaticsRepo});
  
  @override
  ResultFuture<DailyItemsStaticsEntity> call(DailyItemsStaticsParams p) async{
    return dailyItemsStaticsRepo.dailyItemsStatics(date: p.date,
        token: p.token,lang: p.lang);
  }

}

class DailyItemsStaticsParams {

  final String lang;
  final String token;
  final String date;

  const DailyItemsStaticsParams({
  required this.date,required this.lang,required this.token});
}