import 'package:fends_mobile/models/product_detail.dart';
import 'package:fends_mobile/models/product_feedback.dart';
import 'package:fends_mobile/models/product_image.dart';
import 'package:fends_mobile/models/product_image.dart';
import 'package:fends_mobile/models/product_image.dart';


class Product {
  String? id;
  String? name;
  int? quantity;
  double? price;
  String? productType;
  List<ProductDetail>? productDetail;
  List<ProductImage>? productImage;
  String? createdAt;
  String? user;
  List<ProductFeedback>? productFeedback;
  String? status;
  String? size;
  String? description;

  Product(
      {this.id,
        this.name,
        this.quantity,
        this.price,
        this.productType,
        this.productDetail,
        this.productImage,
        this.createdAt,
        this.user,
        this.productFeedback,
        this.status,
        this.size,
        this.description
      });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    quantity = json['quantity'];
    price = json['price'];
    productType = json['product_type'];
    if (json['product_detail'] != null) {
      productDetail = <ProductDetail>[];
      json['product_detail'].forEach((v) {
        productDetail!.add(new ProductDetail.fromJson(v));
      });
    }
    if (json['product_image'] != null) {
      productImage = <ProductImage>[];
      json['product_image'].forEach((v) {
        productImage!.add(new ProductImage.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    user = json['user'];
    if (json['product_feedback'] != null) {
      productFeedback = <ProductFeedback>[];
      json['product_feedback'].forEach((v) {
        productFeedback!.add(new ProductFeedback.fromJson(v));
      });
    }
    status = json['status'];
    size = json['size'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['product_type'] = this.productType;
    if (this.productDetail != null) {
      data['product_detail'] =
          this.productDetail!.map((v) => v.toJson()).toList();
    }
    if (this.productImage != null) {
      data['product_image'] =
          this.productImage!.map((v) => v.toJson()).toList();
    }
    data['created_at'] = this.createdAt;
    data['user'] = this.user;
    if (this.productFeedback != null) {
      data['product_feedback'] =
          this.productFeedback!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['size'] = this.size;
    data['description'] = this.description;
    return data;
  }
}
