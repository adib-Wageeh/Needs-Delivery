part of 'return_products_cubit.dart';

abstract class ReturnProductsState extends Equatable {
  const ReturnProductsState();
  @override
  List<Object> get props => [];
}

class ReturnProductsInitial extends ReturnProductsState {

}

class ReturnProductsLoading extends ReturnProductsState {

}

class ReturnProductsDone extends ReturnProductsState {

}

class ReturnProductsError extends ReturnProductsState {
    final Failure error;
    const ReturnProductsError({required this.error});
}