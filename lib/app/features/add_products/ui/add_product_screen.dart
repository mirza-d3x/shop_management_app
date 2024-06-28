import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_management_app/app/features/add_products/cubit/add_product_cubit.dart';
import 'package:shop_management_app/app/widgets/custom_text_field.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AddProductCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: BlocConsumer<AddProductCubit, AddProductState>(
        listener: (context, state) {
          if (state is ProductAdded) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return BlocBuilder<AddProductCubit, AddProductState>(
            builder: (context, state) {
              if (state is AddProductInitial) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: cubit.formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          CustomTextField(
                            controller: cubit.nameController,
                            label: 'Name',
                            hint: 'Enter Product Name',
                            obscureText: false,
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Name is required';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20.h),
                          CustomTextField(
                            controller: cubit.descriptionController,
                            label: 'Description',
                            hint: 'Enter Product Description',
                            obscureText: false,
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Description is required';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20.h),
                          CustomTextField(
                            controller: cubit.priceController,
                            label: 'Price',
                            hint: 'Enter Product Price',
                            obscureText: false,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Price is required';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20.h),
                          CustomTextField(
                            controller: cubit.categoryController,
                            label: 'Category',
                            hint: 'Enter Product Category',
                            obscureText: false,
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Category is required';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          AbsorbPointer(
                            absorbing: cubit.imageUrl.isEmpty,
                            child: Row(
                              children: [
                                const Text('Available:'),
                                Switch(
                                  value: cubit.isAvailable,
                                  onChanged: (value) {
                                    cubit.toggleAvailability();
                                  },
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              cubit.pickImage();
                            },
                            child: SizedBox(
                              height: 200.h,
                              child: cubit.pickedImage == null
                                  ? cubit.imageUrl.isNotEmpty
                                      ? Image.network(cubit.imageUrl)
                                      : TextButton(
                                          onPressed: () {
                                            cubit.pickImage();
                                          },
                                          child: const Text('Pick Image'),
                                        )
                                  : Image.file(
                                      cubit.pickedImage!,
                                      height: 200.h,
                                    ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          state.isLoading
                              ? const CircularProgressIndicator()
                              : ElevatedButton(
                                  onPressed: () {
                                    if (cubit.imageUrl.isEmpty &&
                                        cubit.pickedImage == null) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text('Image is required'),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    } else if (cubit.imageUrl.isNotEmpty) {
                                      cubit.submitEditProduct();
                                    } else {
                                      cubit.submitAddProduct();
                                    }
                                  },
                                  child: const Text('Submit'),
                                ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              return const SizedBox();
            },
          );
        },
      ),
    );
  }
}
