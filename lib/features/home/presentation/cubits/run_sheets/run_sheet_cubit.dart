import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:needs_delivery/core/errors/failure.dart';
import 'package:needs_delivery/features/home/domain/entites/run_sheet_entity.dart';
import 'package:needs_delivery/features/home/domain/use_cases/get_all_run_sheets_usecase.dart';
import 'package:needs_delivery/features/home/domain/use_cases/get_run_sheets_by_date_usecase.dart';

part 'run_sheet_state.dart';

class RunSheetCubit extends Cubit<RunSheetState> {
  RunSheetCubit({
    required GetAllRunSheetsUseCase getAllRunSheetsUseCase,
    required GetRunSheetsByDateUseCase getRunSheetsByDateUseCase
}) :
  _getAllRunSheetsUseCase = getAllRunSheetsUseCase,
  _getRunSheetsByDateUseCase = getRunSheetsByDateUseCase
  ,super(RunSheetInitial());
  final GetAllRunSheetsUseCase _getAllRunSheetsUseCase;
  final GetRunSheetsByDateUseCase _getRunSheetsByDateUseCase;

  void getAllRunSheets({required String token,required String lang})async{
    emit(RunSheetLoading());
    final result = await _getAllRunSheetsUseCase.call(GetAllRunSheetsParams(
        token: token,
        lang: lang));
    result.fold((l) {
      emit(RunSheetsError(error: l));
    }, (runSheets) async {
      emit(RunSheetsLoaded(runSheets: runSheets));
    });
  }

  void getRunSheetsByDate({required String token,required String lang,required String date})async{
    emit(RunSheetLoading());
    DateTime dateTime = DateFormat('yyyy-MM-dd').parse(date);
    print(DateFormat('yyyy-MM-dd','en_US').format(dateTime));
    final result = await _getRunSheetsByDateUseCase.call(GetRunSheetsByDateParams(
        token: token,
        date: DateFormat('yyyy-MM-dd','en_US').format(dateTime),
        lang: lang));
    result.fold((l) {
      emit(RunSheetsError(error: l));
    }, (runSheets) async {
      emit(RunSheetsLoaded(runSheets: runSheets));
    });
  }

}
