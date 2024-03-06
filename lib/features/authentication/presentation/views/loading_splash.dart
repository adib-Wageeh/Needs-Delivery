import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:needs_delivery/core/common/app/providers/dashboard_navigation.dart';
import 'package:needs_delivery/core/common/app/providers/locale.dart';
import 'package:needs_delivery/core/common/app/providers/user_provider.dart';
import 'package:needs_delivery/core/enums/exception_types.dart';
import 'package:needs_delivery/core/res/fonts.dart';
import 'package:needs_delivery/core/res/media_res.dart';
import 'package:needs_delivery/core/utils/app_route_constants.dart';
import 'package:needs_delivery/core/utils/core_utils.dart';
import 'package:needs_delivery/features/authentication/data/models/user_model.dart';
import 'package:needs_delivery/features/authentication/presentation/cubits/sign_in/sign_in_cubit.dart';
import 'package:needs_delivery/generated/l10n.dart';
import 'package:provider/provider.dart';

class LoadingSplash extends StatefulWidget {
  const LoadingSplash({super.key});

  @override
  State<LoadingSplash> createState() => _LoadingSplashState();
}

class _LoadingSplashState extends State<LoadingSplash> {
  Future<void> loginToken(String token) async {
    final lang = context.read<LocaleProvider>().getLocale!.languageCode;
    BlocProvider.of<SignInCubit>(context).loginToken(token, lang);
  }

  Future<void> checkAuth() async {
    final res = await CoreUtils.getAuthData();

    if (res != null) {
      await loginToken(res['token']);
    } else {
      if (context.mounted) {
        GoRouter.of(context)
            .pushReplacementNamed(AppRouteConstants.signInRouteName);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await checkAuth();
    });
  }

  @override
  Widget build(BuildContext context) {
    ImageProvider logo = const AssetImage(MediaRes.logoTransparent);
    return Scaffold(
      body: BlocListener<SignInCubit, SignInState>(
        listener: (context, state) {
          if (state is SignInToken) {
            final user = state.userEntity;
            context.read<UserProvider>().initUser(user as UserModel);
            Provider.of<DashboardNavigation>(context,listen: false).resetDashboard();
            GoRouter.of(context)
                .pushReplacementNamed(AppRouteConstants.dashBoardRouteName);
          }
          if (state is SignInError) {
            if (state.error.type == ExceptionType.userNotFound) {
              if (context.mounted) {
                GoRouter.of(context)
                    .pushReplacementNamed(AppRouteConstants.signInRouteName);
              }
            } else {
              if (context.mounted) {
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      return AlertDialog.adaptive(
                        title: Text(S.of(context).no_connection_error,
                            style: Fonts.font12),
                        actions: [
                          TextButton(
                              onPressed: () {
                                checkAuth();
                                Navigator.pop(context);
                              },
                              child: Text(S.of(context).try_again,
                                  style: Fonts.font12))
                        ],
                      );
                    });
              }
            }
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image(
              image: logo,
              height: 200,
              width: 200,
              fit: BoxFit.contain,
            ),
            SizedBox(
              height: 8.h,
            ),
            const Center(
              child: CircularProgressIndicator.adaptive(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          ],
        ),
      ),
      backgroundColor: const Color(0xFF194D87),
    );
  }
}
