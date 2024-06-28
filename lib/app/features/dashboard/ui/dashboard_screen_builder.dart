import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_management_app/app/features/dashboard/cubit/dashboard_cubit.dart';
import 'package:shop_management_app/app/features/dashboard/ui/dashboard_screen.dart';
import 'package:shop_management_app/data/repository/auth_repository.dart';
import 'package:shop_management_app/data/repository/order_repo.dart';

class DashboardScreenRouteBuilder {
  final orderRepository = OrderRepository(FirebaseFirestore.instance);
  final AuthRepository authRepository =
      AuthRepository(FirebaseAuth.instance, FirebaseFirestore.instance);
  Widget call(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardCubit(orderRepository, authRepository),
      child: const DashboardScreen(),
    );
  }
}
