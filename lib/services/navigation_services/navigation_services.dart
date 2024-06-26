import 'package:flutter/material.dart';

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

  void createHomePageRoute(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      RouteNames.home,
      (route) => false,
    );
  }

  // void createProductsPageRoute(BuildContext context, ProductModel model) {
  //   Navigator.of(context).pushNamed(RouteNames.products, arguments: model);
  // }
}

extension AppPageInjectable on BuildContext {
  NavigationServices get navigationService => NavigationServices();
}
