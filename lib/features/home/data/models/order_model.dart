import 'package:json_annotation/json_annotation.dart';
import 'package:needs_delivery/core/utils/typedefs.dart';
import 'package:needs_delivery/features/home/domain/entites/order_entity.dart';

part 'order_model.g.dart';

@JsonSerializable()
class OrderModel extends OrderEntity{

  OrderModel({required super.id, required super.invoiceId,
    required super.totalProduct, required super.productId,
    required super.quantity, required super.productName,
    required super.productPrice, required super.units,super.image});

  factory OrderModel.fromJson(DataMap json) => _$OrderModelFromJson(json);

  DataMap toJson() => _$OrderModelToJson(this);



}