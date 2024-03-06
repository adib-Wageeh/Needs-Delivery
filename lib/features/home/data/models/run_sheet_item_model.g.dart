// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'run_sheet_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RunSheetItemModel _$RunSheetItemModelFromJson(Map<String, dynamic> json) =>
    RunSheetItemModel(
      id: json['id'] as int,
      invoiceId: json['invoice_id'] as int,
      status: json['status'] as String,
      runSheetId: json['runsheet_id'] as int,
      long: json['long'] as String,
      lat: json['lat'] as String,
      address: json['address'] as String,
      area: json['area'] as String,
      merchantId: json['merchant_id'] as int,
      merchantImage: json['merchant_image'] as String,
      merchantName: json['merchant_name'] as String,
      totalInvoice: (json['total_invoice'] as num).toDouble(),
    );

Map<String, dynamic> _$RunSheetItemModelToJson(RunSheetItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'runsheet_id': instance.runSheetId,
      'invoice_id': instance.invoiceId,
      'merchant_id': instance.merchantId,
      'merchant_name': instance.merchantName,
      'merchant_image': instance.merchantImage,
      'address': instance.address,
      'area': instance.area,
      'lat': instance.lat,
      'long': instance.long,
      'total_invoice': instance.totalInvoice,
      'status': instance.status,
    };
