import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shop_management_app/data/models/order_model.dart';
import 'package:shop_management_app/data/repository/auth_repository.dart';
import 'package:shop_management_app/data/repository/order_repo.dart';
import 'package:shop_management_app/main.dart';
import 'package:shop_management_app/utils/console_log.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit(this._orderRepository, this._authRepository)
      : super(const DashboardInitial(orders: null)) {
    init();
  }

  final AuthRepository _authRepository;
  final OrderRepository _orderRepository;

  double todayOrderAmount = 0.0;
  int todayOrders = 0;
  List<OrderModel> todaysOrderList = [];

  void init() {
    loadOrders(kUserId);
  }

  void loadOrders(String userId) {
    emit(DashboardLoading());
    _orderRepository.getOrders(userId).listen((orders) {
      findTotal(orders);
      emit(DashboardInitial(orders: orders));
    }, onError: (error, stackTrace) {
      consoleLog("Error while loading products",
          error: error, stackTrace: stackTrace);
      emit(DashboardError(message: error.toString()));
    });
  }

// This function is used for get all orders amount
  findTotal(List<OrderModel> orders) {
    todaysOrderList = orders
        .where(
          (order) => order.orderDate.day == DateTime.now().day,
        )
        .toList();

    todayOrders = todaysOrderList.length;
    todayOrderAmount =
        todaysOrderList.fold(0.0, (sum, order) => sum + order.totalPrice);
  }

// Call  this function for signout the user
  Future<void> signOut() async {
    await _authRepository.signOut();
  }
}
