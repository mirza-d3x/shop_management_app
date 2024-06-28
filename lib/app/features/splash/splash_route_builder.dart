import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_management_app/app/features/splash/cubit/splash_cubit.dart';
import 'package:shop_management_app/app/features/splash/splash_screen.dart';
import 'package:shop_management_app/data/repository/auth_repository.dart';

class SplashScreenRouteBuilder {
  final authRepository =
      AuthRepository(FirebaseAuth.instance, FirebaseFirestore.instance);
  Widget call(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit(authRepository),
      child: const SplashScreen(),
    );
  }
}
