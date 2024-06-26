import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_management_app/main.dart';
import 'package:shop_management_app/models/product_model.dart';
import 'package:shop_management_app/repository/product_repo.dart';
import 'package:shop_management_app/utils/console_log.dart';

part 'add_product_state.dart';

class AddProductCubit extends Cubit<AddProductState> {
  AddProductCubit(this._productRepository)
      : super(const AddProductInitial(isLoading: false));
  final ProductRepository _productRepository;

  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late TextEditingController priceController;
  late TextEditingController categoryController;
  late File? pickedImage;

  void init() {
    nameController = TextEditingController();
    descriptionController = TextEditingController();
    priceController = TextEditingController();
    categoryController = TextEditingController();
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      pickedImage = File(pickedFile.path);
      emit(const AddProductInitial(isLoading: false));
    }
  }

  Future<void> submitAddProduct() async {
    try {
      emit(const AddProductInitial(isLoading: true));

      if (pickedImage != null) {
        final imageUrl = await uploadImage(pickedImage!.path);

        final product = Product(
          id: '', // Firestore will generate this
          quantity: 0,
          name: nameController.text.trim(),
          description: descriptionController.text.trim(),
          price: double.parse(priceController.text.trim()),
          category: categoryController.text.trim(),
          imageUrl: imageUrl,
          userId: kUserId,
        );

        await addProduct(product, kUserId);
      }
      emit(ProductAdded());
    } catch (error, stackTrace) {
      consoleLog("Error while adding product",
          error: error, stackTrace: stackTrace);
      emit(ProductError(error.toString()));
    } finally {
      emit(const AddProductInitial(isLoading: false));
    }
  }

  Future<void> addProduct(Product product, String userId) async {
    try {
      await _productRepository.addProduct(product, userId);
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
