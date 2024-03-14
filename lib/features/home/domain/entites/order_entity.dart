import 'package:json_annotation/json_annotation.dart';

class OrderEntity {

  final int id;
  @JsonKey(name: 'invoice_id')
  final int invoiceId;
  @JsonKey(name: 'product_id')
  final int productId;
  @JsonKey(name: 'product_name')
  final String productName;
  @JsonKey(name: 'product_price')
  final String productPrice;
  final String? image;
  final int quantity;
  final int units;
  @JsonKey(name: 'total_product')
  final String totalProduct;


  OrderEntity({
    required this.id,
    required this.invoiceId,
    this.image,
    required this.totalProduct,
    required this.productId,
    required this.quantity,
    required this.productName,
    required this.productPrice,
    required this.units
  });

}