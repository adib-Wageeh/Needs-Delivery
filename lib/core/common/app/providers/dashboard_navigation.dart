import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:needs_delivery/core/services/injection_container.dart';
import 'package:needs_delivery/features/home/presentation/cubits/daily_items_statics/daily_items_statics_cubit.dart';
import 'package:needs_delivery/features/home/presentation/cubits/run_sheets/run_sheet_cubit.dart';
import 'package:needs_delivery/features/home/presentation/views/home_view.dart';
import 'package:needs_delivery/features/profile/presentation/views/profile_view.dart';

class DashboardNavigation extends ChangeNotifier {
  int _currentIndex = 0;

  final _pages = [
    MultiBlocProvider(providers: [
      BlocProvider(create: (_) => sl<RunSheetCubit>()),
      BlocProvider(create: (_) => sl<DailyItemsStaticsCubit>())
    ], child: const HomeView()),
    const ProfileView(),
  ];

  Widget get currentPage => _pages[_currentIndex];

  int get currentIndex => _currentIndex;

  void resetDashboard() {
    _currentIndex = 0;
    notifyListeners();
  }

  void changeIndex(int newIndex) {
    _currentIndex = newIndex;
    notifyListeners();
  }
}
