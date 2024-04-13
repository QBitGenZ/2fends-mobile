import 'package:fends_mobile/models/product.dart';

class CartItem {
  String? id;
  Product? product;
  int? quantity;

  CartItem({ this.id,  this.product,  this.quantity});

  CartItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product =
    (json['product'] != null ? new Product.fromJson(json['product']) : null)!;
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    data['quantity'] = this.quantity;
    return data;
  }
}
