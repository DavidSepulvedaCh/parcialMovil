import 'dart:convert';

LoginResponseModel loginResponseModel(String str){
  return LoginResponseModel.fromJson(jsonDecode(str));
}

class LoginResponseModel {
    String? id;
    String? email;
    String? name;
    String? token;

    LoginResponseModel({this.name, this.token, this.email});

    LoginResponseModel.fromJson(Map<String, dynamic> json) {
        id = json['id'];
        email = json['email'];
        name = json['name'];
        token = json['token'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        data['id'] = id;
        data['email'] = email;
        data['name'] = name;
        data['token'] = token;
        return data;
    }
}