class MyEvent {
  String? id;
  String? name;
  String? description;
  String? createdAt;
  String? beginAt;
  String? endAt;
  String? image;
  String? status;
  String? user;

  MyEvent(
      {this.id,
        this.name,
        this.description,
        this.createdAt,
        this.beginAt,
        this.endAt,
        this.image,
        this.status,
        this.user});

  MyEvent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    createdAt = json['created_at'];
    beginAt = json['beginAt'];
    endAt = json['endAt'];
    image = json['image'];
    status = json['status'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['beginAt'] = this.beginAt;
    data['endAt'] = this.endAt;
    data['image'] = this.image;
    data['status'] = this.status;
    data['user'] = this.user;
    return data;
  }
}
