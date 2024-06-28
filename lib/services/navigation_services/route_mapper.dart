part of 'navigation.dart';

Route<dynamic>? Function(RouteSettings)? onGenerateAppRoute(
    RoutesFactory routesFactory) {
  return (RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splash:
        return routesFactory.createSplashPageRoute();
      case RouteNames.login:
        return routesFactory.createLoginPageRoute();
      case RouteNames.signUp:
        return routesFactory.createSignupPageRoute();
      case RouteNames.products:
        return routesFactory.createProductsPageRoute();
      case RouteNames.addProduct:
        return routesFactory
            .createAddProductPageRoute(settings.arguments as Product?);
      case RouteNames.orders:
        return routesFactory.createOrdersPageRoute();
      case RouteNames.addOrders:
        return routesFactory.createAddOrderPageRoute();
      case RouteNames.dashboard:
        return routesFactory.createDashboardScreePageRoute();
      //   return routesFactory.createCartPageRoute();
      // case RouteNames.products:
      //   return routesFactory
      //       .createProductsPageRoute(settings.arguments as ProductModel);
    }
    return null;
  };
}
