part of 'change_status_cubit.dart';

@immutable
abstract class ChangeStatusState {
  const ChangeStatusState();
}

class ChangeStatusInitial extends ChangeStatusState {}

class ChangeStatusLoading extends ChangeStatusState {

}

class ChangeStatusDone extends ChangeStatusState {
  final String type;
  final List<OrderEntity> orders;
  const ChangeStatusDone({required this.type,required this.orders});
}


class ChangeStatusError extends ChangeStatusState {
  final Failure error;
  const ChangeStatusError({required this.error});
}