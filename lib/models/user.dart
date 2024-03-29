import 'dart:ui';

class User {
  String? username;
  String? password;
  String? email;
  String? full_name;
  DateTime? birthday;
  bool? is_female;
  String? phone;
  String? avatar;
  String? status;
  String? description;
  bool? is_staff;
  bool? is_seller;
  bool? is_philanthropist;

  User({
    this.username,
    this.password,
    this.email,
    this.full_name,
    this.birthday,
    this.is_female,
    this.phone,
    this.avatar,
    this.status,
    this.description,
    this.is_philanthropist,
    this.is_seller,
    this.is_staff,
  });

  User.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    email = json['email'];
    full_name = json['full_name'];
    if (json['birthday'] != null) {
      birthday = DateTime.parse(json['birthday']);
    }
    is_female = json['is_female'];
    phone = json['phone'];
    if (json['avatar'] != null) {
      avatar = json['avatar'];
    }
    status = json['status'];
    description = json['description'];
    is_staff = json['is_staff'];
    is_seller = json['is_seller'];
    is_philanthropist = json['is_philanthropist'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['username'] = username;
    data['password'] = password;
    data['email'] = email;
    data['full_name'] = full_name;
    if (birthday != null) {
      data['birthday'] = birthday!.toIso8601String();
    }
    data['is_female'] = is_female;
    data['phone'] = phone;
    if (avatar != null) {
      data['avatar'] = avatar!;
    }
    data['status'] = status;
    data['description'] = description;
    data['is_staff'] = is_staff;
    data['is_seller'] = is_seller;
    data['is_philanthropist'] = is_philanthropist;
    return data;
  }


}
