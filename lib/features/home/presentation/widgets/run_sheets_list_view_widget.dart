import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:needs_delivery/core/common/widgets/list_view_shimmer.dart';
import 'package:needs_delivery/core/common/widgets/no_internet_connection.dart';
import 'package:needs_delivery/core/common/widgets/not_found_text.dart';
import 'package:needs_delivery/core/enums/exception_types.dart';
import 'package:needs_delivery/core/utils/core_utils.dart';
import 'package:needs_delivery/features/home/presentation/cubits/run_sheets/run_sheet_cubit.dart';
import 'package:needs_delivery/features/home/presentation/widgets/run_sheet_container.dart';

class RunSheetsListWidget extends StatelessWidget {
  const RunSheetsListWidget({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RunSheetCubit, RunSheetState>(
        builder: (context, state) {
          if (state is RunSheetsLoaded) {
            return ListView.separated(
                itemBuilder: (context, index) {
                  return RunSheetContainer(runSheetEntity: state.runSheets[index],);
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 4,);
                },
                itemCount: state.runSheets.length);
          } else if (state is RunSheetsError) {
            if (state.error.type == ExceptionType.noInternetConnection ||
                state.error.type == ExceptionType.receiveTimeout ||
                state.error.type == ExceptionType.sendTimeout ||
                state.error.type == ExceptionType.connectionTimeout) {
              return NoInternetConnection(
                onPressed: () {
                  CoreUtils.getRunSheets(context);
                  CoreUtils.getDailyStatics(context);
                },
                showTitle: true,
              );
            } else {
              return NotFoundText(
                text: state.error.errorMessage,
              );
            }
          } else {
            return const ListViewShimmer();
          }
        },
        listener: (context, state) {});
  }
}
