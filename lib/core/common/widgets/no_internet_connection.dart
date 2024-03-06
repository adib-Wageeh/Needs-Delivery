import 'package:flutter/material.dart';
import 'package:needs_delivery/core/common/widgets/not_found_text.dart';
import 'package:needs_delivery/core/res/colours.dart';
import 'package:needs_delivery/generated/l10n.dart';

class NoInternetConnection extends StatelessWidget {
  const NoInternetConnection({
    super.key,
    required this.onPressed,
    this.showTitle = true
  });
  final VoidCallback onPressed;
  final bool showTitle;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        if(showTitle)
          NotFoundText(text: S.of(context).no_internet_connection),
        Center(
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  foregroundColor: Colours.primaryColor,
                  backgroundColor: Colors.white,)
              ,onPressed: onPressed, child: Text(S.of(context).try_again,style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500
          ),)),
        )
      ],
    );
  }
}