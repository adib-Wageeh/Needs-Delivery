import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:needs_delivery/core/common/app/providers/locale.dart';
import 'package:needs_delivery/core/common/app/providers/user_provider.dart';
import 'package:needs_delivery/core/common/widgets/list_view_shimmer.dart';
import 'package:needs_delivery/core/common/widgets/no_internet_connection.dart';
import 'package:needs_delivery/core/common/widgets/not_found_text.dart';
import 'package:needs_delivery/core/enums/exception_types.dart';
import 'package:needs_delivery/core/res/colours.dart';
import 'package:needs_delivery/core/utils/app_route_constants.dart';
import 'package:needs_delivery/core/utils/core_utils.dart';
import 'package:needs_delivery/features/home/domain/entites/run_sheet_item_entity.dart';
import 'package:needs_delivery/features/home/presentation/cubits/orders/orders_cubit.dart';
import 'package:needs_delivery/features/home/presentation/widgets/invoice_order_widget.dart';
import 'package:needs_delivery/generated/l10n.dart';

var invoiceOrdersGroup = AutoSizeGroup();

class InvoiceOrdersScreen extends StatefulWidget {
  const InvoiceOrdersScreen({super.key, required this.runSheetItemEntity});

  final RunSheetItemEntity runSheetItemEntity;

  @override
  State<InvoiceOrdersScreen> createState() => _InvoiceOrdersScreenState();
}

class _InvoiceOrdersScreenState extends State<InvoiceOrdersScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getOrders();
    });
  }

  void getOrders() {
    final token = context.read<UserProvider>().user!.token;
    final lang = context.read<LocaleProvider>().getLocale!.languageCode;
    BlocProvider.of<OrdersCubit>(context, listen: false).getInvoiceOrders(
        invoiceId: widget.runSheetItemEntity.invoiceId.toString(),
        token: token!,
        lang: lang);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colours.primaryColor,
        foregroundColor: Colors.white,
        title: Text(
          widget.runSheetItemEntity.invoiceId.toString(),
          style: const TextStyle(fontSize: 16),
        ),
      ),
      body: BlocBuilder<OrdersCubit, OrdersState>(builder: (context, state) {
        if (state is OrdersLoaded) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return InvoiceOrderWidget(
                        order: state.orders[index],
                        invoiceOrdersGroup: invoiceOrdersGroup);
                  },
                  shrinkWrap: true,
                  itemCount: state.orders.length,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  tileColor: Colors.grey.shade300,
                  title: Text(
                    S.of(context).invoice_total,
                    style: const TextStyle(fontSize: 14),
                  ),
                  trailing: Text(
                    '${widget.runSheetItemEntity.totalInvoice.toStringAsFixed(2)} ${S.of(context).currency}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
              ),
              Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.grey.shade200),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colours.orangeColor,
                            padding: const EdgeInsets.symmetric(horizontal: 6)),
                        onPressed: () async {
                          int? result =
                              await CoreUtils.showInvoiceConfirmationDialog(
                                  context,
                                  S.of(context).full_delivery_confirmation);
                          if (result != null && context.mounted) {
                            final token =
                                context.read<UserProvider>().user!.token;
                            final lang = context
                                .read<LocaleProvider>()
                                .getLocale!
                                .languageCode;
                            // BlocProvider.of<ChangeStatusCubit>(context,listen: false)
                            //     .changeOrderStatus(token: token!, lang: lang,
                            //     status: 'Delivered', invoiceId: widget.invoiceId);
                          }
                        },
                        child: Text(S.of(context).full_delivery_button)),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colours.orangeColor,
                            padding: const EdgeInsets.symmetric(horizontal: 6)),
                        onPressed: () {
                          context.pushNamed(
                              AppRouteConstants.partialDeliveryRouteName,
                              extra: [state.orders,widget.runSheetItemEntity]);
                        },
                        child: Text(S.of(context).partial_button)),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colours.orangeColor,
                            padding: const EdgeInsets.symmetric(horizontal: 6)),
                        onPressed: () async {
                          int? result =
                              await CoreUtils.showInvoiceConfirmationDialog(
                                  context,
                                  S.of(context).refused_delivery_confirmation);
                          if (result != null && context.mounted) {
                            final token =
                                context.read<UserProvider>().user!.token;
                            final lang = context
                                .read<LocaleProvider>()
                                .getLocale!
                                .languageCode;
                            // BlocProvider.of<ChangeStatusCubit>(context,listen: false)
                            //     .changeOrderStatus(token: token!, lang: lang,
                            //     status: 'Refused', invoiceId: widget.invoiceId);
                          }
                        },
                        child: Text(S.of(context).refused_button))
                  ],
                ),
              )
            ],
          );
        } else if (state is OrdersError) {
          if (state.error.type == ExceptionType.noInternetConnection ||
              state.error.type == ExceptionType.receiveTimeout ||
              state.error.type == ExceptionType.sendTimeout ||
              state.error.type == ExceptionType.connectionTimeout) {
            return NoInternetConnection(
              onPressed: () => getOrders(),
              showTitle: true,
            );
          } else {
            return NotFoundText(
              text: state.error.errorMessage,
            );
          }
        } else {
          return const ListViewShimmer();
        }
      }),
    );
  }
}
