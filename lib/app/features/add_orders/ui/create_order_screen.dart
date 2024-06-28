import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_management_app/app/features/add_orders/cubit/createorder_cubit.dart';
import 'package:shop_management_app/app/features/product/cubit/product_cubit.dart';
import 'package:shop_management_app/app/widgets/custom_text_field.dart';

class CreateOrderScreen extends StatelessWidget {
  const CreateOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ProductCubit>(context);
    final orderCubit = BlocProvider.of<CreateOrderCubit>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Order'),
      ),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductLoaded) {
            final products = state.products;
            return BlocConsumer<CreateOrderCubit, CreateOrderState>(
              listener: (context, state) {
                if (state is CreateOrderCompleted) {
                  Navigator.pop(context);
                }
              },
              builder: (context, state) {
                if (state is CreateOrderInitial ||
                    state is CreateOrderUpdated) {
                  return Container(
                    height: MediaQuery.of(context).size.height,
                    padding: EdgeInsets.only(left: 16.w, right: 16.w),
                    child: Column(
                      children: [
                        CustomTextField(
                          label: 'Search',
                          hint: "Search your products",
                          controller: cubit.searchController,
                          onChanged: (query) {
                            cubit.searchProducts(query);
                          },
                        ),
                        SizedBox(height: 10.h),
                        Expanded(
                          child: ListView.builder(
                            itemCount: products.length,
                            itemBuilder: (context, index) {
                              final product = products[index];
                              final isSelected = orderCubit.selectedProducts
                                  .any((selectedProduct) =>
                                      selectedProduct.id == product.id);

                              return ListTile(
                                leading: Image.network(
                                  product.imageUrl,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ),
                                title: Text(product.name),
                                subtitle: Text('\$${product.price}'),
                                trailing: SizedBox(
                                  width: 150.w,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        width: 10,
                                        height: 10,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: product.isAvailable
                                              ? Colors.green
                                              : Colors.red,
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.remove),
                                        onPressed: isSelected
                                            ? () => orderCubit
                                                .decreaseQuantity(product)
                                            : null,
                                      ),
                                      Text(
                                        isSelected
                                            ? orderCubit.selectedProducts
                                                .firstWhere(
                                                  (p) => p.id == product.id,
                                                  orElse: () => product
                                                      .copyWith(quantity: 1),
                                                )
                                                .quantity
                                                .toString()
                                            : '0',
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.add),
                                        onPressed: isSelected
                                            ? () => orderCubit
                                                .increaseQuantity(product)
                                            : null,
                                      ),
                                      SizedBox(width: 10.w),
                                      Checkbox(
                                        value: isSelected,
                                        onChanged: (selected) {
                                          orderCubit.selectProduct(product);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return const SizedBox();
              },
            );
          } else {
            return const Center(
              child: Text('Error loading products'),
            );
          }
        },
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          if (orderCubit.selectedProducts.isNotEmpty) {
            _showCustomerDetailsBottomSheet(context, orderCubit);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Please select a product"),
              ),
            );
          }
        },
        child: Container(
          alignment: Alignment.center,
          height: 50.h,
          color: Colors.blue,
          child: const Text(
            "Confirm",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  void _showCustomerDetailsBottomSheet(
      BuildContext context, CreateOrderCubit cubit) {
    showModalBottomSheet(
      isScrollControlled: true, 
      context: context,
      builder: (context) {
        return BlocProvider.value(
          value: cubit,
          child: BlocBuilder<CreateOrderCubit, CreateOrderState>(
            builder: (context, state) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context)
                      .viewInsets
                      .bottom, 
                  left: 16.0,
                  right: 16.0,
                  top: 16.0,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomTextField(
                        label: 'Customer Name',
                        hint: 'Enter Customer Name',
                        controller: cubit.nameController,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Radio(
                            value: 'Dine In',
                            groupValue: cubit.orderType,
                            onChanged: (value) {
                              cubit.updateOrderType(value!);
                            },
                          ),
                          const Text('Dine In'),
                          Radio(
                            value: 'Take Away',
                            groupValue: cubit.orderType,
                            onChanged: (value) {
                              cubit.updateOrderType(value!);
                            },
                          ),
                          const Text('Take Away'),
                        ],
                      ),
                      if (cubit.orderType == 'Dine In')
                        CustomTextField(
                          label: 'Table Number',
                          hint: 'Enter Table Number',
                          controller: cubit.tableNumberController,
                          keyboardType: TextInputType.number,
                        ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          cubit.submitCreatOrder();
                        },
                        child: const Text('Submit'),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
