import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shop_management_app/data/repository/auth_repository.dart';
import 'package:shop_management_app/utils/console_log.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit(this._authRepository)
      : super(const SignupInitial(message: "Loading")) {
    init();
  }
  final AuthRepository _authRepository;

  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController shopNameController;
  late TextEditingController placeController;
  late GlobalKey<FormState> formKey;

  init() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    shopNameController = TextEditingController();
    placeController = TextEditingController();
    formKey = GlobalKey<FormState>();
  }

  Future<void> submitSignup() async {
    if (formKey.currentState!.validate()) {
      try {
        emit(SignupLoading());
        await _authRepository.signUp(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
          shopName: shopNameController.text.trim(),
          place: placeController.text.trim(),
        );
        emit(const SignupInitial(message: "Success"));
      } catch (error, stackTrace) {
        consoleLog("Error on signup", error: error, stackTrace: stackTrace);
        emit(SignupInitial(message: e.toString()));
      }
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    shopNameController.dispose();
    placeController.dispose();
    return super.close();
  }
}
