import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:needs_delivery/core/res/colours.dart';
import 'package:needs_delivery/core/res/media_res.dart';
import 'package:needs_delivery/core/utils/app_route_constants.dart';
import 'package:needs_delivery/core/utils/core_utils.dart';
import 'package:needs_delivery/features/home/domain/entites/run_sheet_item_entity.dart';
import 'package:needs_delivery/generated/l10n.dart';

class InvoiceContainerWidget extends StatelessWidget {
  const InvoiceContainerWidget({super.key, required this.runSheetItemEntity});

  final RunSheetItemEntity runSheetItemEntity;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 6,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Container(
              height: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: MediaRes.containerShadow,
                  color: Colors.grey.shade200),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    context.pushNamed(AppRouteConstants.invoiceOrdersRouteName,
                        extra: [runSheetItemEntity]);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                runSheetItemEntity.merchantName,
                                style:
                                    const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                runSheetItemEntity.address,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                '${runSheetItemEntity.totalInvoice.toStringAsFixed(2)} ${S.of(context).currency}',
                                maxLines: 1,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colours.primaryColor,
                                  foregroundColor: Colors.white),
                              onPressed: () async {
                                final sms = Uri(
                                    scheme: 'tel',
                                    path: runSheetItemEntity.mobile);
                                await CoreUtils.launchURL(sms);
                              },
                              icon: const Icon(Icons.phone),
                            ),
                            IconButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colours.primaryColor,
                                    foregroundColor: Colors.white),
                                onPressed: () async {
                                  String mapsUrl =
                                      'https://www.google.com/maps/dir/?api=1&destination=${runSheetItemEntity.lat},${runSheetItemEntity.long}';
                                  Uri uri = Uri.parse(mapsUrl);
                                  await CoreUtils.launchURL(uri);
                                },
                                icon: const Icon(Icons.directions)),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )),
        ),
        const SizedBox(
          height: 6,
        ),
      ],
    );
  }
}
