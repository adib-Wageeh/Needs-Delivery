import 'package:json_annotation/json_annotation.dart';

class RunSheetEntity{

  final int id;
  @JsonKey(name: 'center_name')
  final String location;
  @JsonKey(name: 'car')
  final String? car;
  @JsonKey(name: 'delivery_date')
  final String date;
  @JsonKey(name: 'invoices_count')
  final String invoicesCount;

  const RunSheetEntity({required this.id,required this.date,
    required this.location,this.car,required this.invoicesCount});

}