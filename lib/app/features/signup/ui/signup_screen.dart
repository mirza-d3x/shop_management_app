import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_management_app/app/features/signup/cubit/signup_cubit.dart';
import 'package:shop_management_app/app/widgets/custom_text_field.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<SignupCubit>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Register'),
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
                obscureText: false,
                hint: 'Email',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is required';
                  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
              ),
              CustomTextField(
                controller: cubit.passwordController,
                hint: 'Password',
                label: 'Password',
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
              CustomTextField(
                controller: cubit.shopNameController,
                hint: 'Shop Name',
                label: 'Shop Name',
                obscureText: false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Shop Name is required';
                  }
                  return null;
                },
              ),
              CustomTextField(
                controller: cubit.placeController,
                hint: 'Place',
                label: 'Place',
                obscureText: false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Place is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                child: const Text('Register'),
                onPressed: () {
                  cubit.submitSignup();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
