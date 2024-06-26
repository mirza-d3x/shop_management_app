import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_management_app/app/features/splash/cubit/splash_cubit.dart';
import 'package:shop_management_app/services/navigation_services/navigation_services.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state is SplashInitial) {
          if (state.isLogedIn) {
            context.navigationService.createHomePageRoute(context);
          } else {
            context.navigationService.createLoginPageRoute(context);
          }
        }
      },
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.only(left: 30.w, right: 30.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 100.h,
                width: 100.w,
                child: const FlutterLogo(),
              ),
              SizedBox(
                height: 30.h,
              ),
              const LinearProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
