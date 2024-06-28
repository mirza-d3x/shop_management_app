// ignore_for_file: implicit_call_tearoffs

part of 'navigation.dart';

final class AppRoutesFactory implements RoutesFactory {
  @override
  Route createLoginPageRoute() {
    return CustomRoute(
      builder: LoginScreenRouteBuilder(),
    );
  }

  @override
  Route createSplashPageRoute() {
    return CustomRoute(
      builder: SplashScreenRouteBuilder(),
    );
  }

  @override
  Route createAddOrderPageRoute() {
    return CustomRoute(
      builder: CreateOrderScreenRouteBuilder(),
    );
  }

  @override
  Route createAddProductPageRoute(Product? product) {
    return CustomRoute(
      builder: AddProductScreenRouteBuilder(product: product),
    );
  }

  @override
  Route createOrdersPageRoute() {
    return CustomRoute(
      builder: OrderScreenRouteBuilder(),
    );
  }

  @override
  Route createProductsPageRoute() {
    return CustomRoute(
      builder: ProductScreenRouteBuilder(),
    );
  }

  @override
  Route createSignupPageRoute() {
    return CustomRoute(
      builder: SignupScreenRouteBuilder(),
    );
  }

  @override
  Route createDashboardScreePageRoute() {
    return CustomRoute(builder: DashboardScreenRouteBuilder());
  }

//   @override
//   Route createProductsPageRoute(ProductModel model) {
//     return CustomRoute(
//       builder: ProductDetailsBuilder(model: model),
//     );
//   }
}

class CustomRoute<T> extends MaterialPageRoute<T> {
  CustomRoute({required super.builder});

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(begin: const Offset(1.0, 0.0), end: Offset.zero)
          .animate(CurvedAnimation(
        parent: animation,
        curve: const Interval(0.00, 0.90, curve: Curves.linearToEaseOut),
      )),
      child: child,
    );
  }

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);
}
