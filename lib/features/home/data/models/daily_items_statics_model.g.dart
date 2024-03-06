// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_items_statics_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DailyItemsStaticsModel _$DailyItemsStaticsModelFromJson(
        Map<String, dynamic> json) =>
    DailyItemsStaticsModel(
      doneInvoices: json['doneInvoices'] as int,
      totalInvoices: json['totalInvoices'] as int,
    );

Map<String, dynamic> _$DailyItemsStaticsModelToJson(
        DailyItemsStaticsModel instance) =>
    <String, dynamic>{
      'totalInvoices': instance.totalInvoices,
      'doneInvoices': instance.doneInvoices,
    };
