import 'package:equatable/equatable.dart';
import 'package:needs_delivery/core/enums/exception_types.dart';
import 'package:needs_delivery/core/errors/exceptions.dart';

abstract class Failure extends Equatable{
  const Failure({this.message,this.code,required this.type});

  final String? message;
  final ExceptionType type;
  final int? code;

  String get errorMessage {
    return 'Type is $type \ncode is $code\nmessage is $message';
  }

  @override
  List<dynamic> get props => [message,code,type];
}


class ApiFailure extends Failure{

  const ApiFailure({required super.type,super.message,super.code});

  ApiFailure.fromException(ApiException exception)
      : this(message: exception.message, code: exception.code,type: exception.type);


}

