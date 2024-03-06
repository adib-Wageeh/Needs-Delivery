import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:needs_delivery/core/common/app/providers/dashboard_navigation.dart';
import 'package:needs_delivery/core/common/app/providers/locale.dart';
import 'package:needs_delivery/core/common/widgets/list_option.dart';
import 'package:needs_delivery/core/utils/app_route_constants.dart';
import 'package:needs_delivery/core/utils/core_utils.dart';
import 'package:needs_delivery/generated/l10n.dart';
import 'package:needs_delivery/main.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
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
            onTab: () {
              CoreUtils.clearAuthData();
              GoRouter.of(context).pushReplacementNamed(AppRouteConstants.signInRouteName);
            },
            title: S.of(context).profile_sign_out,
            icon: Icons.logout_rounded,
          )
        ],
      ),
    );
  }
}
