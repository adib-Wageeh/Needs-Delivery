import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:needs_delivery/core/common/app/providers/user_provider.dart';
import 'package:needs_delivery/core/res/colours.dart';
import 'package:needs_delivery/core/utils/core_utils.dart';
import 'package:needs_delivery/generated/l10n.dart';
import 'package:provider/provider.dart';

class DatePickerWidget extends StatelessWidget {
  const DatePickerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
        builder: (context,provider,_) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 12),
            child: Row(
              children: [
                IconButton(onPressed: (){}, icon: const Icon(Icons.search_rounded),
                style: IconButton.styleFrom(
                  backgroundColor: Colours.primaryColor,
                  foregroundColor: Colors.white
                ),
                ),
                Expanded(
                  child: TextField(
                      controller: (provider.getSelectedDate != null)?
                      TextEditingController(text: DateFormat('yyyy-MM-dd')
                          .format(provider.getSelectedDate!)):TextEditingController(text:
                      DateFormat('yyyy-MM-dd').format(DateTime.now())),
                      decoration: const InputDecoration(
                        filled: true,
                        contentPadding: EdgeInsets.zero,
                        prefixIconConstraints: BoxConstraints(
                          minWidth: 35
                        ),
                        prefixIcon: Icon(Icons.calendar_today_rounded),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colours.primaryColor
                            )
                        ),
                      ),
                      readOnly: true,
                      onTap: () {
                        selectTime(context,provider);
                      }
                  ),
                ),
              ],
            ),
          );
        }
    );
  }

  Future <void> selectTime(BuildContext context,UserProvider provider) async {
    DateTime ? picked = await showDatePicker(
      context: context,
      initialDate:  (provider.getSelectedDate == null)?DateTime.now():provider.getSelectedDate!,
      firstDate: DateTime.utc(2000, 1, 1),
      lastDate: DateTime.now().copyWith(year: DateTime.now().year+100),
    );
    if(picked != null){
      provider.updateDate(picked);
      if(context.mounted) {
        CoreUtils.getRunSheets(context);
        CoreUtils.getDailyStatics(context);
      }
    }
  }

}