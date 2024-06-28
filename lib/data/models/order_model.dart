import 'package:shop_management_app/data/models/product_model.dart';

class OrderModel {
  final String id;
  final String customerName;
  final List<Product> products;
  final String status;
  final double totalPrice;
  final DateTime orderDate;
  final String tableNumber;
  final String userId;
  final String orderType;

  OrderModel({
    required this.id,
    required this.customerName,
    required this.products,
    required this.status,
    required this.totalPrice,
    required this.orderDate,
    required this.tableNumber,
    required this.userId,
    required this.orderType,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customerName': customerName,
      'products': products.map((product) => product.toMap()).toList(),
      'status': status,
      'totalPrice': totalPrice,
      'orderDate': orderDate.toIso8601String(),
      'tableNumber': tableNumber,
      'userId': userId,
      'orderType': orderType,
    };
  }

  factory OrderModel.fromMap(String id, Map<String, dynamic> map) {
    return OrderModel(
      id: id,
      customerName: map['customerName'] ?? "",
      products: map['products'] != null
          ? List<Product>.from(
              map['products']
                  ?.map((productMap) => Product.fromMap(map['id'], productMap)),
            )
          : [],
      status: map['status'] ?? "",
      totalPrice: map['totalPrice'] ?? "",
      orderDate: map['orderDate'] != null
          ? DateTime.parse(map['orderDate'])
          : DateTime.now(),
      tableNumber: map['tableNumber'],
      userId: map['userId'] ?? "",
      orderType: map['orderType'] ?? '',
    );
  }
}
