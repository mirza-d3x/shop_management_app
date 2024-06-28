part of 'signup_cubit.dart';

sealed class SignupState extends Equatable {
  const SignupState();

  @override
  List<Object> get props => [];
}

final class SignupInitial extends SignupState {
  final String message;

  const SignupInitial({required this.message});
}

final class SignupLoading extends SignupState {}
