part of 'login_cubit.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {
  final bool isLoading;

  const LoginInitial({required this.isLoading});
}

final class LoginCompleted extends LoginState {
  final String message;

  const LoginCompleted({required this.message});
}
