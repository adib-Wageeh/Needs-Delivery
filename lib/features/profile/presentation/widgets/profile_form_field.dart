import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:needs_delivery/core/common/widgets/i_field.dart';

class ProfileFormField extends StatelessWidget {
  const ProfileFormField({
    required this.controller,
    required this.fieldTitle,
    required this.icon,
    this.hintText,
    this.readOnly,
    this.overrideValidator = false,
    this.validator,
    this.obscure = false,
    this.enableSuggestions = true,
    this.autoCorrect = true,
    this.border,
    this.linesNumber = 1,
    super.key,});
  final String fieldTitle;
  final TextEditingController controller;
  final String? hintText;
  final bool? readOnly;
  final IconData icon;
  final String? Function(String?)? validator;
  final bool overrideValidator;
  final bool obscure;
  final bool enableSuggestions;
  final bool autoCorrect;
  final int linesNumber;
  final double? border;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(padding:
         EdgeInsets.only(left: 10.w,),
          child: AutoSizeText(
            minFontSize: 14,
            maxFontSize: 24,
            fieldTitle
          ,style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
            ),
          ),
        ),
        SizedBox(
          height: 6.h,
        ),
        IField(controller: controller,
        hintText: hintText,
          enableSuggestions: enableSuggestions,
          autoCorrect: autoCorrect,
          overrideValidator: overrideValidator,
          validator: validator,
          prefixIcon: Icon(icon),
          obscureText: obscure,
          readOnly: readOnly??false,
          linesNumber: linesNumber,
          borderRadius: border,
        ),
         SizedBox(
          height: 14.h,
        ),
      ],
    );
  }
}
