import 'package:json_annotation/json_annotation.dart';

class RunSheetItemEntity {

  final int id;
  @JsonKey(name: 'runsheet_id')
  final int runSheetId;
  @JsonKey(name: 'invoice_id')
  final int invoiceId;
  @JsonKey(name: 'merchant_id')
  final int merchantId;
  @JsonKey(name: 'merchant_name')
  final String merchantName;
  @JsonKey(name: 'merchant_image')
  final String merchantImage;
  @JsonKey(name: 'address')
  final String address;
  @JsonKey(name: 'area')
  final String area;
  @JsonKey(name: 'lat')
  final String lat;
  @JsonKey(name: 'long')
  final String long;
  @JsonKey(name: 'total_invoice')
  final double totalInvoice;
  @JsonKey(name: 'status')
  final String status;

  const RunSheetItemEntity({
   required this.id,required this.invoiceId,required this.status,
   required this.runSheetId,required this.long,required this.lat,
   required this.address,required this.area,required this.merchantId,
   required this.merchantImage,required this.merchantName,required this.totalInvoice
});

}