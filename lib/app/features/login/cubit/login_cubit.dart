import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shop_management_app/repository/auth_repository.dart';
import 'package:shop_management_app/utils/console_log.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authRepository)
      : super(const LoginInitial(isLoading: false)) {
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
  }

  Future<void> submitLogin() async {
    if (formKey.currentState?.validate() ?? false) {
      try {
        emit(const LoginInitial(isLoading: true));
        await _authRepository.signIn(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        emit(const LoginCompleted(message: ""));
      } catch (error, stackTrace) {
        consoleLog("Login Request Failed",
            error: error, stackTrace: stackTrace);
        emit(LoginCompleted(message: error.toString()));
      }
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();

    return super.close();
  }
}
