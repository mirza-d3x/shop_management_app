import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shop_management_app/main.dart';
import 'package:shop_management_app/data/models/order_model.dart';
import 'package:shop_management_app/data/repository/order_repo.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final OrderRepository _orderRepository;

  List<OrderModel> _allOrders = [];

  OrderCubit(this._orderRepository) : super(OrderInitial()) {
    init();
  }

  late TextEditingController searchController;

  void init() {
    searchController == TextEditingController();
    loadOrders(kUserId);
  }

  void loadOrders(String userId) {
    emit(OrderLoading());
    _orderRepository.getOrders(userId).listen((orders) {
      _allOrders = orders;
      emit(OrderLoaded(orders));
    });
  }

  Future<void> addOrder(OrderModel order) async {
    try {
      await _orderRepository.addOrder(order);
    } catch (e) {
      emit(OrderError(e.toString()));
    }
  }

  Future<void> updateOrderStatus(String orderId, String status) async {
    try {
      await _orderRepository.updateOrderStatus(orderId, status);
    } catch (e) {
      emit(OrderError(e.toString()));
    }
  }

  Future<void> deleteOrder(String orderId) async {
    try {
      await _orderRepository.deleteOrder(orderId);
    } catch (e) {
      emit(OrderError(e.toString()));
    }
  }

  void searchOrders() {
    final query = searchController.text.toLowerCase();
    if (query.isEmpty) {
      emit(OrderLoaded(_allOrders));
    } else {
      final filteredOrders = _allOrders.where((order) {
        final matchesCustomerName =
            order.customerName.toLowerCase().contains(query);
        final matchesProductName = order.products
            .any((product) => product.name.toLowerCase().contains(query));
        final matchesTableNumber =
            order.tableNumber?.toLowerCase().contains(query) ?? false;
        return matchesCustomerName || matchesProductName || matchesTableNumber;
      }).toList();
      emit(OrderLoaded(filteredOrders));
    }
  }

  void sortOrders(String sortType) {
    List<OrderModel> sortedOrders = List.from(_allOrders);
    if (sortType == 'Date Ascending') {
      sortedOrders.sort((a, b) => a.orderDate.compareTo(b.orderDate));
    } else if (sortType == 'Date Descending') {
      sortedOrders.sort((a, b) => b.orderDate.compareTo(a.orderDate));
    } else if (sortType == 'Total Price Ascending') {
      sortedOrders.sort((a, b) => a.totalPrice.compareTo(b.totalPrice));
    } else if (sortType == 'Total Price Descending') {
      sortedOrders.sort((a, b) => b.totalPrice.compareTo(a.totalPrice));
    }
    emit(OrderLoaded(sortedOrders));
  }
}
