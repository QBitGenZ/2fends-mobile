class Address {
  String? id;
  String? address;
  String? user;

  Address({this.id, this.address, this.user});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    address = json['address'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['address'] = this.address;
    data['user'] = this.user;
    return data;
  }
}
