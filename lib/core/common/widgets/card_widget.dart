import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:needs_delivery/core/res/colours.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({required this.title,this.trailingWidget,this.subTitleWidget
    ,this.cardDecoration = false,super.key,this.leadingWidget,this.onTab,
  this.cardColor = Colours.thirdColor
  });
  final Widget title;
  final Widget? subTitleWidget;
  final Widget? trailingWidget;
  final Widget? leadingWidget;
  final bool cardDecoration;
  final VoidCallback? onTab;
  final Color cardColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: (cardDecoration)?EdgeInsets.zero: EdgeInsets.all(6.sp),
      elevation: (cardDecoration)?0:3,
      color: cardColor,
      shadowColor: Colours.primaryColor,
      child: InkWell(
        onTap: onTab,
        child: ListTile(
          title: title,
          leadingAndTrailingTextStyle: TextStyle(
            fontSize: 14.sp,
            color: Colors.black,
            fontWeight: FontWeight.bold
          )
          ,titleTextStyle: TextStyle(
            fontSize: 14.sp,
            color: Colors.black
          ),
          leading: leadingWidget,
          subtitle: subTitleWidget,
          trailing: trailingWidget,
        ),
      ),
    );
  }
}