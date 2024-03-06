import 'package:needs_delivery/core/errors/exceptions.dart';
import 'package:needs_delivery/core/services/web_services.dart';
import 'package:needs_delivery/core/utils/typedefs.dart';
import 'package:needs_delivery/features/home/data/models/daily_items_statics_model.dart';

abstract class DailyItemsStaticsRemoteDataSource{

  Future<DailyItemsStaticsModel> dailyItemsStatics({required String date,
    required String token,required String lang});
}

class DailyItemsStaticsRemoteDataSourceImpl implements DailyItemsStaticsRemoteDataSource {

  final WebServices webServices;

  DailyItemsStaticsRemoteDataSourceImpl(this.webServices);

  @override
  Future<DailyItemsStaticsModel> dailyItemsStatics
      ({required String date, required String token, required String lang}) async{
    try{
      final response = await webServices.invoicesStatics(
          map: {
            'date': date,
          }
          ,lang: lang,token: token);
      return DailyItemsStaticsModel.fromJson( (response as DataMap)['data'] );
    }on ApiException{
      rethrow;
    } catch(e){
      throw(ApiException.getDioException(e));
    }
  }


}