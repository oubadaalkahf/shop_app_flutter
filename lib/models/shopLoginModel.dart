class ShopLoginModel {
  bool? status;
  String? message;
  UserData? data;

  ShopLoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = (json['data'] != null ? UserData.fromJson(json['data']) : null);
  }
}

class UserData {
  int? id;
  int? credit;
  int? points;
  String? token;
  String? name;
  String? email;
  String? phone;

  UserData(
      {required this.email,
      required this.id,
      required this.name,
      required this.credit,
      required this.phone,
      required this.points,
      required this.token});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    credit = json['credit'];
    phone = json['phone'];
    points = json['points'];
    token = json['token'];
    email = json['email'];
  }
}
