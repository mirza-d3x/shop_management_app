import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop_management_app/repository/auth_repository.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit(this._authRepository)
      : super(const SplashInitial(isLogedIn: false)) {
    checkUserLogedIn();
  }
  final AuthRepository _authRepository;

  User? get currentUser => _authRepository.currentUser;

  void checkUserLogedIn() async {
    // Checking user already login or not
    // if already login it will emit true otherwise false
    await Future.delayed(const Duration(seconds: 3));
    if (currentUser != null) {
      emit(const SplashInitial(isLogedIn: true));
    } else {
      emit(const SplashInitial(isLogedIn: false));
    }
  }
}
