import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:needs_delivery/core/errors/failure.dart';
import 'package:needs_delivery/features/home/domain/entites/daily_items_statics_entity.dart';
import 'package:needs_delivery/features/home/domain/use_cases/daily_items_statics_usecase.dart';

part 'daily_items_statics_state.dart';

class DailyItemsStaticsCubit extends Cubit<DailyItemsStaticsState> {
  DailyItemsStaticsCubit({
    required DailyItemsStaticsUseCase dailyItemsStaticsUseCase,
}) :
  _dailyItemsStaticsUseCase = dailyItemsStaticsUseCase
  ,super(DailyItemsStaticsInitial());

  final DailyItemsStaticsUseCase _dailyItemsStaticsUseCase;

  void getDailyItemsStatics({required String token,required String lang,required String date})async{
    emit(DailyItemsStaticsLoading());
    final result = await _dailyItemsStaticsUseCase.call(DailyItemsStaticsParams(
        token: token,
        date: date,
        lang: lang));
    result.fold((l) {
      emit(DailyItemsStaticsError(error: l));
    }, (data) async {
      emit(DailyItemsStaticsDone(dailyItemsStaticsEntity: data));
    });
  }


}
