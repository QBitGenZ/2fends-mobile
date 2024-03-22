class ProductDetail {
  String? id;
  String? title;
  String? product;
  String? text;
  String? createdAt;

  ProductDetail({this.id, this.title, this.product, this.text, this.createdAt});

  ProductDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    product = json['product'];
    text = json['text'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['product'] = this.product;
    data['text'] = this.text;
    data['created_at'] = this.createdAt;
    return data;
  }
}
