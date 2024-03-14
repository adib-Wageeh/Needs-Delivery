import 'package:intl/intl.dart';
import 'package:needs_delivery/core/enums/exception_types.dart';
import 'package:needs_delivery/core/errors/exceptions.dart';
import 'package:needs_delivery/core/services/web_services.dart';
import 'package:needs_delivery/features/home/data/models/order_model.dart';
import 'package:needs_delivery/features/home/data/models/run_sheet_item_model.dart';
import 'package:needs_delivery/features/home/data/models/run_sheet_model.dart';

abstract class RunSheetRemoteDataSource {
  Future<List<RunSheetModel>> getAllRunSheets(
      {required String token, required String lang});

  Future<List<RunSheetModel>> getRunSheetsByDate(
      {required String token, required String date, required String lang});

  Future<List<RunSheetItemModel>> getRunSheetInvoices(
      {required String token,
      required String runSheetId,
      required String lang});

  Future<List<OrderModel>> getRunSheetInvoiceOrders(
      {required String token, required String invoiceId, required String lang});
}

class RunSheetRemoteDataSourceImpl implements RunSheetRemoteDataSource {
  final WebServices webServices;

  RunSheetRemoteDataSourceImpl(this.webServices);

  @override
  Future<List<RunSheetModel>> getAllRunSheets(
      {required String token, required String lang}) async {
    try {
      final response =
          await webServices.getAllRunSheets(lang: lang, token: token);
      if ((response)['status'] == false) {
        throw ApiException(
            type: ExceptionType.unExpected, message: response['message']);
      }
      return ((response)['data'] as List)
          .map((runSheet) => RunSheetModel.fromJson(runSheet))
          .toList();
    } on ApiException {
      rethrow;
    } catch (e) {
      throw (ApiException.getDioException(e));
    }
  }

  @override
  Future<List<OrderModel>> getRunSheetInvoiceOrders(
      {required String token,
      required String invoiceId,
      required String lang}) async {
    try {
      final response = await webServices.getRunSheetInvoiceOrders(
          invoiceId: int.parse(invoiceId), lang: lang, token: token);
      if ((response)['status'] == false) {
        throw ApiException(
            type: ExceptionType.unExpected, message: response['message']);
      }
      return ((response)['data'] as List)
          .map((order) => OrderModel.fromJson(order))
          .toList();
    } on ApiException {
      rethrow;
    } catch (e) {
      throw (ApiException.getDioException(e));
    }
  }

  @override
  Future<List<RunSheetItemModel>> getRunSheetInvoices(
      {required String token,
      required String runSheetId,
      required String lang}) async {
    try {
      final response = await webServices.getRunSheetInvoices(
          runSheetId: int.parse(runSheetId), lang: lang, token: token);
      if ((response)['status'] == false) {
        throw ApiException(
            type: ExceptionType.unExpected, message: response['message']);
      }
      return ((response)['data'] as List)
          .map((item) => RunSheetItemModel.fromJson(item))
          .toList();
    } on ApiException {
      rethrow;
    } catch (e) {
      throw (ApiException.getDioException(e));
    }
  }

  @override
  Future<List<RunSheetModel>> getRunSheetsByDate(
      {required String token,
      required String date,
      required String lang}) async {
    try {

      final response = await webServices
          .getRunSheetsByDate(map: {'date': date}, lang: lang, token: token);
      if ((response)['status'] == false) {
        throw ApiException(
            type: ExceptionType.unExpected, message: response['message']);
      }
      return ((response)['data'] as List)
          .map((runSheet) => RunSheetModel.fromJson(runSheet))
          .toList();
    } on ApiException {
      rethrow;
    } catch (e) {
      throw (ApiException.getDioException(e));
    }
  }
}
