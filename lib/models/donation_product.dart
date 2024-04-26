class DonationProduct {
  String? id;
  int? quantity;
  String? product;
  String? event;

  DonationProduct({this.id, this.quantity, this.product, this.event});

  DonationProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    product = json['product'];
    event = json['event'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['quantity'] = this.quantity;
    data['product'] = this.product;
    data['event'] = this.event;
    return data;
  }
}
