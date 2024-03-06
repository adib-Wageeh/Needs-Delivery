import 'package:dio/dio.dart';
import 'package:needs_delivery/constants.dart';
import 'package:retrofit/retrofit.dart';

part 'web_services.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class WebServices{
  factory WebServices(Dio dio, {String baseUrl}) = _WebServices;

  @POST('users/login')
  Future<dynamic> login(@Body() Map<String, dynamic> map,{@Header('lang') required String lang});

  @POST('users/register')
  Future<dynamic> signUp(@Body() Map<String, dynamic> map,{@Header('lang') required String lang});

  @GET('users/getUser')
  Future<dynamic> loginToken({@Header('token') required String token,@Header('lang') required String lang});

  @POST('users/update')
  Future<dynamic> updateUser(@Body() Map<String, dynamic> map,{@Header('lang') required String lang,@Header('token') required String token});

  @POST('users/update_location')
  Future<dynamic> updateLocation(@Body() Map<String, dynamic> map,{@Header('lang') required String lang,@Header('token') required String token});

  @GET('runsheets/getAll')
  Future<dynamic> getAllRunSheets({@Header('token') required String token,@Header('lang') required String lang});

  @GET('runsheets/getItems/{runsheet_id}')
  Future<dynamic> getRunSheetInvoices({@Header('token') required String token,
    @Header('lang') required String lang
    ,@Path('runsheet_id') required int runSheetId
  });

  @GET('runsheets/getOrders/{invoice_id}')
  Future<dynamic> getRunSheetInvoiceOrders({@Header('token') required String token,
    @Header('lang') required String lang
    ,@Path('invoice_id') required int invoiceId
  });

  @POST('runsheets/getByDate')
  Future<dynamic> getRunSheetsByDate({@Body() required Map<String, dynamic> map,
    @Header('token') required String token,@Header('lang') required String lang});

  @POST('runsheets/status')
  Future<dynamic> changeOrderStatus({@Body() required Map<String, dynamic> map,
    @Header('token') required String token,@Header('lang') required String lang});

  @POST('runsheets/damage')
  Future<dynamic> damagedOrder({@Body() required Map<String, dynamic> map,
    @Header('token') required String token,@Header('lang') required String lang});

  @POST('runsheets/return')
  Future<dynamic> returnedOrder({@Body() required Map<String, dynamic> map,
    @Header('token') required String token,@Header('lang') required String lang});

  @POST('runsheets/statics')
  Future<dynamic> invoicesStatics({@Body() required Map<String, dynamic> map,
    @Header('token') required String token,@Header('lang') required String lang});

  static Dio setupDio(){
    Dio dio = Dio();

    dio
      ..options.connectTimeout = const Duration(seconds: 10)
      ..options.receiveTimeout = const Duration(seconds: 10);

    dio.interceptors.add(LogInterceptor(
        responseBody: true,
        error: true,
        request: false,
        requestBody: false,
        responseHeader: false,
        requestHeader: false
    ));

    return dio;
  }

}

