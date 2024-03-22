import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:needs_delivery/core/common/app/providers/locale.dart';
import 'package:needs_delivery/core/common/app/providers/user_provider.dart';
import 'package:needs_delivery/core/res/colours.dart';
import 'package:needs_delivery/features/home/presentation/cubits/daily_items_statics/daily_items_statics_cubit.dart';
import 'package:needs_delivery/features/home/presentation/cubits/run_sheets/run_sheet_cubit.dart';
import 'package:needs_delivery/generated/l10n.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';


class CoreUtils {
  const CoreUtils._();

  static void showSnackBar(BuildContext context, String message) {
    late String newMessage;
    switch (message) {
      case 'Check your login data':
        newMessage = S.of(context).check_your_data;
      case 'wait for administration confirm':
        newMessage = S.of(context).account_approval;
      case 'The location service on the device is disabled.':
        newMessage = S.of(context).location_disabled;
      case 'The location permission has been disabled permenantly.':
        newMessage = S.of(context).location_permission_permenantly;
      case 'please allow the mobile to access your location':
        newMessage = S.of(context).location_permission_refused;
      case 'location has been updated please confirm':
        newMessage = S.of(context).update_location_confirm;
      case 'no internet connection':
        newMessage = S.of(context).no_connection_error;
      case 'Old password is not correct':
        newMessage = S.of(context).old_password_error;
      case 'password updated':
        newMessage = S.of(context).password_updated;
      case 'Your account has been rejected':
        newMessage = S.of(context).user_rejected;
      default:
        newMessage = message;
    }

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            newMessage,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w600),
          ),
          elevation: 5,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colours.secondaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.all(10),
        ),
      );
  }

  static void saveAuthData(String token) async {
    const storage = FlutterSecureStorage();
    await storage.write(key: 'needs_delivery', value: token);
  }

  static Future<Map<String, dynamic>?> getAuthData() async {
    const storage = FlutterSecureStorage();
    String? storedToken = await storage.read(key: 'needs_delivery');
    if (storedToken == null) {
      return null;
    }
    return {'token': storedToken};
  }

  static Future<void> clearAuthData() async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: 'needs_delivery');
  }

  static void showDataReviewDialog(
      BuildContext context, String text, VoidCallback onPressed) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog.adaptive(
            title: Text(
              text,
              style: TextStyle(fontSize: 14.sp),
            ),
            actions: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colours.primaryColor,
                      foregroundColor: Colors.white),
                  onPressed: onPressed,
                  child: Text(
                    S.of(context).ok_button,
                    style: const TextStyle(color: Colors.white),
                  ))
            ],
          );
        });
  }

  static Future<bool> showDisclosure(
      BuildContext context) async{
     bool res = await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog.adaptive(
            title: Text(
              S.of(context).disclosures,
              style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
            ),
            content: Image.asset('assets/images/location-2.png'),
            actions: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colours.primaryColor,
                      foregroundColor: Colors.white),
                  onPressed: ()=>Navigator.pop(context,true),
                  child: Text(
                    S.of(context).disclosures_agree,
                    style: const TextStyle(color: Colors.white),
                  )),
              TextButton(
                  onPressed: ()=>Navigator.pop(context,false),
                  child: Text(
                S.of(context).disclosures_decline
              ))
            ],
          );
        });
     return res;
  }

  static Future<int?> showInvoiceConfirmationDialog(
      BuildContext context, String text) async{
    return showDialog<int?>(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog.adaptive(
            title: Text(
              text,
              style: TextStyle(fontSize: 14.sp),
            ),
            actions: [
              TextButton(onPressed: (){
                Navigator.pop(context);
              }, child: Text(S.of(context).cancel)),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colours.primaryColor,
                      foregroundColor: Colors.white),
                  onPressed: (){
                    Navigator.pop(context,1);
                  },
                  child: Text(
                    S.of(context).yes,
                    style: const TextStyle(color: Colors.white),
                  ))
            ],
          );
        });
  }

  static Future<void> launchURL(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }


  static void getRunSheets(BuildContext context) {
    final token = context.read<UserProvider>().user!.token;
    final lang = context.read<LocaleProvider>().getLocale!.languageCode;
    final selectedDate =
        Provider.of<UserProvider>(context, listen: false).getSelectedDate;
    if(selectedDate == null){
      BlocProvider.of<RunSheetCubit>(context,listen: false).getAllRunSheets(token: token!, lang: lang);
    }else{
      final date = DateFormat('yyyy-MM-dd').format(selectedDate);
      BlocProvider.of<RunSheetCubit>(context,listen: false).getRunSheetsByDate(date: date,token: token!, lang: lang);
    }
  }

  static void getDailyStatics(BuildContext context) {
    final token = context.read<UserProvider>().user!.token;
    final lang = context.read<LocaleProvider>().getLocale!.languageCode;
    final selectedDate =
        Provider.of<UserProvider>(context, listen: false).getSelectedDate;
    if(selectedDate == null){
      final date = DateFormat('yyyy-MM-dd').format(DateTime.now());
      BlocProvider.of<DailyItemsStaticsCubit>(context,listen: false)
          .getDailyItemsStatics(date: date,token: token!, lang: lang);
    }else{
      final date = DateFormat('yyyy-MM-dd').format(selectedDate);
      BlocProvider.of<DailyItemsStaticsCubit>(context,listen: false)
          .getDailyItemsStatics(date: date,token: token!, lang: lang);
    }
  }


}
