import 'package:json_annotation/json_annotation.dart';
import 'package:needs_delivery/core/utils/typedefs.dart';
import 'package:needs_delivery/features/home/domain/entites/run_sheet_item_entity.dart';

part 'run_sheet_item_model.g.dart';

@JsonSerializable()
class RunSheetItemModel extends RunSheetItemEntity {

  RunSheetItemModel({required super.id, required super.invoiceId,
    required super.status, required super.runSheetId, required super.long,
    required super.lat, required super.address, required super.area,
    required super.merchantId, required super.merchantImage,required super.mobile,
    required super.merchantName, required super.totalInvoice});

  factory RunSheetItemModel.fromJson(DataMap json) => _$RunSheetItemModelFromJson(json);

  DataMap toJson() => _$RunSheetItemModelToJson(this);


}