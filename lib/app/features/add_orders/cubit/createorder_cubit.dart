import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shop_management_app/data/models/order_model.dart';
import 'package:shop_management_app/data/models/product_model.dart';
import 'package:shop_management_app/data/repository/order_repo.dart';
import 'package:shop_management_app/main.dart';
import 'package:shop_management_app/utils/console_log.dart';

part 'createorder_state.dart';

class CreateOrderCubit extends Cubit<CreateOrderState> {
  CreateOrderCubit(this.orderRepository) : super(CreateorderInitial()) {
    init();
  }
  final OrderRepository orderRepository;

  late TextEditingController nameController;
  late TextEditingController tableNumberController;
  List<Product> selectedProducts = [];
  String orderType = 'Dine In';
  init() {
    nameController = TextEditingController();
    tableNumberController = TextEditingController();
    emit(CreateOrderInitial());
  }

  submitCreatOrder() {
    try {
      emit(CreateOrderInitial());
      final order = OrderModel(
          id: '',
          customerName: nameController.text.trim(),
          products: selectedProducts,
          status: "Pending",
          totalPrice: calculateTotalPrice(),
          orderDate: DateTime.now(),
          tableNumber: tableNumberController.text.trim(),
          userId: kUserId,
          orderType: orderType);
      orderRepository.addOrder(order);
      emit(CreateOrderCompleted());
    } catch (error, stackTraca) {
      consoleLog("Error while creating Ordrer: ",
          error: error, stackTrace: stackTraca);
      emit(CreateOrderError(message: error.toString()));
    }
  }

  void selectProduct(Product product) {
    emit(CreateOrderInitial());
    if (selectedProducts.isNotEmpty &&
        selectedProducts.indexWhere((element) => element.id == product.id) !=
            -1) {
      selectedProducts.removeAt(
          selectedProducts.indexWhere((element) => element.id == product.id));
    } else {
      selectedProducts.add(product);
    }
    emit(CreateOrderUpdated(selectedProducts: selectedProducts));
  }

  void increaseQuantity(Product product) {
    emit(CreateOrderInitial());
    final index =
        selectedProducts.indexWhere((element) => element.id == product.id);
    if (index != -1) {
      final updatedProduct = selectedProducts[index].copyWith(
        quantity: selectedProducts[index].quantity + 1,
      );
      selectedProducts[index] = updatedProduct;
      emit(CreateOrderUpdated(selectedProducts: List.from(selectedProducts)));
    }
  }

  void decreaseQuantity(Product product) {
    emit(CreateOrderInitial());
    final index =
        selectedProducts.indexWhere((element) => element.id == product.id);
    if (index != -1 && selectedProducts[index].quantity > 1) {
      final updatedProduct = selectedProducts[index].copyWith(
        quantity: selectedProducts[index].quantity - 1,
      );
      selectedProducts[index] = updatedProduct;
      emit(CreateOrderUpdated(selectedProducts: List.from(selectedProducts)));
    }
  }

  void updateOrderType(String value) {
    emit(CreateOrderInitial());
    orderType = value;
    emit(CreateOrderUpdated(selectedProducts: selectedProducts));
  }

  double calculateTotalPrice() {
    double totalPrice = 0.0;
    for (var element in selectedProducts) {
      totalPrice += element.price * element.quantity;
    }
    return totalPrice;
  }

  @override
  Future<void> close() {
    nameController.dispose();
    tableNumberController.dispose();
    return super.close();
  }
}
