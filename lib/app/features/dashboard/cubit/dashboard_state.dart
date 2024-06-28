part of 'dashboard_cubit.dart';

sealed class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object> get props => [];
}

final class DashboardInitial extends DashboardState {
  final List<OrderModel>? orders;

  const DashboardInitial({required this.orders});
}

final class DashboardError extends DashboardState {
  final String message;

  const DashboardError({required this.message});
}

final class DashboardLoading extends DashboardState {}
