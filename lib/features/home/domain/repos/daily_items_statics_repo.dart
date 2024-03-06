
import 'package:needs_delivery/core/utils/typedefs.dart';
import 'package:needs_delivery/features/home/domain/entites/daily_items_statics_entity.dart';

abstract class DailyItemsStaticsRepo{

  ResultFuture<DailyItemsStaticsEntity> dailyItemsStatics({required String date
    ,required String token,required String lang});

}