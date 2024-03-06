import 'package:dartz/dartz.dart';
import 'package:needs_delivery/core/errors/exceptions.dart';
import 'package:needs_delivery/core/errors/failure.dart';
import 'package:needs_delivery/core/utils/typedefs.dart';
import 'package:needs_delivery/features/home/data/data_sources/run_sheet_data_source.dart';
import 'package:needs_delivery/features/home/data/models/run_sheet_model.dart';
import 'package:needs_delivery/features/home/domain/entites/order_entity.dart';
import 'package:needs_delivery/features/home/domain/entites/run_sheet_entity.dart';
import 'package:needs_delivery/features/home/domain/entites/run_sheet_item_entity.dart';
import 'package:needs_delivery/features/home/domain/repos/runsheet_repo.dart';

class RunSheetRepoImpl implements RunSheetRepo{


  final RunSheetRemoteDataSource runSheetRemoteDataSource;
  const RunSheetRepoImpl({required this.runSheetRemoteDataSource});

  @override
  ResultFuture<List<RunSheetEntity>> getAllRunSheets({required String token,required String lang}) async{
    try {
      final response = await runSheetRemoteDataSource.getAllRunSheets(token: token,lang: lang);
      return Right(response);
    }on ApiException catch(e){
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<RunSheetEntity>> getRunSheetsByDate({required String token,required String date,required String lang}) async{
    try {
      final result = await runSheetRemoteDataSource.getRunSheetsByDate(token: token,lang: lang,date: date);
      return Right(result);
    }on ApiException catch(e){
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<RunSheetItemEntity>> getRunSheetInvoices({required String token,required String runSheetId,required String lang})async{
    try {
      final response = await runSheetRemoteDataSource.getRunSheetInvoices(token: token,lang: lang,runSheetId: runSheetId);
      return Right(response);
    }on ApiException catch(e){
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<OrderEntity>> getRunSheetInvoiceOrders(
      {required String token,required String invoiceId,required String lang})async{
    try {
      final response = await runSheetRemoteDataSource.getRunSheetInvoiceOrders(lang:lang,token: token,invoiceId: invoiceId);
      return Right(response);
    }on ApiException catch(e){
      return Left(ApiFailure.fromException(e));
    }
  }

}