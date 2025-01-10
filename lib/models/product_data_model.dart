import 'dart:io';

class ProductDataModel {
  String id;
  String productName;
  String detail;
  int quantity;
  File productImage;

  ProductDataModel({
    required this.id,
    required this.productName,
    required this.detail,
    required this.quantity,
    required this.productImage,
  });
}
