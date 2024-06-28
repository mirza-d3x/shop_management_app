import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_management_app/app/features/add_products/cubit/add_product_cubit.dart';
import 'package:shop_management_app/app/features/add_products/ui/add_product_screen.dart';
import 'package:shop_management_app/data/models/product_model.dart';
import 'package:shop_management_app/data/repository/product_repo.dart';

class AddProductScreenRouteBuilder {
  AddProductScreenRouteBuilder({required this.product});
  final Product? product;

  final productRepository =
      ProductRepository(FirebaseFirestore.instance, FirebaseStorage.instance);
  Widget call(BuildContext context) {
    return BlocProvider(
      create: (context) => AddProductCubit(productRepository, product),
      child: const AddProductScreen(),
    );
  }
}
