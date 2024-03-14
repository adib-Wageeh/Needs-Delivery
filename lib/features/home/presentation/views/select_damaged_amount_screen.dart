import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:needs_delivery/core/common/app/providers/locale.dart';
import 'package:needs_delivery/core/common/app/providers/user_provider.dart';
import 'package:needs_delivery/core/enums/exception_types.dart';
import 'package:needs_delivery/core/extensions/context_extension.dart';
import 'package:needs_delivery/core/res/colours.dart';
import 'package:needs_delivery/core/utils/app_route_constants.dart';
import 'package:needs_delivery/features/home/domain/entites/order_entity.dart';
import 'package:needs_delivery/features/home/presentation/cubits/damaged_products/damaged_products_cubit.dart';
import 'package:needs_delivery/features/home/presentation/cubits/return_products/return_products_cubit.dart';
import 'package:needs_delivery/features/home/presentation/provider/damaged_products_provider.dart';
import 'package:needs_delivery/features/home/presentation/views/invoice_orders_screen.dart';
import 'package:needs_delivery/features/home/presentation/widgets/order_quantity_widget.dart';
import 'package:needs_delivery/generated/l10n.dart';
import 'package:provider/provider.dart';

class SelectDamagedAmountScreen extends StatelessWidget {
  const SelectDamagedAmountScreen(
      {super.key,required this.orders});

  final List<OrderEntity> orders;

  @override
  Widget build(BuildContext context) {
    return BlocListener<DamagedProductsCubit,DamagedProductsState>(
      listener: (context,state){
        if(state is DamagedProductsError){
          if (state.error.type == ExceptionType.noInternetConnection ||
              state.error.type == ExceptionType.receiveTimeout ||
              state.error.type == ExceptionType.sendTimeout ||
              state.error.type == ExceptionType.internalServerError ||
              state.error.type == ExceptionType.connectionTimeout){
            CherryToast.error(
              title: Text(S.of(context).no_connection_error),).show(context);
          }else if(state.error.type == ExceptionType.noReturnProducts){
            CherryToast.error(
              title: Text(S.of(context).no_return_products),).show(context);
          }else{
            CherryToast.error(
              title: Text(state.error.errorMessage),).show(context);
          }
        }else if(state is ReturnProductsDone){
          GoRouter.of(context).goNamed(AppRouteConstants.runSheetInvoicesRouteName);
        }
      },
      child: Consumer<DamagedAmountProvider>(
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
                    S.of(context).partial_delivery_damaged_quantity_title,
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
                        amountController: provider.getAmountTextFieldsController()[index],
                        unitController: provider.getUnitTextFieldsController()[index],
                      );
                    },
                    itemCount: orders.length,
                  ),
                ),
                SizedBox(
                  child: TextField(
                    controller: provider.reason,
                    decoration: InputDecoration(
                        filled: true,
                        label: Text(S.of(context).reason),
                        fillColor: Colors.grey.shade300,
                        prefixIcon: const Icon(Icons.text_snippet_rounded)
                    ),
                  ),
                ),
                BlocBuilder<DamagedProductsCubit,DamagedProductsState>(
                    builder: (context,state) {
                      if(state is DamagedProductsLoading){
                        return const Center(
                          child: CircularProgressIndicator.adaptive(),
                        );
                      }
                      return SizedBox(
                          height: 60,
                          width: double.infinity,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colours.orangeColor,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero)),
                              onPressed: () {
                                final token = context.read<UserProvider>().user!.token;
                                final lang = context.read<LocaleProvider>().getLocale!.languageCode;
                                if(provider.checkIfAmountsIsValid()) {
                                  if(provider.checkIfUnitsIsValid()) {
                                    if(provider.reason.text.trim().isEmpty){
                                      CherryToast.warning(
                                        title: Text(S.of(context).reason_error),
                                      ).show(context);
                                    }else {
                                      BlocProvider.of<ReturnProductsCubit>(context,listen: false)
                                          .returnOrder(token: token!, lang: lang, orders: provider.getProducts,
                                          invoiceId: provider.getProducts.first.invoiceId.toString(),
                                          reason: provider.reason.text.trim(),
                                          amounts: provider.getAmountTextFieldsController(),
                                          units: provider.getAmountTextFieldsController());
                                    }
                                  }else{
                                    CherryToast.warning(
                                      title: Text(S.of(context).invalid_unit_title),
                                      description: Text(S.of(context).invalid_unit_sub_title),
                                    ).show(context);
                                  }
                                }else{
                                  CherryToast.warning(
                                    title: Text(S.of(context).invalid_quantity_title),
                                    description: Text(S.of(context).invalid_quantity_sub_title),
                                  ).show(context);
                                }

                              },
                              child: Text(
                                S.of(context).number_verification_confirm,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              )));
                    }
                )
              ],
            ),
          );
        }
      ),
    );
  }
}
