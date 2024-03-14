part of 'app_router_config.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  static GoRouter returnRouter() {
    GoRouter router = GoRouter(routes: [
      GoRoute(
        name: AppRouteConstants.loadingRouteName,
        path: '/',
        builder: (context, state) {
          return BlocProvider(
            create: (_) => sl<SignInCubit>(),
            child: const LoadingSplash(),
          );
        },
      ),
      GoRoute(
          name: AppRouteConstants.dashBoardRouteName,
          path: '/dashBoard',
          builder: (context, state) {
            return const DashBoard();
          },
          routes: [
            GoRoute(
              name: AppRouteConstants.profileRouteName,
              path: 'profile',
              builder: (context, state) {
                final location =
                    Provider.of<UserProvider>(context, listen: false).address;
                final user =
                    Provider.of<UserProvider>(context, listen: false).user;
                return ChangeNotifierProvider(
                  create: (_) => EditProfileProvider()
                    ..initControllers(user!, location ?? ''),
                  child: MultiBlocProvider(providers: [
                    BlocProvider(create: (context) => sl<RegisterCubit>()),
                    BlocProvider(create: (context) => sl<UpdateCubit>()),
                  ], child: const MyProfileScreen()),
                );
              },
            ),
            GoRoute(
              name: AppRouteConstants.invoiceOrdersRouteName,
              path: 'invoiceOrders',
              builder: (context, state) {
                final invoice = (state.extra as List)[0];
                return MultiBlocProvider(
                    providers: [
                      BlocProvider(create: (_) => sl<OrdersCubit>()),
                      BlocProvider(create: (_) => sl<ChangeStatusCubit>()),
                    ],
                    child: InvoiceOrdersScreen(
                      runSheetItemEntity: invoice,
                    ));
              },
            ),
            GoRoute(
              name: AppRouteConstants.partialDeliveryRouteName,
              path: 'partialDelivery',
              builder: (context, state) {
                final products = (state.extra as List)[0];
                final invoice = (state.extra as List)[1];
                return PartialDeliveryScreen(
                  orders: products as List<OrderEntity>,
                  runSheetItemEntity: invoice,
                );
              },
            ),
            GoRoute(
              name: AppRouteConstants.selectDamagedAmountRouteName,
              path: 'selectDamagedAmount',
              builder: (context, state) {
                final products = (state.extra as List)[0];
                return BlocProvider(
                  create: (_)=> sl<DamagedProductsCubit>(),
                  child: ChangeNotifierProvider(
                    create: (_) => DamagedAmountProvider(products: products),
                    child: SelectDamagedAmountScreen(
                      orders: products,
                    ),
                  ),
                );
              },
            ),
            GoRoute(
              name: AppRouteConstants.selectReturnedAmountRouteName,
              path: 'selectReturnedAmount',
              builder: (context, state) {
                final products = (state.extra as List)[0];
                return BlocProvider(
                  create: (_)=>sl<ReturnProductsCubit>(),
                  child: ChangeNotifierProvider(
                    create: (context) =>
                        ReturnedAmountProvider(products: products),
                    child: SelectReturnedAmountScreen(
                      orders: products,
                    ),
                  ),
                );
              },
            ),
          ]),
      GoRoute(
        name: AppRouteConstants.signInRouteName,
        path: '/login',
        builder: (context, state) {
          return BlocProvider(
            create: (context) => sl<SignInCubit>(),
            child: const LoginScreen(),
          );
        },
      ),
      GoRoute(
        name: AppRouteConstants.signUpRouteName,
        path: '/signUp',
        builder: (context, state) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => sl<RegisterCubit>(),
              ),
            ],
            child: const SignUpScreen(),
          );
        },
      ),
      GoRoute(
        name: AppRouteConstants.runSheetInvoicesRouteName,
        path: '/runSheetInvoices',
        builder: (context, state) {
          final runSheet = (state.extra as List)[0];
          return BlocProvider(
            create: (context) => sl<InvoicesCubit>(),
            child: RunSheetInvoicesScreen(
              runSheetEntity: runSheet,
            ),
          );
        },
      ),
    ]);
    return router;
  }
}
