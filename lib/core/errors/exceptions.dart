import 'dart:io';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:needs_delivery/core/enums/exception_types.dart';

class ApiException extends Equatable implements Exception {
  const ApiException({this.message,required this.type,this.code});

  final ExceptionType type;
  final String? message;
  final int? code;

  @override
  List<Object?> get props => [type, code];

  factory ApiException.handleResponse(Response? response) {
    int statusCode = response?.statusCode ?? 0;
    switch (statusCode) {
      case 400:
      case 401:
      case 403:
        return ApiException(type: ExceptionType.unauthorizedRequest,code: statusCode);
      case 404:
        return ApiException(type: ExceptionType.notFound,code: statusCode);
      case 409:
        return ApiException(type: ExceptionType.conflict,code: statusCode);
      case 408:
        return ApiException(type: ExceptionType.connectionTimeout,code: statusCode);
      case 422:
        return ApiException(type: ExceptionType.unProcessAbleEntity,code: statusCode);
      case 500:
        return ApiException(type: ExceptionType.internalServerError,code: statusCode);
      case 503:
        return ApiException(type: ExceptionType.serviceUnavailable,code: statusCode);
      default:
        return ApiException(
          type: ExceptionType.unknownCode,
          code: statusCode
        );
    }
  }

  factory ApiException.getDioException(error) {
    if (error is Exception) {
      try {
        if (error is DioException) {
          switch (error.type) {
            case DioExceptionType.cancel:
              return const ApiException(type: ExceptionType.cancel,);
            case DioExceptionType.connectionTimeout:
              return const ApiException(type: ExceptionType.connectionTimeout,);
            case DioExceptionType.unknown:
              return const ApiException(type: ExceptionType.noInternetConnection,);
            case DioExceptionType.receiveTimeout:
              return const ApiException(type: ExceptionType.receiveTimeout,);
            case DioExceptionType.badResponse:
              return ApiException.handleResponse(error.response);
            case DioExceptionType.sendTimeout:
              return const ApiException(type: ExceptionType.sendTimeout);
            case DioExceptionType.badCertificate:
              return const ApiException(type: ExceptionType.badCertificate);
            case DioExceptionType.connectionError:
            return const ApiException(type: ExceptionType.noInternetConnection,);
          }
        } else if (error is SocketException) {
          return const ApiException(type: ExceptionType.noInternetConnection);
        } else {
          return ApiException(type: ExceptionType.unExpected,message: error.toString());
        }
      } on FormatException catch (e) {
        return ApiException(type: ExceptionType.formatException,message: e.message);
      } catch (_) {
        return ApiException(type: ExceptionType.unExpected,message: error.toString());
      }
    } else {
      if (error.toString().contains("is not a subtype of")) {
        return ApiException(type: ExceptionType.unableToProcess,message: error.toString());
      } else {
        return ApiException(type: ExceptionType.unExpected,message: error.toString());
      }
    }
  }

}

class CacheException extends Equatable implements Exception {
  const CacheException({required this.error, required this.code});

  final String error;
  final int code;

  @override
  List<Object?> get props => [error, code];
}
