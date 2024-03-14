import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:needs_delivery/core/res/colours.dart';
import 'package:needs_delivery/core/utils/app_route_constants.dart';
import 'package:needs_delivery/features/home/domain/entites/order_entity.dart';
import 'package:needs_delivery/features/home/domain/entites/run_sheet_item_entity.dart';
import 'package:needs_delivery/generated/l10n.dart';

var invoiceOrdersGroup = AutoSizeGroup();

class PartialDeliveryScreen extends StatelessWidget {
  const PartialDeliveryScreen({super.key, required this.orders,required this.runSheetItemEntity});

  final List<OrderEntity> orders;
  final RunSheetItemEntity runSheetItemEntity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colours.primaryColor,
          foregroundColor: Colors.white,
          title: Text(S.of(context).partial_button),
        ),
        body: Column(
          children: [
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colours.primaryColor,
                            padding: const EdgeInsets.symmetric(horizontal: 48,vertical: 12)
                          ),
                          onPressed: () {
                            context.pushNamed(
                                AppRouteConstants.selectDamagedAmountRouteName,
                                extra: [
                                  orders,
                                ]);
                          },
                          child: Text(S.of(context).damaged_button)),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colours.primaryColor,
                            padding: const EdgeInsets.symmetric(horizontal: 48,vertical: 12)
                          ),
                          onPressed: () {
                            context.pushNamed(
                                AppRouteConstants.selectReturnedAmountRouteName,
                                extra: [
                                  orders,
                                ]);
                          },
                          child: Text(S.of(context).returned_products_button))
                    ],
                  ),
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 8),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)
                ),
                tileColor: Colors.grey.shade300,
                title: Text(S.of(context).invoice_total),
                subtitle: Text('${runSheetItemEntity.totalInvoice.toStringAsFixed(2)} ${S.of(context).currency}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 60,
              width: double.infinity,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colours.orangeColor,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero)),
                  onPressed: () {

                  },
                  child: Text(
                    S.of(context).number_verification_confirm,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  )),
            )
          ],
        ),
      );
  }
}
