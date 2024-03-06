import 'package:json_annotation/json_annotation.dart';
import 'package:needs_delivery/core/utils/typedefs.dart';
import 'package:needs_delivery/features/home/domain/entites/run_sheet_entity.dart';

part 'run_sheet_model.g.dart';

@JsonSerializable()
class RunSheetModel extends RunSheetEntity {

  RunSheetModel({required super.id, required super.date,
    required super.location, required super.invoicesCount,super.car});

  factory RunSheetModel.fromJson(DataMap json) => _$RunSheetModelFromJson(json);

  DataMap toJson() => _$RunSheetModelToJson(this);

}