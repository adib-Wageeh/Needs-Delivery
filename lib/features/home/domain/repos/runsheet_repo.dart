
import 'package:needs_delivery/core/utils/typedefs.dart';
import 'package:needs_delivery/features/home/domain/entites/order_entity.dart';
import 'package:needs_delivery/features/home/domain/entites/run_sheet_entity.dart';
import 'package:needs_delivery/features/home/domain/entites/run_sheet_item_entity.dart';

abstract class RunSheetRepo{

  ResultFuture<List<RunSheetEntity>> getAllRunSheets({required String token,required String lang});
  ResultFuture<List<RunSheetEntity>> getRunSheetsByDate({required String token,required String date,required String lang});
  ResultFuture<List<RunSheetItemEntity>> getRunSheetInvoices({required String token,required String runSheetId,required String lang});
  ResultFuture<List<OrderEntity>> getRunSheetInvoiceOrders({required String token,required String invoiceId,required String lang});

}