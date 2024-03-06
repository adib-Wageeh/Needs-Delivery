part of 'injection_container.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await _signInInit();

  await _registerInit();

  await _updateInit();

  await _updateLocationInit();

  await _runSheetsInit();

  await _invoicesInit();

  await _ordersInit();

  await _changeStatusInit();

  await _dailyItemsStaticsInit();


}

Future<void> _signInInit() async {

  final prefs = await SharedPreferences.getInstance();

  sl
    ..registerFactory(() => SignInCubit(
        login: sl(), loginTokenUseCase: sl()))
    ..registerLazySingleton(() => LoginTokenUseCase(authenticationRepo: sl()))
    ..registerLazySingleton(() => LoginUseCase(authenticationRepo: sl()))
    ..registerLazySingleton<AuthenticationRepo>(
        () => AuthenticationRepoImpl(remoteDataSource: sl()))
    ..registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(webServices: sl()))
    ..registerLazySingleton<WebServices>(
        () => WebServices(WebServices.setupDio()))
    ..registerLazySingleton<SharedPreferences>(() => prefs);
}

Future<void> _registerInit() async {
  sl
    ..registerFactory(
        () => RegisterCubit(registerUseCase: sl()))
    ..registerLazySingleton(() => RegisterUseCase(authenticationRepo: sl()));
}

Future<void> _updateInit() async {
  sl.registerFactory(() => UpdateCubit(
      updateUserUseCase: UpdateUserUseCase(authenticationRepo: sl()),
      locationService: sl()));
}

Future<void> _updateLocationInit() async {
  sl.registerFactory(() => LocationCubit(
      updateLocationUseCase: UpdateLocationUseCase(authenticationRepo: sl()),));
}

Future<void> _runSheetsInit() async {
  sl..registerFactory(() => RunSheetCubit(
    getAllRunSheetsUseCase: sl(),getRunSheetsByDateUseCase: sl(),))
  ..registerLazySingleton(() => GetAllRunSheetsUseCase(runSheetRepo: sl()))
  ..registerLazySingleton(() => GetRunSheetsByDateUseCase(runSheetRepo: sl()))
  ..registerLazySingleton<RunSheetRepo>(() => RunSheetRepoImpl(runSheetRemoteDataSource: sl()))
  ..registerLazySingleton<RunSheetRemoteDataSource>(() => RunSheetRemoteDataSourceImpl(sl()));
}

Future<void> _invoicesInit() async {
  sl..registerFactory(() => InvoicesCubit(
    getRunSheetInvoicesUseCase: sl(),))
    ..registerLazySingleton(() => GetRunSheetInvoicesUseCase(runSheetRepo: sl()));
}

Future<void> _ordersInit() async {
  sl..registerFactory(() => OrdersCubit(
    getRunSheetInvoiceOrdersUseCase: sl(),))
    ..registerLazySingleton(() => GetRunSheetInvoiceOrdersUseCase(runSheetRepo: sl()));
}

Future<void> _changeStatusInit() async {
  sl..registerFactory(() => ChangeStatusCubit(changeOrderStatusUseCase: sl()))
    ..registerLazySingleton(() => ChangeOrderStatusUseCase(orderStatusRepo: sl()))
  ..registerLazySingleton(() => DamagedOrderUseCase(orderStatusRepo: sl()))
  ..registerLazySingleton(() => ReturnedOrderUseCase(orderStatusRepo: sl()))
  ..registerLazySingleton<OrderStatusRepo>(() =>
      OrderStatusRepoImpl(orderStatusRemoteDataSource: sl()))
  ..registerLazySingleton<OrderStatusRemoteDataSource>(() =>
      OrderStatusRemoteDataSourceImpl(sl()));

}

Future<void> _dailyItemsStaticsInit() async {
  sl..registerFactory(() => DailyItemsStaticsCubit(
    dailyItemsStaticsUseCase: sl(),))
    ..registerLazySingleton(() => DailyItemsStaticsUseCase(dailyItemsStaticsRepo: sl()))
    ..registerLazySingleton<DailyItemsStaticsRepo>(() => DailyItemsStaticsRepoImpl(dailyItemsStaticsRemoteDataSource: sl()))
  ..registerLazySingleton<DailyItemsStaticsRemoteDataSource>
    (() => DailyItemsStaticsRemoteDataSourceImpl(sl()));

}