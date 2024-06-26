import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_management_app/app/features/add_products/cubit/add_product_cubit.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AddProductCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: BlocBuilder<AddProductCubit, AddProductState>(
        builder: (context, state) {
          if (state is AddProductInitial) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: cubit.nameController,
                    decoration:
                        const InputDecoration(labelText: 'Product Name'),
                  ),
                  TextField(
                    controller: cubit.descriptionController,
                    decoration: const InputDecoration(labelText: 'Description'),
                  ),
                  TextField(
                    controller: cubit.priceController,
                    decoration: const InputDecoration(labelText: 'Price'),
                    keyboardType: TextInputType.number,
                  ),
                  TextField(
                    controller: cubit.categoryController,
                    decoration: const InputDecoration(labelText: 'Category'),
                  ),
                  const SizedBox(height: 20),
                  cubit.pickedImage == null
                      ? TextButton(
                          onPressed: () {
                            cubit.pickImage();
                          },
                          child: const Text('Pick Image'),
                        )
                      : Image.file(cubit.pickedImage!, height: 150),
                  const SizedBox(height: 20),
                  state.isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () {
                            cubit.submitAddProduct();
                          },
                          child: const Text('Add Product'),
                        ),
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
