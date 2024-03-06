import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:needs_delivery/core/common/app/providers/locale.dart';
import 'package:needs_delivery/core/common/app/providers/user_provider.dart';
import 'package:needs_delivery/core/common/widgets/no_internet_connection.dart';
import 'package:needs_delivery/core/common/widgets/not_found_text.dart';
import 'package:needs_delivery/core/enums/exception_types.dart';
import 'package:needs_delivery/core/res/colours.dart';
import 'package:needs_delivery/core/utils/app_route_constants.dart';
import 'package:needs_delivery/core/utils/core_utils.dart';
import 'package:needs_delivery/features/home/domain/entites/order_entity.dart';
import 'package:needs_delivery/features/home/presentation/cubits/orders/orders_cubit.dart';
import 'package:needs_delivery/features/home/presentation/widgets/invoice_order_widget.dart';
import 'package:needs_delivery/generated/l10n.dart';

var invoiceOrdersGroup = AutoSizeGroup();

List<OrderEntity> orders = [
  OrderEntity(
    id: 1,
    invoiceId: 1,
    units: 3,
    totalProduct: 200,
    amount: 5,
    productPrice: 58,
    image: "https://needs.ws/uploads/merchants/51_puKnZOiSSmTMXTD.jpeg",
    productName: 'Nescafe 2*1 18 grams',
    productId: 123,
  ),
  OrderEntity(
    id: 1,
    invoiceId: 1,
    units: 3,
    totalProduct: 200,
    amount: 5,
    productPrice: 58,
    image: "https://needs.ws/uploads/merchants/51_puKnZOiSSmTMXTD.jpeg",
    productName: 'Nescafe 2*1 18 grams',
    productId: 123,
  ),
  OrderEntity(
    id: 1,
    invoiceId: 1,
    units: 3,
    totalProduct: 200,
    amount: 5,
    productPrice: 58,
    image: "https://needs.ws/uploads/merchants/51_puKnZOiSSmTMXTD.jpeg",
    productName: 'Nescafe 2*1 18 grams',
    productId: 123,
  ),
];

class InvoiceOrdersScreen extends StatefulWidget {
  const InvoiceOrdersScreen({super.key, required this.invoiceId});

  final String invoiceId;

  @override
  State<InvoiceOrdersScreen> createState() => _InvoiceOrdersScreenState();
}

class _InvoiceOrdersScreenState extends State<InvoiceOrdersScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // getOrders();
    });
  }

  void getOrders() {
    final token = context.read<UserProvider>().user!.token;
    final lang = context.read<LocaleProvider>().getLocale!.languageCode;
    BlocProvider.of<OrdersCubit>(context, listen: false).getInvoiceOrders(
        invoiceId: widget.invoiceId, token: token!, lang: lang);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colours.primaryColor,
        foregroundColor: Colors.white,
        title: const Text('Order number'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child:
              BlocBuilder<OrdersCubit, OrdersState>(builder: (context, state) {
            if (state is OrdersLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return InvoiceOrderWidget(
                      order: orders[index],
                      invoiceOrdersGroup: invoiceOrdersGroup);
                },
                shrinkWrap: true,
                itemCount: orders.length,
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
              // return const ListViewShimmer();
              return ListView.builder(
                itemBuilder: (context, index) {
                  return InvoiceOrderWidget(
                      order: orders[index],
                      invoiceOrdersGroup: invoiceOrdersGroup);
                },
                shrinkWrap: true,
                itemCount: orders.length,
              );
            }
          })),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 8),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16)
              ),
              tileColor: Colors.grey.shade300,
              title: Text(S.of(context).invoice_total),
              subtitle: Text('100 ${S.of(context).currency}',
              style: const TextStyle(
                fontWeight: FontWeight.bold
              ),
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
                    onPressed: () async{
                     int? result = await CoreUtils.showInvoiceConfirmationDialog
                       (context,S.of(context).full_delivery_confirmation);
                     if(result != null && context.mounted){
                       final token = context.read<UserProvider>().user!.token;
                       final lang = context.read<LocaleProvider>().getLocale!.languageCode;
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
                          extra: [orders]);
                    },
                    child: Text(S.of(context).partial_button)),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colours.orangeColor,
                        padding: const EdgeInsets.symmetric(horizontal: 6)),
                    onPressed: () async{
                      int? result  = await CoreUtils.showInvoiceConfirmationDialog
                        (context,S.of(context).refused_delivery_confirmation);
                      if(result != null && context.mounted){
                        final token = context.read<UserProvider>().user!.token;
                        final lang = context.read<LocaleProvider>().getLocale!.languageCode;
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
      ),
    );
  }
}
