import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_management_app/app/features/dashboard/cubit/dashboard_cubit.dart';
import 'package:shop_management_app/services/navigation_services/navigation_services.dart';
import 'package:shop_management_app/services/navigation_services/route_names.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<DashboardCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              cubit.signOut();
              context.navigationService.createLoginPageRoute(context);
            },
          ),
        ],
      ),
      body: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
          if (state is DashboardInitial) {
            if (state.orders == null) {
              return const Center(child: CircularProgressIndicator());
            } else {
              final orders = state.orders;

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 350.w,
                      height: 200.h,
                      padding:
                          EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.sp),
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0, 2),
                          ),
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(2, 0),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              DahsboardCard(
                                color: Colors.white,
                                title: 'Total Orders:\n ${orders!.length}',
                              ),
                              SizedBox(width: 20.w),
                              DahsboardCard(
                                color: Colors.white,
                                title:
                                    'Today\'s Orders:\n ${cubit.todayOrders}',
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h),
                          Container(
                            height: 60.h,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.sp)),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0, 2),
                                ),
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(2, 0),
                                ),
                              ],
                            ),
                            child: Text(
                              'Today\'s Order Amount:\n ₹${cubit.todayOrderAmount.toStringAsFixed(2)}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        DahsboardCard(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(RouteNames.products)
                                .then((value) => cubit.init());
                          },
                          color: Colors.lightBlue,
                          title: "Products",
                        ),
                        SizedBox(width: 20.w),
                        DahsboardCard(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(RouteNames.orders)
                                .then((value) => cubit.init());
                          },
                          color: Colors.lightBlueAccent,
                          title: "Orders",
                        ),
                      ],
                    ),
                    const Divider(),
                    Expanded(
                      child: ListView.builder(
                        itemCount: cubit.todaysOrderList.length,
                        itemBuilder: (context, index) {
                          final order = cubit.todaysOrderList[index];
                          return Column(
                            children: [
                              ListTile(
                                title: Text(order.customerName),
                                subtitle: Text(
                                    'Total: ₹${order.totalPrice.toStringAsFixed(2)}'),
                                trailing: Text(order.status),
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
            }
          } else {
            return const Center(
              child: Text('Error loading orders'),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .pushNamed(RouteNames.addOrders)
              .then((value) => cubit.init);
        },
      ),
    );
  }
}

class DahsboardCard extends StatelessWidget {
  const DahsboardCard({
    super.key,
    required this.title,
    required this.color,
    this.onTap,
  });
  final String title;
  final Color color;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 60.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.all(Radius.circular(15.sp)),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0, 2),
              ),
              BoxShadow(
                color: Colors.grey,
                offset: Offset(2, 0),
              ),
            ],
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
