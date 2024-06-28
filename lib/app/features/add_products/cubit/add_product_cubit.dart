import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_management_app/main.dart';
import 'package:shop_management_app/data/models/product_model.dart';
import 'package:shop_management_app/data/repository/product_repo.dart';
import 'package:shop_management_app/utils/console_log.dart';

part 'add_product_state.dart';

class AddProductCubit extends Cubit<AddProductState> {
  AddProductCubit(this._productRepository, this.product)
      : super(const AddProductInitial(isLoading: false)) {
    init();
  }
  final ProductRepository _productRepository;
  Product? product;

  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late TextEditingController priceController;
  late TextEditingController categoryController;
  late GlobalKey<FormState> formKey;
  File? pickedImage;
  String imageUrl = "";
  String productId = "";
  bool isAvailable = true;

  void init() {
    if (product != null) {
      nameController = TextEditingController(text: product!.name);
      descriptionController = TextEditingController(text: product!.description);
      priceController = TextEditingController(text: product!.price.toString());
      categoryController = TextEditingController(text: product!.category);
      imageUrl = product!.imageUrl;
      productId = product!.id;
      isAvailable = product!.isAvailable;
      consoleLog(product!.id);
    } else {
      nameController = TextEditingController();
      descriptionController = TextEditingController();
      priceController = TextEditingController();
      categoryController = TextEditingController();
    }

    formKey = GlobalKey<FormState>();
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
    if (formKey.currentState!.validate()) {
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
            isAvailable: true,
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
  }

  Future<void> submitEditProduct() async {
    if (formKey.currentState!.validate()) {
      try {
        emit(const AddProductInitial(isLoading: true));
        late Product product;
        if (imageUrl.isNotEmpty && pickedImage != null) {
          final imageUrl = await uploadImage(pickedImage!.path);
          product = Product(
            isAvailable: isAvailable,
            id: productId, // Firestore will generate this
            quantity: 0,
            name: nameController.text.trim(),
            description: descriptionController.text.trim(),
            price: double.parse(priceController.text.trim()),
            category: categoryController.text.trim(),
            imageUrl: imageUrl,
            userId: kUserId,
          );
        } else {
          product = Product(
            isAvailable: isAvailable,
            id: productId, // Firestore will generate this
            quantity: 0,
            name: nameController.text.trim(),
            description: descriptionController.text.trim(),
            price: double.parse(priceController.text.trim()),
            category: categoryController.text.trim(),
            imageUrl: imageUrl,
            userId: kUserId,
          );
        }
        await updateProduct(product);
        emit(ProductAdded());
      } catch (error, stackTrace) {
        consoleLog("Error while adding product",
            error: error, stackTrace: stackTrace);
        emit(ProductError(error.toString()));
      } finally {
        emit(const AddProductInitial(isLoading: false));
      }
    }
  }

  Future<void> addProduct(Product product, String userId) async {
    try {
      await _productRepository.addProduct(product, userId);
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  Future<void> updateProduct(Product product) async {
    try {
      await _productRepository.editProduct(product);
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  void toggleAvailability() {
    isAvailable = !isAvailable;
    emit(const AddProductInitial(isLoading: false));
  }

  Future<String> uploadImage(String path) async {
    try {
      return await _productRepository.uploadImage(path);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> close() {
    nameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    categoryController.dispose();
    return super.close();
  }
}
