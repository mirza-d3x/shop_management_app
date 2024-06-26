import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_management_app/app/features/signup/cubit/signup_cubit.dart';
import 'package:shop_management_app/app/features/signup/ui/signup_screen.dart';
import 'package:shop_management_app/repository/auth_repository.dart';

class SignupScreenRouteBuilder {
  final authRepository =
      AuthRepository(FirebaseAuth.instance, FirebaseFirestore.instance);
  Widget call(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(authRepository),
      child: const SignupScreen(),
    );
  }
}
