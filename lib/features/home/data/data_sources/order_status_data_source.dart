import 'package:needs_delivery/core/enums/exception_types.dart';
import 'package:needs_delivery/core/errors/exceptions.dart';
import 'package:needs_delivery/core/services/web_services.dart';

abstract class OrderStatusRemoteDataSource{

  Future<void> changeOrderStatus({required String invoiceId,required String status
    ,required String token,required String lang});
  Future<void> damagedOrder({required String token,required String invoiceId
    ,required String orderId,required String lang,required String amount,
    required String units,required String reason});
  Future<void> returnedOrder({required String token,required String invoiceId,
    required String lang,required String amount,required String orderId,
    required String units,required String reason});

}

class OrderStatusRemoteDataSourceImpl implements OrderStatusRemoteDataSource{

  final WebServices webServices;
  OrderStatusRemoteDataSourceImpl(this.webServices);

  @override
  Future<void> changeOrderStatus({required String invoiceId,
    required String status, required String token, required String lang}) async{
    try{
      final response = await webServices.changeOrderStatus(
      map: {
        'runsheet_id': invoiceId,
        'status': status
      }
      ,lang: lang,token: token);
      if((response)['status'] == false){
        throw ApiException(type: ExceptionType.unExpected,message: response['message']);
      }
      return;
    }on ApiException{
      rethrow;
    } catch(e){
      throw(ApiException.getDioException(e));
    }
  }

  @override
  Future<void> damagedOrder({required String token, required String invoiceId,
    required String orderId, required String lang, required String amount,
    required String units,required String reason})async{
    try{
      final response = await webServices.damagedOrder(
          map: {
            'runsheet_item_id': invoiceId,
            'order_id': orderId,
            'amount': amount,
            'units': units,
            'reason': reason
          }
          ,lang: lang,token: token);
      if((response)['status'] == false){
        throw ApiException(type: ExceptionType.unExpected,message: response['message']);
      }
      return;
    }on ApiException{
      rethrow;
    } catch(e){
      throw(ApiException.getDioException(e));
    }
  }

  @override
  Future<void> returnedOrder({required String token, required String invoiceId,
    required String lang, required String amount, required String orderId,
    required String units,required String reason})async{
    try{
      final response = await webServices.returnedOrder(
          map: {
            'runsheet_item_id': invoiceId,
            'order_id': orderId,
            'amount': amount,
            'units': units,
            'reason': reason
          }
          ,lang: lang,token: token);
      if((response)['status'] == false){
        throw ApiException(type: ExceptionType.unExpected,message: response['message']);
      }
      return;
    }on ApiException{
      rethrow;
    } catch(e){
      throw(ApiException.getDioException(e));
    }
  }



}