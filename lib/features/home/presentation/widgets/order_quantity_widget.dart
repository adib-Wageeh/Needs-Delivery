import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:needs_delivery/core/res/media_res.dart';
import 'package:needs_delivery/features/home/domain/entites/order_entity.dart';
import 'package:needs_delivery/features/home/presentation/widgets/number_input_field.dart';
import 'package:needs_delivery/generated/l10n.dart';
import 'package:needs_delivery/main.dart';

class OrderQuantityWidget extends StatefulWidget {
  const OrderQuantityWidget({
    super.key,
    required this.order,
    required this.invoiceOrdersGroup,
    required this.amountController,
    required this.unitController
  });

  final OrderEntity order;
  final AutoSizeGroup invoiceOrdersGroup;
  final TextEditingController amountController;
  final TextEditingController unitController;

  @override
  State<OrderQuantityWidget> createState() => _OrderQuantityWidgetState();
}

class _OrderQuantityWidgetState extends State<OrderQuantityWidget> {


  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            boxShadow: MediaRes.containerShadow,
            borderRadius: BorderRadius.circular(6)),
        child:
        LayoutBuilder(
          builder: (context,constraints) {
            return Row(
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
                    imageUrl: widget.order.image!,
                    width: constraints.maxWidth*0.25,
                    height: 100,
                    fit: BoxFit.cover,
                    placeholder: (context, _) {
                      return Lottie.asset(MediaRes.loadingLottie);
                    },
                    errorWidget: (context,_,__){
                      return Lottie.asset(MediaRes.loadingLottie);
                    },
                  ),
                ),
                SizedBox(
                  width: constraints.maxWidth*0.02,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 40,
                      width: constraints.maxWidth*0.73,
                      child: Align(
                        alignment: (isArabic())?Alignment.centerRight:Alignment.centerLeft,
                        child: AutoSizeText(
                          maxLines: 2,
                          minFontSize: 8,
                          maxFontSize: 16,
                          overflow: TextOverflow.ellipsis,
                          widget.order.productName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        NumberInputField(controller: widget.unitController,
                          text: S.of(context).order_units,
                        ),
                        const SizedBox(width: 8,),
                        NumberInputField(controller: widget.amountController,
                          text: S.of(context).order_amount,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}

