part of 'add_product_cubit.dart';

sealed class AddProductState extends Equatable {
  const AddProductState();

  @override
  List<Object> get props => [];
}

final class AddProductInitial extends AddProductState {
  final bool isLoading;

  const AddProductInitial({required this.isLoading});
}

class ProductError extends AddProductState {
  final String message;

  const ProductError(this.message);
}

class ProductAdded extends AddProductState {}
