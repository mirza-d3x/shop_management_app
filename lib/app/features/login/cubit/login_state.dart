part of 'login_cubit.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {
  final String message;

  const LoginInitial({required this.message});
}

final class LoginLoading extends LoginState {}
