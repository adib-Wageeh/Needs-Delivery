import 'package:flutter/material.dart';
import 'package:needs_delivery/features/home/domain/entites/order_entity.dart';

class ReturnedAmountProvider extends ChangeNotifier{

  final List<OrderEntity> _products;
  final List<TextEditingController> _amountTextFields;
  final List<TextEditingController> _unitTextFields;

  ReturnedAmountProvider({required List<OrderEntity> products}):
        _products=products,
        _unitTextFields = List.generate(products.length, (index) => TextEditingController(text: '0'))
  ,_amountTextFields = List.generate(products.length, (index) => TextEditingController(text: '0'));

  List<OrderEntity> get getProducts => _products;
  TextEditingController getAmountTextFieldController(int index) => _amountTextFields[index];
  TextEditingController getUnitTextFieldController(int index) => _unitTextFields[index];


  bool checkIfAmountsIsValid(){
    for(OrderEntity orderEntity in _products){
      int? data = int.tryParse(_amountTextFields[_products.indexOf(orderEntity)].text.trim());
      if(data == null) {
        return false;
      }
      if(orderEntity.amount > data){
        return false;
      }
    }
    return true;
  }

  bool checkIfUnitsIsValid(){
    for(OrderEntity orderEntity in _products){
      int? data = int.tryParse(_unitTextFields[_products.indexOf(orderEntity)].text.trim());
      if(data == null) {
        return false;
      }
      if(orderEntity.units > data){
        return false;
      }
    }
    return true;
  }

}