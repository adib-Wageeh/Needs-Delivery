import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:needs_delivery/core/common/app/providers/user_provider.dart';
import 'package:needs_delivery/core/common/widgets/dashboard.dart';
import 'package:needs_delivery/core/services/injection_container.dart';
import 'package:needs_delivery/core/utils/app_route_constants.dart';
import 'package:needs_delivery/features/authentication/presentation/cubits/register/register_cubit.dart';
import 'package:needs_delivery/features/authentication/presentation/cubits/sign_in/sign_in_cubit.dart';
import 'package:needs_delivery/features/authentication/presentation/views/loading_splash.dart';
import 'package:needs_delivery/features/authentication/presentation/views/login_screen.dart';
import 'package:needs_delivery/features/authentication/presentation/views/signup_screen.dart';
import 'package:needs_delivery/features/home/domain/entites/order_entity.dart';
import 'package:needs_delivery/features/home/domain/entites/run_sheet_item_entity.dart';
import 'package:needs_delivery/features/home/presentation/cubits/change_status/change_status_cubit.dart';
import 'package:needs_delivery/features/home/presentation/cubits/damaged_products/damaged_products_cubit.dart';
import 'package:needs_delivery/features/home/presentation/cubits/invoices/invoices_cubit.dart';
import 'package:needs_delivery/features/home/presentation/cubits/orders/orders_cubit.dart';
import 'package:needs_delivery/features/home/presentation/cubits/return_products/return_products_cubit.dart';
import 'package:needs_delivery/features/home/presentation/provider/damaged_products_provider.dart';
import 'package:needs_delivery/features/home/presentation/provider/returned_products_provider.dart';
import 'package:needs_delivery/features/home/presentation/views/invoice_orders_screen.dart';
import 'package:needs_delivery/features/home/presentation/views/partial_delivery_screen.dart';
import 'package:needs_delivery/features/home/presentation/views/select_damaged_amount_screen.dart';
import 'package:needs_delivery/features/home/presentation/views/invoices_screen.dart';
import 'package:needs_delivery/features/home/presentation/views/select_returned_amount_screen.dart';
import 'package:needs_delivery/features/profile/presentation/cubits/update/update_cubit.dart';
import 'package:needs_delivery/features/profile/presentation/providers/edit_profile_provider.dart';
import 'package:needs_delivery/features/profile/presentation/views/my_profile_screen.dart';
import 'package:provider/provider.dart';

part 'app_router_config.main.dart';
