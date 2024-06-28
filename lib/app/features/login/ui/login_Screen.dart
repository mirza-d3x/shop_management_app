import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_management_app/app/features/login/cubit/login_cubit.dart';
import 'package:shop_management_app/app/widgets/custom_button.dart';
import 'package:shop_management_app/app/widgets/custom_text_field.dart';
import 'package:shop_management_app/services/navigation_services/navigation_services.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LoginCubit>(context);
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginInitial) {
          if (state.message == "Success") {
            context.navigationService.createDashboardPageRoute(context);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Login'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: cubit.formKey,
            child: Column(
              children: [
                CustomTextField(
                  controller: cubit.emailController,
                  label: 'Email',
                  hint: 'Email',
                  obscureText: false,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                        .hasMatch(value)) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomTextField(
                  controller: cubit.passwordController,
                  label: 'Password',
                  hint: 'Password',
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    } else if (value.length < 5) {
                      return 'Password must be at least 5 characters long';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 200.w,
                  child: CustomElevatedButton(
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      cubit.submitLogin();
                    },
                  ),
                ),
                TextButton(
                  child: const Text('Register'),
                  onPressed: () {
                    context.navigationService.createSignUpPageRoute(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
