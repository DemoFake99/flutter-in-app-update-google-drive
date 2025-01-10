import 'dart:io';

import 'package:flutter/material.dart';
import '../models/product_data_model.dart';
import 'package:uuid/uuid.dart';

class ProductDataProvider extends ChangeNotifier {
  // ignore: prefer_final_fields
  List<ProductDataModel> _productDataList = [];

  List<ProductDataModel> get productDataList => _productDataList;

  void createProductData(String productName, String detail, int quantity, File productImage) {
    _productDataList.add(ProductDataModel(
      id: const Uuid().v1(),
      productName: productName,
      detail: detail,
      quantity: quantity,
      productImage: productImage,
    ));
    notifyListeners();
  }

  void updateProductData(String id, String productName, String detail, int quantity) {
    final user = _productDataList.firstWhere((product) => product.id == id);
    user.productName = productName;
    user.detail = detail;
    user.quantity = quantity;
    notifyListeners();
  }

  void deleteProductData(String id) {
    _productDataList.removeWhere((product) => product.id == id);
    notifyListeners();
  }
}
