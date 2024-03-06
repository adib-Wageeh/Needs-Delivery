part of 'daily_items_statics_cubit.dart';

@immutable
abstract class DailyItemsStaticsState {
  const DailyItemsStaticsState();
}

class DailyItemsStaticsInitial extends DailyItemsStaticsState {}

class DailyItemsStaticsLoading extends DailyItemsStaticsState {

}

class DailyItemsStaticsDone extends DailyItemsStaticsState {
  final DailyItemsStaticsEntity dailyItemsStaticsEntity;
  const DailyItemsStaticsDone({required this.dailyItemsStaticsEntity});
}

class DailyItemsStaticsError extends DailyItemsStaticsState {
  final Failure error;
  const DailyItemsStaticsError({required this.error});
}