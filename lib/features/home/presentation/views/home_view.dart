import 'package:flutter/material.dart';
import 'package:needs_delivery/core/utils/core_utils.dart';
import 'package:needs_delivery/features/home/presentation/widgets/connection_status_widget.dart';
import 'package:needs_delivery/features/home/presentation/widgets/date_picker_widget.dart';
import 'package:needs_delivery/features/home/presentation/widgets/home_header.dart';
import 'package:needs_delivery/features/home/presentation/widgets/orders_progress_bar.dart';
import 'package:needs_delivery/features/home/presentation/widgets/run_sheets_list_view_widget.dart';

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
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: const [
                HomeHeader(),
                DatePickerWidget(),
                OrdersProgressBar(),
                RunSheetsListWidget()
              ],
            ),
          ),
          const ConnectionStatusWidget(),
          const SizedBox(height: 8,)
        ],
      ),
    );
  }
}
