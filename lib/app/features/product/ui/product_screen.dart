import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_management_app/app/features/product/cubit/product_cubit.dart';
import 'package:shop_management_app/app/widgets/custom_text_field.dart';
import 'package:shop_management_app/main.dart';
import 'package:shop_management_app/services/navigation_services/route_names.dart';
import 'package:shop_management_app/utils/common_methodes.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ProductCubit>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductLoaded) {
            final products = state.products;

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
                        return Column(
                          children: [
                            ListTile(
                              leading: Image.network(
                                product.imageUrl,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                              title: Text(product.name),
                              subtitle: Text('₹${product.price}'),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
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
                                    icon: const Icon(Icons.edit),
                                    onPressed: () {
                                      // Navigate to edit screen or trigger edit function
                                      Navigator.of(context)
                                          .pushNamed(RouteNames.addProduct,
                                              arguments: product)
                                          .then(
                                            (value) =>
                                                cubit.loadProducts(kUserId),
                                          );
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      showConfirmationDialog(
                                        context: context,
                                        title: 'Delete Product',
                                        content:
                                            'Are you sure you want to delete this product?',
                                        onConfirmed: () {
                                          cubit.deleteProduct(product.id);
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const Divider(),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: Text('Error loading products'),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(RouteNames.addProduct).then(
                (value) => cubit.loadProducts(kUserId),
              );
        },
      ),
    );
  }
}
