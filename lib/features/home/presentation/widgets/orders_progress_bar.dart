import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rounded_progress_bar/flutter_rounded_progress_bar.dart';
import 'package:flutter_rounded_progress_bar/rounded_progress_bar_style.dart';
import 'package:needs_delivery/features/home/presentation/cubits/daily_items_statics/daily_items_statics_cubit.dart';
import 'package:needs_delivery/generated/l10n.dart';
import 'package:needs_delivery/main.dart';

class OrdersProgressBar extends StatelessWidget {
  const OrdersProgressBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DailyItemsStaticsCubit, DailyItemsStaticsState>(
  builder: (context, state) {
    if(state is DailyItemsStaticsDone) {
      return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 4),
      child: Column(
        children: [
          RoundedProgressBar(
              childLeft: (isArabic())?null: Text(state.dailyItemsStaticsEntity.done.toString(),
                  style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
              childRight: (isArabic())? Text(state.dailyItemsStaticsEntity.done.toString(),
                  style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold)):null,
              percent: (state.dailyItemsStaticsEntity.all != 0)?
              (100 * (state.dailyItemsStaticsEntity.done/state.dailyItemsStaticsEntity.all)):0,
              theme: RoundedProgressBarTheme.green),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('${S.of(context).total_delivered} ${state.dailyItemsStaticsEntity.all}')
            ],
          )
        ],
      ),
    );
    }else{
      return const SizedBox.shrink();
    }
  },
);
  }
}