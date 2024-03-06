// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      id: json['id'] as int,
      invoiceId: json['invoice_id'] as int,
      totalProduct: (json['total_product'] as num).toDouble(),
      productId: json['product_id'] as int,
      amount: json['amount'] as int,
      productName: json['product_name'] as String,
      productPrice: (json['product_price'] as num).toDouble(),
      units: json['units'] as int,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'invoice_id': instance.invoiceId,
      'product_id': instance.productId,
      'product_name': instance.productName,
      'product_price': instance.productPrice,
      'image': instance.image,
      'amount': instance.amount,
      'units': instance.units,
      'total_product': instance.totalProduct,
    };
