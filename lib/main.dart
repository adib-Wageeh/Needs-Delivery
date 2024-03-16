import 'dart:isolate';
import 'dart:ui';
import 'package:geolocator/geolocator.dart' as geo_locator;
import 'package:background_locator_2/background_locator.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:needs_delivery/core/common/app/providers/dashboard_navigation.dart';
import 'package:needs_delivery/core/common/app/providers/locale.dart';
import 'package:needs_delivery/core/common/app/providers/user_provider.dart';
import 'package:needs_delivery/core/res/colours.dart';
import 'package:needs_delivery/core/services/app_router_config.dart';
import 'package:needs_delivery/core/services/injection_container.dart';
import 'package:needs_delivery/core/services/location_service_repo.dart';
import 'package:needs_delivery/features/home/presentation/cubits/location/location_cubit.dart';
import 'package:needs_delivery/core/common/app/providers/location_provider.dart';
import 'package:needs_delivery/generated/l10n.dart';
import 'package:provider/provider.dart';

final ReceivePort port = ReceivePort();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  await Hive.initFlutter();
  await BackgroundLocator.unRegisterLocationUpdate();
  // CoreUtils.saveAuthData('q8MqcyssCBeQEWehsPDms');
  // CoreUtils.clearAuthData();

  IsolateNameServer.registerPortWithName(
    port.sendPort,
    LocationServiceRepository.isolateName,
  );

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<LocationCubit>()),
      ],
      child: MultiProvider(providers: [
        ChangeNotifierProvider(
          create: (_) => LocaleProvider()..initLang(),
        ),
        ChangeNotifierProvider(create: (_) => DashboardNavigation()),
        ChangeNotifierProvider(
            create: (_) => LocationProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ], child: const MyApp()),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GoRouter _router = AppRouter.returnRouter();

  @override
  void initState(){
    super.initState();
    initPlatformState();
    geo_locator.Geolocator.getServiceStatusStream().listen((event) {
      final provider = Provider.of<LocationProvider>(context, listen: false);
      if(event == geo_locator.ServiceStatus.enabled){
        provider.updateGpsStatus(true);
      }else{
        provider.updateGpsStatus(false);
      }
    });

    port.listen((data) async {
      final provider = Provider.of<LocationProvider>(context, listen: false);
      if(data == null){
        provider.updateConnectionStatus(false);
      }else{
        var connectivityResult = await checkInternetConnectivity();
        if (connectivityResult) {
          provider.updateConnectionStatus(true);
          final token = context.read<UserProvider>().user!.token;
          final lang = context.read<LocaleProvider>().getLocale!.languageCode;
          BlocProvider.of<LocationCubit>(context,listen: false)
              .updateLocation(lat: data['latitude'].toString(), long: data['longitude'].toString(),
              token: token!, lang: lang);

        }else {
          provider.updateConnectionStatus(false);
        }
      }
    });
  }

  Future<void> initPlatformState() async {
    if (!await BackgroundLocator.isServiceRunning()) {
      await BackgroundLocator.initialize();
    }
  }

  Future<bool> checkInternetConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return false; // No internet connection
    } else {
      try {
        final response = await http.get(Uri.parse('https://example.com'));
        if (response.statusCode == 200) {
          return true; // Internet connection available
        } else {
          return false; // Unable to connect to internet
        }
      } catch (e) {
        return false; // Unable to connect to internet
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LocationProvider>(builder: (context, provider, _) {
      sendLocation(context,provider);
      return ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          child: MaterialApp.router(
            builder: EasyLoading.init(),
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            theme: ThemeData(
              fontFamily: 'Lato',
            ),
            supportedLocales: S.delegate.supportedLocales,
            debugShowCheckedModeBanner: false,
            locale: Provider.of<LocaleProvider>(context).getLocale,
            routerConfig: _router,
          ));
    });
  }
}

bool isArabic() {
  return Intl.getCurrentLocale() == 'ar';
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..backgroundColor = Colours.primaryColor
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = false;
}

void sendLocation(BuildContext context,LocationProvider provider){

    // Position? position = provider.getPosition;
    // UserProvider userProvider = Provider.of<UserProvider>(context,listen: false);
    // LocaleProvider localeProvider = Provider.of<LocaleProvider>(context,listen: false);
    // if(position != null && userProvider.user != null){
    //   BlocProvider.of<LocationCubit>(context,listen: false).updateLocation(lat: position.latitude.toString(),
    //       long: position.longitude.toString(), token: userProvider.user!.token!, lang: localeProvider.getLocale!.languageCode);
    // }

}
