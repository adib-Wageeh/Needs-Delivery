import 'package:background_locator_2/background_locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:needs_delivery/core/common/app/providers/dashboard_navigation.dart';
import 'package:needs_delivery/core/common/app/providers/locale.dart';
import 'package:needs_delivery/core/common/app/providers/location_provider.dart';
import 'package:needs_delivery/core/common/widgets/list_option.dart';
import 'package:needs_delivery/core/utils/app_route_constants.dart';
import 'package:needs_delivery/core/utils/core_utils.dart';
import 'package:needs_delivery/features/home/presentation/widgets/connection_status_widget.dart';
import 'package:needs_delivery/generated/l10n.dart';
import 'package:needs_delivery/main.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                const SizedBox(
                  height: 8,
                ),
                ListOption(
                  onTab: () {
                    GoRouter.of(context).pushNamed(AppRouteConstants.profileRouteName);
                  },
                  title: S.of(context).profile_my_profile,
                  icon: Icons.person_2_outlined,
                ),
                ListOption(
                  onTab: () async{
                    Provider.of<LocaleProvider>(context, listen: false).switchLang();
                    Provider.of<DashboardNavigation>(context,listen: false).changeIndex(1);
                  },
                  title: (isArabic()) ? 'English' : 'عربى',
                  icon: Icons.language,
                ),
                ListOption(
                  onTab: () async{
                    await onStop(context);
                    CoreUtils.clearAuthData();
                    GoRouter.of(context).pushReplacementNamed(AppRouteConstants.signInRouteName);
                  },
                  title: S.of(context).profile_sign_out,
                  icon: Icons.logout_rounded,
                )
              ],
            ),
          ),
          const ConnectionStatusWidget(),
          const SizedBox(height: 8,)
        ],
      ),
    );
  }

  Future<void> onStop(BuildContext context) async {
    Provider.of<LocationProvider>(context, listen: false)
        .updateButtonPressedStatus = false;
    await BackgroundLocator.unRegisterLocationUpdate();
  }

}
