import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:needs_delivery/core/common/app/providers/dashboard_navigation.dart';
import 'package:needs_delivery/core/common/app/providers/locale.dart';
import 'package:needs_delivery/core/common/app/providers/user_provider.dart';
import 'package:needs_delivery/core/common/widgets/i_field.dart';
import 'package:needs_delivery/core/enums/exception_types.dart';
import 'package:needs_delivery/core/res/media_res.dart';
import 'package:needs_delivery/core/utils/app_route_constants.dart';
import 'package:needs_delivery/core/utils/core_utils.dart';
import 'package:needs_delivery/features/authentication/data/models/user_model.dart';
import 'package:needs_delivery/features/authentication/presentation/cubits/sign_in/sign_in_cubit.dart';
import 'package:needs_delivery/generated/l10n.dart';
import 'package:provider/provider.dart';
import '../../../../core/res/colours.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const route = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _accountFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final loginAuth = BlocProvider.of<SignInCubit>(context);
    final size = MediaQuery.of(context).size;
    return BlocListener<SignInCubit, SignInState>(
      listener: (context, state) {
        if (state is SignInSuccessfully) {
          final lang = context.read<LocaleProvider>().getLocale!.languageCode;
          CoreUtils.saveAuthData(state.token);
          BlocProvider.of<SignInCubit>(context).loginToken(state.token, lang);
        } else if (state is SignInToken) {
          final user = state.userEntity;
          context.read<UserProvider>().initUser(user as UserModel);
          Provider.of<DashboardNavigation>(context, listen: false)
              .resetDashboard();
          GoRouter.of(context).pushReplacementNamed(AppRouteConstants.dashBoardRouteName);
        } else if (state is SignInError) {
          if(state.error.type == ExceptionType.userRejected){
            CoreUtils.showSnackBar(context, 'Your account has been rejected');
          }else if(state.error.type == ExceptionType.waitForApprove){
            CoreUtils.showSnackBar(context, 'wait for administration confirm');
          }else
          if (state.error.type == ExceptionType.noInternetConnection ||
              state.error.type == ExceptionType.connectionTimeout ||
              state.error.type == ExceptionType.receiveTimeout ||
              state.error.type == ExceptionType.internalServerError ||
              state.error.type == ExceptionType.sendTimeout) {
            CoreUtils.showSnackBar(context, 'no internet connection');
          } else if(state.error.message == 'Check your login data'){
            CoreUtils.showSnackBar(context, state.error.message!);
          }else{
            CoreUtils.showSnackBar(context, state.error.errorMessage);
          }
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
                  const SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    height: 40,
                    child: Image.asset(
                      MediaRes.logoMark,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  AutoSizeText(
                    minFontSize: 18,
                    maxFontSize: 36,
                    S.of(context).login_title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.sp,
                      color: Colors.white
                    ),
                    textAlign: TextAlign.center,
                  ),
                  AutoSizeText(
                    minFontSize: 16,
                    maxFontSize: 30,
                    S.of(context).login_subTitle,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: size.height * 0.07,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Form(
                        key: _accountFormKey,
                        child: Column(
                          children: [
                            IField(
                              controller: loginAuth.mobile,
                              hintText: S.of(context).login_phone_number_hint,
                              keyboardType: TextInputType.phone,
                              prefixIcon: const Icon(Icons.phone_android),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            IField(
                              controller: loginAuth.password,
                              hintText: S.of(context).login_password_hint,
                              prefixIcon: const Icon(Icons.key),
                              autoCorrect: false,
                              enableSuggestions: false,
                              obscureText: true,
                            )
                          ],
                        )),
                  ),
                  SizedBox(
                    height: 28.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: GestureDetector(
                      onTap: () {
                        if (_accountFormKey.currentState!.validate()) {
                          final lang = context
                              .read<LocaleProvider>()
                              .getLocale!
                              .languageCode;
                          loginAuth.login(lang);
                        }
                      },
                      child: BlocBuilder<SignInCubit, SignInState>(
                        builder: (context, state) {
                          if (state is SignInLoading) {
                            return const Center(
                              child: CircularProgressIndicator.adaptive(),
                            );
                          }
                          return Align(
                            alignment: Alignment.center,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 24
                              ),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Colors.orange, Colors.deepOrange],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: AutoSizeText(
                                minFontSize: 14,
                                maxFontSize: 24,
                                S.of(context).login_button,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.deepOrange,
                    ),
                    child: AutoSizeText(
                        minFontSize: 12,
                        maxFontSize: 24,
                        S.of(context).login_forgetPassword,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.white
                        )),
                  ),
                  TextButton(
                    onPressed: () {
                      GoRouter.of(context).pushReplacementNamed(AppRouteConstants.signUpRouteName);
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.deepOrange,
                    ),
                    child: AutoSizeText(
                      minFontSize: 12,
                      maxFontSize: 24,
                      style: TextStyle(fontSize: 12.sp),
                      S.of(context).login_register,
                      // style: Fonts.font14,
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
