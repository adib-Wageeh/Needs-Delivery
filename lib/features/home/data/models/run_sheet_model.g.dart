// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'run_sheet_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RunSheetModel _$RunSheetModelFromJson(Map<String, dynamic> json) =>
    RunSheetModel(
      id: json['id'] as int,
      date: json['delivery_date'] as String,
      location: json['center_name'] as String,
      invoicesCount: json['invoices_count'] as String,
      car: json['car'] as String?,
    );

Map<String, dynamic> _$RunSheetModelToJson(RunSheetModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'center_name': instance.location,
      'car': instance.car,
      'delivery_date': instance.date,
      'invoices_count': instance.invoicesCount,
    };
