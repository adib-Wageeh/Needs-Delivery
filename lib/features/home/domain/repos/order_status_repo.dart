
import 'package:needs_delivery/core/utils/typedefs.dart';

abstract class OrderStatusRepo{

  ResultFuture<void> changeOrderStatus({required String invoiceId,required String status
    ,required String token,required String lang});
  ResultFuture<void> damagedOrder({required String token,required String invoiceId
    ,required String orderId,required String lang,required String amount,
    required String units,required String reason});
  ResultFuture<void> returnedOrder({required String token,required String invoiceId,
    required String lang,required String amount,required String orderId,
    required String units,required String reason});

}