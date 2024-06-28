import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shop_management_app/main.dart';
import 'package:shop_management_app/data/models/order_model.dart';
import 'package:shop_management_app/data/repository/order_repo.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final OrderRepository _orderRepository;

  OrderCubit(this._orderRepository) : super(OrderInitial()) {
    init();
  }

  late TextEditingController searchController;
  String _currentSortType = '';
  String _currentStatusFilter = '';
  List<OrderModel> _allOrders = [];

  void init() {
    searchController = TextEditingController();
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
    _applyFilters();
  }

  void sortOrders(String sortType) {
    _currentSortType = sortType;
    _applyFilters();
  }

  void filterByStatus(String status) {
    _currentStatusFilter = status;
    _applyFilters();
  }

  void _applyFilters() {
    List<OrderModel> filteredOrders = _allOrders;

    if (searchController.text.isNotEmpty) {
      final query = searchController.text.toLowerCase();
      filteredOrders = filteredOrders.where((order) {
        final matchesCustomerName =
            order.customerName.toLowerCase().contains(query);
        final matchesProductName = order.products
            .any((product) => product.name.toLowerCase().contains(query));
        final matchesTableNumber =
            order.tableNumber.toLowerCase().contains(query);
        return matchesCustomerName || matchesProductName || matchesTableNumber;
      }).toList();
    }

    if (_currentStatusFilter != 'All' && _currentStatusFilter.isNotEmpty) {
      filteredOrders = filteredOrders
          .where((order) => order.status == _currentStatusFilter)
          .toList();
    }

    if (_currentSortType.isNotEmpty) {
      if (_currentSortType == 'Date Ascending') {
        filteredOrders.sort((a, b) => a.orderDate.compareTo(b.orderDate));
      } else if (_currentSortType == 'Date Descending') {
        filteredOrders.sort((a, b) => b.orderDate.compareTo(a.orderDate));
      } else if (_currentSortType == 'Total Price Ascending') {
        filteredOrders.sort((a, b) => a.totalPrice.compareTo(b.totalPrice));
      } else if (_currentSortType == 'Total Price Descending') {
        filteredOrders.sort((a, b) => b.totalPrice.compareTo(a.totalPrice));
      }
    }

    emit(OrderLoaded(filteredOrders));
  }
}
