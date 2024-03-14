import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:needs_delivery/core/common/app/providers/location_provider.dart';
import 'package:needs_delivery/generated/l10n.dart';
import 'package:needs_delivery/main.dart';
import 'package:provider/provider.dart';

class ConnectionStatusWidget extends StatelessWidget {
  const ConnectionStatusWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<LocationProvider>(builder: (context, provider, _) {
      bool status = (provider.getButtonPressedState &&
          provider.getGpsStatus &&
          provider.getConnectionStatus);
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
          alignment:
              (isArabic()) ? Alignment.centerRight : Alignment.centerLeft,
          child: ElevatedButton.icon(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: (status) ? Colors.green : Colors.red,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24)),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20)),
              icon:
                  Icon((status) ? EvaIcons.wifi : EvaIcons.alertCircleOutline,
                  color: Colors.white,),
              label: Text(
                (status) ? S.of(context).online : S.of(context).offline,
                style: const TextStyle(color: Colors.white),
              )),
        ),
      );
    });
  }
}
