import 'package:flutter/material.dart';
import 'package:needs_delivery/core/res/colours.dart';
import 'package:needs_delivery/generated/l10n.dart';

class NumberInputField extends StatelessWidget {
  const NumberInputField({super.key,required this.controller,required this.text});
  final TextEditingController controller;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 4.0,top: 4,bottom: 4,left: 4),
      child: SizedBox(
        width: 60,
        height: 35,
        child: TextField(
          keyboardType: TextInputType.number,
          controller: controller
          ,decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          label: Text(text),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
                color: Colours.primaryColor,
                width: 0.5
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 8,horizontal: 12),
        ),
        ),
      ),
    );
  }


}
