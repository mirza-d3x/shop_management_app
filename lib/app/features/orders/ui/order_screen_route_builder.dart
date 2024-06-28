import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_management_app/app/features/orders/cubit/order_cubit.dart';
import 'package:shop_management_app/app/features/orders/ui/orders_screen.dart';
import 'package:shop_management_app/data/repository/order_repo.dart';

class OrderScreenRouteBuilder {
  final orderRepository = OrderRepository(FirebaseFirestore.instance);
  Widget call(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderCubit(orderRepository),
      child: const OrdersScreen(),
    );
  }
}
