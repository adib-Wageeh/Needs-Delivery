part of 'damaged_products_cubit.dart';

abstract class DamagedProductsState extends Equatable {
  const DamagedProductsState();
  @override
  List<Object> get props => [];
}

class DamagedProductsInitial extends DamagedProductsState {

}

class DamagedProductsLoading extends DamagedProductsState {

}

class DamagedProductsDone extends DamagedProductsState {

}

class DamagedProductsError extends DamagedProductsState {
    final Failure error;
    const DamagedProductsError({required this.error});
}