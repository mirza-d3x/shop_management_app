part of 'navigation.dart';

abstract interface class RoutesFactory {
  Route<dynamic> createSplashPageRoute();
  Route<dynamic> createLoginPageRoute();
  Route<dynamic> createSignupPageRoute();
  Route<dynamic> createDashboardScreePageRoute();
  Route<dynamic> createProductsPageRoute();
  Route<dynamic> createAddProductPageRoute(Product? product);
  Route<dynamic> createOrdersPageRoute();
  Route<dynamic> createAddOrderPageRoute();
  // Route<dynamic> createProductsPageRoute(ProductModel model);
}
