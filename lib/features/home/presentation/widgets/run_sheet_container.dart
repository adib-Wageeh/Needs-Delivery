import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:needs_delivery/core/res/media_res.dart';
import 'package:needs_delivery/core/utils/app_route_constants.dart';
import 'package:needs_delivery/features/home/domain/entites/run_sheet_entity.dart';
import 'package:needs_delivery/features/home/domain/entites/run_sheet_item_entity.dart';
import 'package:needs_delivery/generated/l10n.dart';

class RunSheetContainer extends StatelessWidget {
  const RunSheetContainer({super.key,required this.runSheetEntity});
  final RunSheetEntity runSheetEntity;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            image: DecorationImage(
                fit: BoxFit.cover,
                image: Image.asset(MediaRes.backgroundImage).image)),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(18),
            onTap: () {
              context.pushNamed(AppRouteConstants.runSheetInvoicesRouteName,
              extra: [runSheetEntity]
              );
            },
            child: ListTile(
              textColor: Colors.white,
              title: Text(runSheetEntity.id.toString()),
              subtitle: Text('${S.of(context).invoices_count}${runSheetEntity.invoicesCount}'),
              trailing: Text(runSheetEntity.date),
            )
          ),
        ),
      ),
    );
  }
}
