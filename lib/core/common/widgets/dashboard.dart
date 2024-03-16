import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:needs_delivery/core/common/app/providers/dashboard_navigation.dart';
import 'package:needs_delivery/core/res/colours.dart';
import 'package:provider/provider.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  static const route = '/dashboard';

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardNavigation>(
      builder: (context, navigator, _) {
        return Scaffold(
            backgroundColor: Colors.white,
            body: navigator.currentPage,
            bottomNavigationBar: CurvedNavigationBar(
              index: navigator.currentIndex,
              height: 60,
              items: const <Widget>[
                Icon(Icons.home, size: 30, color: Colors.white),
                Icon(Icons.list, size: 30, color: Colors.white),
              ],
              color: Colours.primaryColor,
              buttonBackgroundColor: Colours.primaryColor,
              backgroundColor: Colors.transparent,
              animationCurve: Curves.easeInOut,
              animationDuration: const Duration(milliseconds: 500),
              onTap: navigator.changeIndex,
              letIndexChange: (index) => true,
            ));
      },
    );
  }
}
