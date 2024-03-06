import 'package:flutter/material.dart';
import 'package:needs_delivery/core/extensions/context_extension.dart';
import 'package:needs_delivery/core/res/colours.dart';
import 'package:needs_delivery/features/home/domain/entites/order_entity.dart';
import 'package:needs_delivery/features/home/presentation/provider/returned_products_provider.dart';
import 'package:needs_delivery/features/home/presentation/views/invoice_orders_screen.dart';
import 'package:needs_delivery/features/home/presentation/widgets/order_quantity_widget.dart';
import 'package:needs_delivery/generated/l10n.dart';
import 'package:provider/provider.dart';

class SelectReturnedAmountScreen extends StatelessWidget {
  const SelectReturnedAmountScreen(
      {super.key,required this.orders});

  final List<OrderEntity> orders;

  @override
  Widget build(BuildContext context) {
    return Consumer<ReturnedAmountProvider>(
      builder: (context,provider,_) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              S.of(context).damaged_button,
            ),
            backgroundColor: Colours.primaryColor,
            foregroundColor: Colors.white,
          ),
          body: Column(
            children: [
              Container(
                width: context.width,
                color: Colors.grey.shade200,
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
                child: Text(
                  S.of(context).partial_delivery_returned_quantity_title,
                  style: const TextStyle(
                    color: Colours.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return OrderQuantityWidget(
                      invoiceOrdersGroup: invoiceOrdersGroup,
                      order: orders[index],
                      amountController: provider.getAmountTextFieldController(index),
                      unitController: provider.getUnitTextFieldController(index),
                    );
                  },
                  itemCount: orders.length,
                ),
              ),
              SizedBox(
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    label: Text(S.of(context).reason),
                    fillColor: Colors.grey.shade300,
                    prefixIcon: const Icon(Icons.text_snippet_rounded)
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
                      )))
            ],
          ),
        );
      }
    );
  }
}
