import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_management_app/app/features/orders/cubit/order_cubit.dart';
import 'package:shop_management_app/app/widgets/custom_text_field.dart';
import 'package:shop_management_app/main.dart';
import 'package:shop_management_app/services/navigation_services/route_names.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderCubit = BlocProvider.of<OrderCubit>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
        actions: [
          DropdownButton<String>(
            icon: const Icon(Icons.filter_list),
            onChanged: (String? value) {
              if (value != null) {
                orderCubit.sortOrders(value);
              }
            },
            items: const [
              DropdownMenuItem(
                value: 'Date Ascending',
                child: Text('Date Ascending'),
              ),
              DropdownMenuItem(
                value: 'Date Descending',
                child: Text('Date Descending'),
              ),
              DropdownMenuItem(
                value: 'Total Price Ascending',
                child: Text('Total Price - Low to High'),
              ),
              DropdownMenuItem(
                value: 'Total Price Descending',
                child: Text('Total Price - High to Low'),
              ),
            ],
          ),
          SizedBox(width: 10.w),
          DropdownButton<String>(
            icon: const Icon(Icons.filter_alt),
            onChanged: (String? value) {
              if (value != null) {
                orderCubit.filterByStatus(value);
              }
            },
            items: const [
              DropdownMenuItem(
                value: 'All',
                child: Text('All'),
              ),
              DropdownMenuItem(
                value: 'Pending',
                child: Text('Pending'),
              ),
              DropdownMenuItem(
                value: 'Completed',
                child: Text('Completed'),
              ),
              DropdownMenuItem(
                value: 'Cancelled',
                child: Text('Cancelled'),
              ),
            ],
          ),
          SizedBox(width: 10.w),
        ],
      ),
      body: BlocBuilder<OrderCubit, OrderState>(
        builder: (context, state) {
          if (state is OrderLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is OrderLoaded) {
            final orders = state.orders;
            return Container(
              padding: EdgeInsets.only(left: 16.w, right: 16.w),
              child: Column(
                children: [
                  CustomTextField(
                    controller: orderCubit.searchController,
                    hint: "Search order by customer name or product name",
                    label: "Search",
                    onChanged: (query) {
                      orderCubit.searchOrders();
                    },
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: orders.length,
                      itemBuilder: (context, index) {
                        final order = orders[index];
                        return Column(
                          children: [
                            ListTile(
                              title: Text('Customer: ${order.customerName}'),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Total: ₹${order.totalPrice}'),
                                  Text('Status: ${order.status}'),
                                  Text(
                                      'Date: ${order.orderDate.toString().split(':').first}'),
                                  ...order.products.map(
                                    (product) => ListTile(
                                      leading: Image.network(
                                        product.imageUrl,
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                      ),
                                      title: Text(product.name),
                                      subtitle: Text(
                                          '₹${product.price} x ${product.quantity}'),
                                    ),
                                  ),
                                ],
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: order.status == 'Completed' ||
                                            order.status == 'Cancelled'
                                        ? null
                                        : () {
                                            _showUpdateStatusDialog(
                                                context,
                                                orderCubit,
                                                order.id,
                                                order.status);
                                          },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      orderCubit.deleteOrder(order.id);
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
            return const Center(child: Text('Error loading orders'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(RouteNames.addOrders).then(
                (value) => orderCubit.loadOrders(kUserId),
              );
        },
      ),
    );
  }

  void _showUpdateStatusDialog(BuildContext context, OrderCubit cubit,
      String orderId, String currentStatus) {
    showDialog(
      context: context,
      builder: (context) {
        String newStatus = currentStatus;
        return AlertDialog(
          title: const Text('Update Order Status'),
          content: DropdownButton<String>(
            value: newStatus,
            onChanged: (String? value) {
              if (value != null) {
                newStatus = value;
              }
            },
            items: ['Pending', 'Completed', 'Cancelled'].map((String status) {
              return DropdownMenuItem<String>(
                value: status,
                child: Text(status),
              );
            }).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                cubit.updateOrderStatus(orderId, newStatus);
                Navigator.of(context).pop();
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }
}
