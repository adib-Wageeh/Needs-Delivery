import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:needs_delivery/core/res/media_res.dart';
import 'package:needs_delivery/features/home/domain/entites/order_entity.dart';
import 'package:needs_delivery/generated/l10n.dart';
import 'package:needs_delivery/main.dart';

class InvoiceOrderWidget extends StatelessWidget {
  const InvoiceOrderWidget({
    super.key,
    required this.order,
    required this.invoiceOrdersGroup,
  });

  final OrderEntity order;
  final AutoSizeGroup invoiceOrdersGroup;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            boxShadow: MediaRes.containerShadow,
            borderRadius: BorderRadius.circular(6)),
        child: Material(
          color: Colors.transparent,
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomRight: (isArabic())
                      ? const Radius.circular(6)
                      : const Radius.circular(0),
                  topRight: (isArabic())
                      ? const Radius.circular(6)
                      : const Radius.circular(0),
                  bottomLeft: (isArabic())
                      ? const Radius.circular(0)
                      : const Radius.circular(6),
                  topLeft: (isArabic())
                      ? const Radius.circular(0)
                      : const Radius.circular(6),
                ),
                child: CachedNetworkImage(
                  imageUrl: order.image!,
                  width: 100,
                  height: 80,
                  fit: BoxFit.cover,
                  placeholder: (context, _) {
                    return Lottie.asset(MediaRes.loadingLottie);
                  },
                  errorWidget: (context, _, __) {
                    return Lottie.asset(MediaRes.loadingLottie);
                  },
                ),
              ),
              const SizedBox(
                width: 4,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Align(
                          alignment: (isArabic())
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Text(
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            order.productName,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Text(
                              order.quantity.toString(),
                              style: const TextStyle(
                                  fontSize: 14),
                            ),
                            const Text(' X ',
                              style: TextStyle(
                                  fontSize: 14),),
                            Text(order.productPrice.toString(),
                              style: const TextStyle(
                                  fontSize: 14),),
                            Text(' ${S.of(context).currency}',
                              style: const TextStyle(
                                  fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                order.totalProduct.toString(),
                style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 14),
              ),
              Text(
                ' ${S.of(context).currency}',
                style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 14),
              ),
              const SizedBox(
                width: 8,
              )
            ],
          ),
        ),
      ),
    );
  }
}
