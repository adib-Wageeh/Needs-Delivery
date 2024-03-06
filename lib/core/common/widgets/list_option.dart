
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:needs_delivery/core/res/colours.dart';
import 'package:needs_delivery/core/res/fonts.dart';

class ListOption extends StatelessWidget {
  const ListOption({
    super.key,
    required this.onTab,
    required this.title,
    required this.icon
  });
  final VoidCallback onTab;
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 4),
        child: InkWell(
          onTap: onTab,
          borderRadius: BorderRadius.circular(14),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colours.primaryColor,width: 0.5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FittedBox(
                  child: Icon(icon,color: Colours.primaryColor,
                    size: 22.sp,
                  ),
                ),
                const SizedBox(width: 30),
                AutoSizeText(
                    minFontSize: 16,
                    maxFontSize: 24
                ,title,style: Fonts.font14.copyWith(
                    color: Colours.primaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp
                ),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}