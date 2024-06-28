import 'package:flutter/material.dart';
import 'package:shop_management_app/data/models/order_model.dart';
import 'package:shop_management_app/data/models/product_model.dart';

import 'route_names.dart';

class NavigationServices {
  void createLoginPageRoute(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      RouteNames.login,
      (route) => false,
    );
  }

  void createSignUpPageRoute(BuildContext context) {
    Navigator.of(context).pushNamed(
      RouteNames.signUp,
    );
  }

  void createSplashPageRoute(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      RouteNames.splash,
      (route) => false,
    );
  }

  void createDashboardPageRoute(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      RouteNames.dashboard,
      (route) => false,
    );
  }

  void createProductsPageRoute(BuildContext context) {
    Navigator.of(context).pushNamed(
      RouteNames.products,
    );
  }

  void createOrdersPageRoute(BuildContext context) {
    Navigator.of(context).pushNamed(
      RouteNames.orders,
    );
  }

  void createAddProductPageRoute(BuildContext context, Product? product) {
    Navigator.of(context).pushNamed(
      RouteNames.addProduct,
      arguments: product,
    );
  }

  void createAddOrderPageRoute(BuildContext context, OrderModel? orderModel) {
    Navigator.of(context).pushNamed(
      RouteNames.addOrders,
      arguments: orderModel,
    );
  }

  // void createProductsPageRoute(BuildContext context, ProductModel model) {
  //   Navigator.of(context).pushNamed(RouteNames.products, arguments: model);
  // }
}

extension AppPageInjectable on BuildContext {
  NavigationServices get navigationService => NavigationServices();
}
