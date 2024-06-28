import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shop_management_app/data/repository/auth_repository.dart';
import 'package:shop_management_app/utils/console_log.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authRepository)
      : super(const LoginInitial(message: "Loading")) {
    init();
  }
  final AuthRepository _authRepository;

  late TextEditingController emailController;
  late TextEditingController passwordController;
  late GlobalKey<FormState> formKey;

  void init() {
    consoleLog("Login cubit init");
    emailController = TextEditingController();
    passwordController = TextEditingController();
    formKey = GlobalKey<FormState>();
    _authRepository.authStateChanges.listen((user) {
      if (user != null) {
        consoleLog("User Authenticated");
      } else {
        consoleLog("User Not Authenticated");
      }
    });
  }

  Future<void> submitLogin() async {
    if (formKey.currentState?.validate() ?? false) {
      try {
        emit(LoginLoading());
        await _authRepository.signIn(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        emit(const LoginInitial(message: "Success"));
      } catch (error, stackTrace) {
        consoleLog("Login Request Failed",
            error: error, stackTrace: stackTrace);
        emit(LoginInitial(message: error.toString()));
      }
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();

    return super.close();
  }
}
