import 'package:background_locator_2/background_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:needs_delivery/core/common/app/providers/dashboard_navigation.dart';
import 'package:needs_delivery/core/common/app/providers/locale.dart';
import 'package:needs_delivery/core/common/app/providers/user_provider.dart';
import 'package:needs_delivery/core/res/colours.dart';
import 'package:needs_delivery/core/services/app_router_config.dart';
import 'package:needs_delivery/core/services/injection_container.dart';
import 'package:needs_delivery/core/utils/core_utils.dart';
import 'package:needs_delivery/features/home/presentation/cubits/location/location_cubit.dart';
import 'package:needs_delivery/core/common/app/providers/location_provider.dart';
import 'package:needs_delivery/generated/l10n.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  await Hive.initFlutter();
  await BackgroundLocator.unRegisterLocationUpdate();
  CoreUtils.saveAuthData('q8MqcyssCBeQEWehsPDms');
  // CoreUtils.clearAuthData();

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
            create: (_) => LocationProvider()..locationServiceRepository()),
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
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    if (!await BackgroundLocator.isServiceRunning()) {
      await BackgroundLocator.initialize();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LocationProvider>(builder: (context, provider, _) {
      sendLocation(context,provider);
      return BlocListener<LocationCubit, LocationState>(
        listener: (context, state) {
          if(state is LocationError){
            provider.updateConnectionStatus(false);
          }else if(state is LocationSubmitted){
            provider.updateConnectionStatus(true);
          }
        },
        child: ScreenUtilInit(
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
            )),
      );
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

    Position? position = provider.getPosition;
    UserProvider userProvider = Provider.of<UserProvider>(context,listen: false);
    LocaleProvider localeProvider = Provider.of<LocaleProvider>(context,listen: false);
    if(position != null && userProvider.user != null){
      BlocProvider.of<LocationCubit>(context,listen: false).updateLocation(lat: position.latitude.toString(),
          long: position.longitude.toString(), token: userProvider.user!.token!, lang: localeProvider.getLocale!.languageCode);
    }

}
