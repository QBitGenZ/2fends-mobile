class ProductImage {
  String? alt;
  String? src;
  String? createdAt;
  String? product;

  ProductImage({this.alt, this.src, this.createdAt, this.product});

  ProductImage.fromJson(Map<String, dynamic> json) {
    alt = json['alt'];
    src = json['src'];
    createdAt = json['created_at'];
    product = json['product'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['alt'] = this.alt;
    data['src'] = this.src;
    data['created_at'] = this.createdAt;
    data['product'] = this.product;
    return data;
  }
}
