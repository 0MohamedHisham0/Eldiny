class SignUpModel {
  String? status;
  String? message;
  UserData? data;

  SignUpModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }

}

class UserData {
  int? id;
  String? email;
  String? password;
  String? name;
  bool? isHidden;
  String? phone;
  int? otp;
  int? finishedPage;
  int? lastPage;
  String? role;

  // named constructor
  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    password = json['password'];
    name = json['name'];
    email = json['email'];
    isHidden = json['isHidden'];
    otp = json['otp'];
    finishedPage = json['finishedPage'];
    lastPage = json['lastPage'];
    role = json['role'];
  }
}
