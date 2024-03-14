import 'package:json_annotation/json_annotation.dart';
import 'package:needs_delivery/core/utils/typedefs.dart';
import 'package:needs_delivery/features/home/domain/entites/daily_items_statics_entity.dart';

part 'daily_items_statics_model.g.dart';

@JsonSerializable()
class DailyItemsStaticsModel extends DailyItemsStaticsEntity{

  DailyItemsStaticsModel({required super.done,
    required super.all});

  factory DailyItemsStaticsModel.fromJson(DataMap json)
      => _$DailyItemsStaticsModelFromJson(json);

  DataMap toJson() => _$DailyItemsStaticsModelToJson(this);



}