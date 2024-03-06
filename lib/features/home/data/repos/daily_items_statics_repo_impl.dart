import 'package:dartz/dartz.dart';
import 'package:needs_delivery/core/errors/exceptions.dart';
import 'package:needs_delivery/core/errors/failure.dart';
import 'package:needs_delivery/core/utils/typedefs.dart';
import 'package:needs_delivery/features/home/data/data_sources/daily_items_statics_data_source.dart';
import 'package:needs_delivery/features/home/domain/entites/daily_items_statics_entity.dart';

import '../../domain/repos/daily_items_statics_repo.dart';

class DailyItemsStaticsRepoImpl implements DailyItemsStaticsRepo{


  final DailyItemsStaticsRemoteDataSource dailyItemsStaticsRemoteDataSource;
  const DailyItemsStaticsRepoImpl({required this.dailyItemsStaticsRemoteDataSource});

  @override
  ResultFuture<DailyItemsStaticsEntity> dailyItemsStatics
      ({required String date, required String token, required String lang}) async{
    try {
      final response = await dailyItemsStaticsRemoteDataSource.dailyItemsStatics(
          date: date,token: token,lang: lang);
      return Right(response);
    }on ApiException catch(e){
      return Left(ApiFailure.fromException(e));
    }
  }

}