import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:needs_delivery/core/common/app/providers/locale.dart';
import 'package:needs_delivery/core/enums/exception_types.dart';
import 'package:needs_delivery/core/res/colours.dart';
import 'package:needs_delivery/core/res/fonts.dart';
import 'package:needs_delivery/core/res/media_res.dart';
import 'package:needs_delivery/core/utils/app_route_constants.dart';
import 'package:needs_delivery/core/utils/core_utils.dart';
import 'package:needs_delivery/features/authentication/presentation/cubits/register/register_cubit.dart';
import 'package:needs_delivery/features/authentication/presentation/widgets/register_form.dart';
import 'package:needs_delivery/generated/l10n.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  static const route = '/signUp';

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterError) {
          if (state.error.type == ExceptionType.noInternetConnection ||
              state.error.type == ExceptionType.receiveTimeout ||
              state.error.type == ExceptionType.sendTimeout ||
              state.error.type == ExceptionType.internalServerError ||
              state.error.type == ExceptionType.connectionTimeout) {
            CoreUtils.showSnackBar(context, 'no internet connection');
          }else {
            CoreUtils.showSnackBar(context, state.error.message!);
          }
        }
        if (state is SignedUpSuccessfully) {
          CoreUtils.saveAuthData(state.token);
          CoreUtils.showDataReviewDialog(
              context, S.of(context).account_request_sent, () {
            GoRouter.of(context).pushReplacementNamed(AppRouteConstants.signInRouteName);
          });
        }
      },
      child: Scaffold(
        backgroundColor: Colours.secondaryColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 50.h,
                  ),
                  SizedBox(
                    height: 40.h,
                    child: Image.asset(
                      MediaRes.logoMark,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  AutoSizeText(
                    minFontSize: 16,
                    maxFontSize: 30,
                    S.of(context).register_title,
                    style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  AutoSizeText(
                    minFontSize: 16,
                    maxFontSize: 30,
                    S.of(context).register_subTitle,
                    style: TextStyle(color: Colors.white, fontSize: 16.sp),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 35.h,
                  ),
                  Form(key: _signupFormKey, child: const RegisterForm()),
                  SizedBox(
                    height: 28.h,
                  ),
                  BlocBuilder<RegisterCubit, RegisterState>(
                    builder: (context, state) {
                      if (state is RegisterLoading) {
                        return const Center(
                          child: CircularProgressIndicator.adaptive(),
                        );
                      }
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: GestureDetector(
                          onTap: () {
                            if (_signupFormKey.currentState!.validate()) {
                              final lang = context
                                  .read<LocaleProvider>()
                                  .getLocale!
                                  .languageCode;
                              BlocProvider.of<RegisterCubit>(context)
                                  .signUp(lang);
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 12.h,
                            ),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Colors.orange, Colors.deepOrange],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(36),
                            ),
                            child: Text(
                              S.of(context).register_button,
                              style: Fonts.font14
                                  .copyWith(fontWeight: FontWeight.w600),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  TextButton(
                    onPressed: () {
                      GoRouter.of(context).pushReplacementNamed(AppRouteConstants.signInRouteName);
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.deepOrange,
                    ),
                    child: Text(
                      S.of(context).register_login,
                      style: Fonts.font14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

final GlobalKey<FormState> _signupFormKey = GlobalKey<FormState>();
