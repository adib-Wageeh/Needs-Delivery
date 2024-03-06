part of 'change_status_cubit.dart';

@immutable
abstract class ChangeStatusState {
  const ChangeStatusState();
}

class ChangeStatusInitial extends ChangeStatusState {}

class ChangeStatusLoading extends ChangeStatusState {

}

class ChangeStatusDone extends ChangeStatusState {
  const ChangeStatusDone();
}


class ChangeStatusError extends ChangeStatusState {
  final Failure error;
  const ChangeStatusError({required this.error});
}