import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_management_app/data/models/order_model.dart';
import 'package:shop_management_app/utils/console_log.dart';

class OrderRepository {
  final FirebaseFirestore _firestore;

  OrderRepository(this._firestore);

  Future<void> addOrder(OrderModel order) async {
    try {
      consoleLog('Attempting to add order for user: ${order.userId}',
          name: 'OrderRepository');
      await _firestore.collection('orders').add(order.toMap());
      consoleLog('Order added successfully', name: 'OrderRepository');
    } catch (e) {
      consoleLog('Add order failed: ${e.toString()}',
          name: 'OrderRepository', error: e);
      throw Exception(e.toString());
    }
  }

  Stream<List<OrderModel>> getOrders(String userId) {
    consoleLog('Fetching orders for user: $userId', name: 'OrderRepository');
    return _firestore
        .collection('orders')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => OrderModel.fromMap(doc.id, doc.data()))
          .toList();
    });
  }

  Future<void> updateOrderStatus(String orderId, String status) async {
    try {
      consoleLog(
          'Attempting to update order status for order ID: $orderId to $status',
          name: 'OrderRepository');
      await _firestore
          .collection('orders')
          .doc(orderId)
          .update({'status': status});
      consoleLog('Order status updated successfully', name: 'OrderRepository');
    } catch (e) {
      consoleLog('Update order status failed: ${e.toString()}',
          name: 'OrderRepository', error: e);
      throw Exception(e.toString());
    }
  }

  Future<void> deleteOrder(String orderId) async {
    try {
      consoleLog('Attempting to delete order with order ID: $orderId',
          name: 'OrderRepository');
      await _firestore.collection('orders').doc(orderId).delete();
      consoleLog('Order deleted successfully', name: 'OrderRepository');
    } catch (e) {
      consoleLog('Delete order failed: ${e.toString()}',
          name: 'OrderRepository', error: e);
      throw Exception(e.toString());
    }
  }
}
