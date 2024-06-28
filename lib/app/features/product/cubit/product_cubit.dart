import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shop_management_app/main.dart';
import 'package:shop_management_app/data/models/product_model.dart';
import 'package:shop_management_app/data/repository/product_repo.dart';
import 'package:shop_management_app/utils/console_log.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit(this._productRepository) : super(ProductInitial()) {
    init();
  }

  final ProductRepository _productRepository;

  late TextEditingController searchController;
  List<Product> _allProducts = [];

  void init() {
    searchController = TextEditingController();
    loadProducts(kUserId);
  }

  void loadProducts(String userId) {
    emit(ProductLoading());
    _productRepository.getProducts(userId).listen((products) {
      _allProducts = products;
      emit(ProductLoaded(products));
    }, onError: (error, stackTrace) {
      consoleLog("Error on getting products",
          error: error, stackTrace: stackTrace);
      emit(ProductError(error.toString()));
    });
  }

  void searchProducts(String query) {
    emit(ProductLoading());
    if (query.isEmpty) {
      emit(ProductLoaded(_allProducts));
    } else {
      final filteredProducts = _allProducts
          .where((product) =>
              product.name.toLowerCase().contains(query.toLowerCase()) ||
              product.description.toLowerCase().contains(query.toLowerCase()))
          .toList();
      emit(ProductLoaded(filteredProducts));
    }
  }

  Future<void> addProduct(Product product, String userId) async {
    try {
      await _productRepository.addProduct(product, userId);
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  Future<void> deleteProduct(String productId) async {
    try {
      await _productRepository.deleteProduct(productId);
      emit(ProductLoaded(_allProducts));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  Future<String> uploadImage(String path) async {
    try {
      return await _productRepository.uploadImage(path);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
