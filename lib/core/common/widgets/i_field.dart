import 'package:flutter/material.dart';
import 'package:needs_delivery/core/res/colours.dart';
import 'package:needs_delivery/generated/l10n.dart';


class IField extends StatelessWidget {
  const IField({
    required this.controller,
    this.filled = false,
    this.obscureText = false,
    this.readOnly = false,
    super.key,
    this.validator,
    this.fillColour,
    this.prefixIcon,
    this.hintText,
    this.keyboardType,
    this.hintStyle,
    this.required = true,
    this.overrideValidator = false,
    this.linesNumber = 1,
    this.onTab,
    this.autoCorrect = true,
    this.enableSuggestions = true,
    this.borderRadius
  });

  final String? Function(String?)? validator;
  final TextEditingController controller;
  final bool filled;
  final Color? fillColour;
  final bool obscureText;
  final bool readOnly;
  final Widget? prefixIcon;
  final String? hintText;
  final TextInputType? keyboardType;
  final bool overrideValidator;
  final TextStyle? hintStyle;
  final bool required;
  final bool enableSuggestions;
  final bool autoCorrect;
  final int linesNumber;
  final VoidCallback? onTab;
  final double? borderRadius;
  
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTab,
      controller: controller,
      maxLines: linesNumber,
      validator: overrideValidator
          ? validator
          : (value) {
        if (value == null || value.isEmpty) {
          return '$hintText ${S.of(context).empty_field}';
        }
        return validator?.call(value);
      },
      onTapOutside: (_) {
        FocusScope.of(context).unfocus();
      },
      keyboardType: keyboardType,
      obscureText: obscureText,
      readOnly: readOnly,
      enableSuggestions: enableSuggestions,
      autocorrect: autoCorrect,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular((borderRadius == null)?45:borderRadius!),
          // borderSide: const BorderSide(
          //   color: Colours.secondaryColor
          //
          // )
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular((borderRadius == null)?45:borderRadius!),
          // borderSide: const BorderSide(
          //   color: Colours.secondaryColor
          // ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular((borderRadius == null)?45:borderRadius!),
          // borderSide: const BorderSide(
          //   color: Colours.primaryColor
          // ),
        ),
        isCollapsed: true,
        contentPadding: EdgeInsets.zero,
        filled: true,

        fillColor: Colors.white,
        prefixIcon: prefixIcon,
        prefixIconColor: Colours.primaryColor,
        hintText: (hintText != null)?(required)? '$hintText':hintText:null,
      ),
      textAlignVertical: TextAlignVertical.center,
    );
  }
}
