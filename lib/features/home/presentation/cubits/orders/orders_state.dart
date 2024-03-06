part of 'orders_cubit.dart';

@immutable
abstract class OrdersState {
  const OrdersState();
}

class OrdersInitial extends OrdersState {}

class OrdersLoading extends OrdersState {

}

class OrdersLoaded extends OrdersState {
  final List<OrderEntity> orders;
  const OrdersLoaded({required this.orders});
}

class OrdersError extends OrdersState {
  final Failure error;
  const OrdersError({required this.error});
}