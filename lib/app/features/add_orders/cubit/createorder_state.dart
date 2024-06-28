part of 'createorder_cubit.dart';

sealed class CreateOrderState extends Equatable {
  const CreateOrderState();

  @override
  List<Object> get props => [];
}

final class CreateorderInitial extends CreateOrderState {}

class CreateOrderInitial extends CreateOrderState {}

class CreateOrderLoading extends CreateOrderState {}

class CreateOrderCompleted extends CreateOrderState {}

class CreateOrderError extends CreateOrderState {
  final String message;

  const CreateOrderError({required this.message});
}

class CreateOrderUpdated extends CreateOrderState {
  final List<Product> selectedProducts;
  const CreateOrderUpdated({required this.selectedProducts});
}
