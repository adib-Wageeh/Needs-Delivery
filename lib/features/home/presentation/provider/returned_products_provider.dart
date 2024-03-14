import 'package:flutter/material.dart';
import 'package:needs_delivery/features/home/domain/entites/order_entity.dart';

class ReturnedAmountProvider extends ChangeNotifier{

  final List<OrderEntity> _products;
  final List<TextEditingController> _amountTextFields;
  final List<TextEditingController> _unitTextFields;
  TextEditingController reason = TextEditingController();

  ReturnedAmountProvider({required List<OrderEntity> products}):
        _products=products,
        _unitTextFields = List.generate(products.length, (index) => TextEditingController(text: '0'))
  ,_amountTextFields = List.generate(products.length, (index) => TextEditingController(text: '0'));

  List<OrderEntity> get getProducts => _products;
  List<TextEditingController> getAmountTextFieldsController() => _amountTextFields;
  List<TextEditingController> getUnitTextFieldsController() => _unitTextFields;


  bool checkIfAmountsIsValid(){
    for(OrderEntity orderEntity in _products){
      int? data = int.tryParse(_amountTextFields[_products.indexOf(orderEntity)].text.trim());
      if(data == null) {
        return false;
      }
      if(data == 0){
        continue;
      }
      if(orderEntity.quantity < data){
        return false;
      }
    }
    return true;
  }

  bool checkIfUnitsIsValid(){
    for(OrderEntity orderEntity in _products){
      int? data = int.tryParse(_unitTextFields[_products.indexOf(orderEntity)].text.trim());
      if(data == 0){
        continue;
      }
      if(data == null) {
        return false;
      }
      if(orderEntity.units < data){
        return false;
      }
    }
    return true;
  }

}