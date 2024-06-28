import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_management_app/data/models/product_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shop_management_app/utils/console_log.dart';

class ProductRepository {
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  ProductRepository(this._firestore, this._storage);

  Future<void> addProduct(Product product, String userId) async {
    try {
      consoleLog('Attempting to add product for user: $userId',
          name: 'ProductRepository');
      await _firestore.collection('products').add(product.toMap());
      consoleLog('Product added successfully', name: 'ProductRepository');
    } catch (e) {
      consoleLog('Add product failed: ${e.toString()}',
          name: 'ProductRepository', error: e);
      throw Exception(e.toString());
    }
  }

  Stream<List<Product>> getProducts(String userId) {
    consoleLog('Fetching products for user: $userId',
        name: 'ProductRepository');
    return _firestore
        .collection('products')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Product.fromMap(doc.id, doc.data()))
          .toList();
    });
  }

  Future<void> deleteProduct(String productId) async {
    try {
      consoleLog('Attempting to delete product with ID: $productId',
          name: 'ProductRepository');
      await _firestore.collection('products').doc(productId).delete();
      consoleLog('Product deleted successfully', name: 'ProductRepository');
    } catch (e) {
      consoleLog('Delete product failed: ${e.toString()}',
          name: 'ProductRepository', error: e);
      throw Exception(e.toString());
    }
  }

  Future<void> editProduct(Product product) async {
    try {
      consoleLog('Attempting to edit product with ID: ${product.id}',
          name: 'ProductRepository');
      await _firestore
          .collection('products')
          .doc(product.id)
          .update(product.toMap());
      consoleLog('Product edited successfully', name: 'ProductRepository');
    } catch (e, stackTrace) {
      consoleLog('Edit product failed: ${e.toString()}',
          name: 'ProductRepository', error: e, stackTrace: stackTrace);
      throw Exception(e.toString());
    }
  }

  Future<String> uploadImage(String path) async {
    try {
      consoleLog('Attempting to upload image from path: $path',
          name: 'ProductRepository');
      File file = File(path);
      TaskSnapshot snapshot = await _storage
          .ref()
          .child('product_images/${file.uri.pathSegments.last}')
          .putFile(file);
      String downloadURL = await snapshot.ref.getDownloadURL();
      consoleLog('Image uploaded successfully, URL: $downloadURL',
          name: 'ProductRepository');
      return downloadURL;
    } catch (e) {
      consoleLog('Upload image failed: ${e.toString()}',
          name: 'ProductRepository', error: e);
      throw Exception(e.toString());
    }
  }
}
