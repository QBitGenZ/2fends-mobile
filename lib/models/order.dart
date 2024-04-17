import 'order_item.dart';

class Order {
  String? id;
  String? user;
  String? address;
  String? paymentMethod;
  String? createdAt;
  List<OrderItem>? items;
  String? status;

  Order(
      {this.id,
        this.user,
        this.address,
        this.paymentMethod,
        this.createdAt,
        this.items,
        this.status});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    address = json['address'];
    paymentMethod = json['payment_method'];
    createdAt = json['created_at'];
    if (json['items'] != null) {
      items = <OrderItem>[];
      json['items'].forEach((v) {
        items!.add(new OrderItem.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user'] = this.user;
    data['address'] = this.address;
    data['payment_method'] = this.paymentMethod;
    data['created_at'] = this.createdAt;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

