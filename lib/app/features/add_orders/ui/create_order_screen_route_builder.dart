import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_management_app/app/features/add_orders/cubit/createorder_cubit.dart';
import 'package:shop_management_app/app/features/add_orders/ui/create_order_screen.dart';
import 'package:shop_management_app/app/features/product/cubit/product_cubit.dart';
import 'package:shop_management_app/data/repository/order_repo.dart';
import 'package:shop_management_app/data/repository/product_repo.dart';

class CreateOrderScreenRouteBuilder {
  final OrderRepository orderRepository =
      OrderRepository(FirebaseFirestore.instance);
  final ProductRepository productRepository =
      ProductRepository(FirebaseFirestore.instance, FirebaseStorage.instance);
  Widget call(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CreateOrderCubit(orderRepository),
        ),
        BlocProvider(
          create: (context) => ProductCubit(productRepository),
        ),
      ],
      child: const CreateOrderScreen(),
    );
  }
}
