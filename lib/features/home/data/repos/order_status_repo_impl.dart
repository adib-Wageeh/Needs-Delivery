import 'package:dartz/dartz.dart';
import 'package:needs_delivery/core/errors/exceptions.dart';
import 'package:needs_delivery/core/errors/failure.dart';
import 'package:needs_delivery/core/utils/typedefs.dart';
import 'package:needs_delivery/features/home/data/data_sources/order_status_data_source.dart';
import 'package:needs_delivery/features/home/domain/repos/order_status_repo.dart';

class OrderStatusRepoImpl implements OrderStatusRepo{


  final OrderStatusRemoteDataSource orderStatusRemoteDataSource;
  const OrderStatusRepoImpl({required this.orderStatusRemoteDataSource});

  @override
  ResultFuture<void> changeOrderStatus({required String invoiceId,required String status
    ,required String token,required String lang}) async{
    try {
      final response = await orderStatusRemoteDataSource.changeOrderStatus(
          invoiceId: invoiceId,status: status,token: token,lang: lang);
      return Right(response);
    }on ApiException catch(e){
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> damagedOrder({required String token,required String invoiceId
    ,required String orderId,required String lang,required String amount,
    required String units,required String reason}) async{
    try {
      final result = await orderStatusRemoteDataSource.damagedOrder(
          invoiceId: invoiceId,amount: amount,orderId: orderId,
          token: token,lang: lang,reason: reason,units: units);
      return Right(result);
    }on ApiException catch(e){
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> returnedOrder({required String token,required String invoiceId,
    required String lang,required String amount,required String orderId,
    required String units,required String reason})async{
    try {
      final response = await orderStatusRemoteDataSource.returnedOrder(
          token: token,lang: lang,orderId:orderId,amount: amount,
      invoiceId: invoiceId,units: units,reason: reason);
      return Right(response);
    }on ApiException catch(e){
      return Left(ApiFailure.fromException(e));
    }
  }


}