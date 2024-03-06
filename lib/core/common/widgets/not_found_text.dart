import 'package:flutter/material.dart';
import 'package:needs_delivery/core/extensions/context_extension.dart';

class NotFoundText extends StatelessWidget {
  const NotFoundText({required this.text, super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(text,
          textAlign: TextAlign.center,
          style: context.getTheme.textTheme.headlineMedium!
              .copyWith(
            color: Colors.grey.withOpacity(0.5),
            fontWeight: FontWeight.w600,
            fontSize: 22
            ,),
        ),
      ),
    );
  }
}
