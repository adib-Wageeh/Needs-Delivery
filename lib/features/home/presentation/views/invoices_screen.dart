import 'dart:async';
import 'package:background_locator_2/background_locator.dart';
import 'package:background_locator_2/settings/android_settings.dart';
import 'package:background_locator_2/settings/ios_settings.dart';
import 'package:background_locator_2/settings/locator_settings.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart' as geo_locator;
import 'package:needs_delivery/core/common/app/providers/locale.dart';
import 'package:needs_delivery/core/common/app/providers/user_provider.dart';
import 'package:needs_delivery/core/common/widgets/list_view_shimmer.dart';
import 'package:needs_delivery/core/common/widgets/no_internet_connection.dart';
import 'package:needs_delivery/core/common/widgets/not_found_text.dart';
import 'package:needs_delivery/core/enums/exception_types.dart';
import 'package:needs_delivery/core/res/colours.dart';
import 'package:needs_delivery/core/services/location_callback_handler.dart';
import 'package:needs_delivery/core/utils/core_utils.dart';
import 'package:needs_delivery/core/common/app/providers/location_provider.dart';
import 'package:needs_delivery/features/home/domain/entites/run_sheet_entity.dart';
import 'package:needs_delivery/features/home/presentation/cubits/invoices/invoices_cubit.dart';
import 'package:needs_delivery/features/home/presentation/widgets/connection_status_widget.dart';
import 'package:needs_delivery/features/home/presentation/widgets/invoice_container.dart';
import 'package:needs_delivery/generated/l10n.dart';
import 'package:provider/provider.dart';
import 'package:timeline_tile/timeline_tile.dart';


class RunSheetInvoicesScreen extends StatefulWidget {
  const RunSheetInvoicesScreen({super.key, required this.runSheetEntity});

  final RunSheetEntity runSheetEntity;

  @override
  State<RunSheetInvoicesScreen> createState() => _RunSheetInvoicesScreenState();
}

class _RunSheetInvoicesScreenState extends State<RunSheetInvoicesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getInvoices();
    });
  }

  void getInvoices() {
    final token = context.read<UserProvider>().user!.token;
    final lang = context.read<LocaleProvider>().getLocale!.languageCode;
    BlocProvider.of<InvoicesCubit>(context, listen: false).getRunSheetInvoices(
        runSheetId: widget.runSheetEntity.id.toString(), token: token!, lang: lang);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, provider, _) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colours.primaryColor,
          elevation: 0,
          foregroundColor: Colors.white,
          title: Text(S.of(context).your_orders),
        ),
        body: Column(
          children: [
            Expanded(child: BlocBuilder<InvoicesCubit, InvoicesState>(
                builder: (context, state) {
              if (state is InvoicesLoaded) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final item = state.runSheetItemEntity[index];
                    return TimelineTile(
                      alignment: TimelineAlign.manual,
                      lineXY: 0.05,
                      endChild: InvoiceContainerWidget(runSheetItemEntity: item),
                      isLast: (index == state.runSheetItemEntity.length - 1),
                      isFirst: (index == 0),
                      indicatorStyle: IndicatorStyle(
                        width: 60,
                        height: 40,
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        indicator: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12), color: Colors.blue),
                            child: Center(
                                child: Text(
                                  item.invoiceId.toString(),
                              style: const TextStyle(color: Colors.white),
                            ))),
                        color: Colors.blue,
                      ),
                    );
                  },
                  itemCount: state.runSheetItemEntity.length,
                );
              } else if (state is InvoicesError) {
                if (state.error.type == ExceptionType.noInternetConnection ||
                    state.error.type == ExceptionType.receiveTimeout ||
                    state.error.type == ExceptionType.sendTimeout ||
                    state.error.type == ExceptionType.internalServerError ||
                    state.error.type == ExceptionType.connectionTimeout) {
                  return NoInternetConnection(
                    onPressed: () => getInvoices(),
                    showTitle: true,
                  );
                } else {
                  return NotFoundText(
                    text: state.error.errorMessage,
                  );
                }
              } else {
                return const ListViewShimmer();
              }
            })),
            Column(
              children: [
                const ConnectionStatusWidget(),
                Consumer<LocationProvider>(builder: (context, provider, _) {
                  return Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(color: Colors.grey.shade200),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero
                            ),
                            backgroundColor: (provider.getButtonPressedState)
                                ? Colors.red
                                : Colors.green,
                            padding: const EdgeInsets.symmetric(horizontal: 4)),
                        onPressed: () {
                          if (provider.getButtonPressedState) {
                            Provider.of<LocationProvider>(context,
                                    listen: false)
                                .updateButtonPressedStatus = false;
                            onStop();
                          } else {
                            _onStart();
                          }
                        },
                        child: Text(
                          (provider.getButtonPressedState)
                              ? S.of(context).today_orders_end
                              : S.of(context).today_orders_start,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )),
                  );
                }),
              ],
            )
          ],
        ),
      );
    });
  }

  void _onStart() async {
    if (await _checkLocationPermission()) {
      if (context.mounted) {
        bool result = await geo_locator.Geolocator.isLocationServiceEnabled();
        if (result == true) {
          if (context.mounted) {
            listenToGpsService(context);
            Provider.of<LocationProvider>(context, listen: false)
                .updateButtonPressedStatus = true;
            await _startLocator();
          }
        } else {
          if (context.mounted) {
            CherryToast.error(title: Text(S.of(context).location_disabled))
                .show(context);
          }
        }
      }
    } else {
      if (context.mounted) {
        CoreUtils.showSnackBar(
            context, 'please allow the mobile to access your location');
      }
    }
  }

  void onStop() async {
    Provider.of<LocationProvider>(context, listen: false)
        .updateButtonPressedStatus = false;
    await BackgroundLocator.unRegisterLocationUpdate();
  }

  Future<bool> _checkLocationPermission() async {
    final state = await geo_locator.Geolocator.checkPermission();
    switch (state) {
      case geo_locator.LocationPermission.unableToDetermine:
      case geo_locator.LocationPermission.denied:
      case geo_locator.LocationPermission.deniedForever:
        final permission = await geo_locator.Geolocator.requestPermission();
        if (permission == geo_locator.LocationPermission.always ||
            permission == geo_locator.LocationPermission.whileInUse) {
          return true;
        } else {
          return false;
        }
      case geo_locator.LocationPermission.always:
      case geo_locator.LocationPermission.whileInUse:
        return true;
      default:
        return false;
    }
  }

  Future<void> _startLocator() async {
    Map<String, dynamic> data = {'countInit': 1};
    return await BackgroundLocator.registerLocationUpdate(
        LocationCallbackHandler.callback,
        initCallback: LocationCallbackHandler.initCallback,
        initDataCallback: data,
        disposeCallback: LocationCallbackHandler.disposeCallback,
        iosSettings: const IOSSettings(
            accuracy: LocationAccuracy.NAVIGATION,
            distanceFilter: 0,
            stopWithTerminate: true),
        autoStop: false,
        androidSettings: const AndroidSettings(
          accuracy: LocationAccuracy.NAVIGATION,
          interval: 10,
          distanceFilter: 0,
          client: LocationClient.google,
        ));
  }

  void listenToGpsService(BuildContext context) async {
    bool gpsEnabled = await geo_locator.Geolocator.isLocationServiceEnabled();
    if (context.mounted) {
      final provider = Provider.of<LocationProvider>(context, listen: false);
      provider.updateGpsStatus((gpsEnabled)
          ? geo_locator.ServiceStatus.enabled
          : geo_locator.ServiceStatus.disabled);
      final stream = geo_locator.Geolocator.getServiceStatusStream();
      stream.listen((status) {
        provider.updateGpsStatus(status);
      });
    }
  }
}
