part of 'navigation.dart';

abstract interface class RoutesFactory {
  Route<dynamic> createSplashPageRoute();
  Route<dynamic> createLoginPageRoute();
  Route<dynamic> createSignupPageRoute();
  Route<dynamic> createHomeScreePageRoute();
  Route<dynamic> createProductsPageRoute();
  Route<dynamic> createAddProductPageRoute();
  Route<dynamic> createOrdersPageRoute();
  Route<dynamic> createAddOrderPageRoute();
  // Route<dynamic> createProductsPageRoute(ProductModel model);
}
