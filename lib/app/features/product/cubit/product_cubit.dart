import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shop_management_app/main.dart';
import 'package:shop_management_app/models/product_model.dart';
import 'package:shop_management_app/repository/product_repo.dart';
import 'package:shop_management_app/utils/console_log.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit(this._productRepository) : super(ProductInitial());

  final ProductRepository _productRepository;

  void init() {
    loadProducts(kUserId);
  }

  void loadProducts(String userId) {
    emit(ProductLoading());
    _productRepository.getProducts(userId).listen((products) {
      emit(ProductLoaded(products));
    }, onError: (error, stackTrace) {
      consoleLog("Error on getting products",
          error: error, stackTrace: stackTrace);
      emit(ProductError(error.toString()));
    });
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
