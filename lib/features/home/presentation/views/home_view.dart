import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:needs_delivery/core/common/app/providers/location_provider.dart';
import 'package:needs_delivery/core/utils/core_utils.dart';
import 'package:needs_delivery/features/home/domain/entites/run_sheet_entity.dart';
import 'package:needs_delivery/features/home/presentation/widgets/date_picker_widget.dart';
import 'package:needs_delivery/features/home/presentation/widgets/home_header.dart';
import 'package:needs_delivery/features/home/presentation/widgets/orders_progress_bar.dart';
import 'package:needs_delivery/features/home/presentation/widgets/run_sheet_container.dart';
import 'package:needs_delivery/features/home/presentation/widgets/run_sheets_list_view_widget.dart';
import 'package:needs_delivery/generated/l10n.dart';
import 'package:provider/provider.dart';


class HomeView extends StatefulWidget {
  const HomeView({super.key});

  static const route = '/home';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      CoreUtils.getRunSheets(context);
      CoreUtils.getDailyStatics(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LocationProvider>(
      builder: (context,provider,_) {
        bool status = (provider.getButtonPressedState && provider.getGpsStatus && provider.getConnectionStatus);
        return Scaffold(
            body: ListView(
          shrinkWrap: true,
          children: const [
            HomeHeader(),
            DatePickerWidget(),
            OrdersProgressBar(),
            RunSheetContainer(runSheetEntity: RunSheetEntity(id: 1, date: 'date', location: 'location', invoicesCount: '2')),
            RunSheetsListWidget()
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: (status)?Colors.green:Colors.red,
          onPressed: null,
          label: Text((status)?S.of(context).online:S.of(context).offline),
          icon: Icon((status)?EvaIcons.wifi:EvaIcons.alertCircleOutline),
        ),
        );
      }
    );
  }
}

