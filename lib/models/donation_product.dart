import 'package:fends_mobile/models/product.dart';

class DonationProduct {
  String? id;
  Product? product;
  int? quantity;
  String? event;

  DonationProduct({this.id, this.product, this.quantity, this.event});

  DonationProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product =
    json['product'] != null ? Product.fromJson(json['product']) : null;
    quantity = json['quantity'];
    event = json['event'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    data['quantity'] = this.quantity;
    data['event'] = this.event;
    return data;
  }
}