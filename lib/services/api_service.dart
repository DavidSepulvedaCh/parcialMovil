import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:parcial/config.dart';
import 'package:parcial/models/login_response_model.dart';
import 'package:parcial/models/login_request_model.dart';
import 'package:parcial/services/shared_service.dart';
import 'package:parcial/models/products.dart';

class APIService {
  static Future<int> login(LoginRequestModel model) async {
    Uri url = Uri.http(Config.apiURL, Config.loginAPI);
    final header = {
      "Access-Control-Allow-Origin": "*",
      'Content-Type': 'application/json',
      'Accept': '*/*'
    };
    final dataBody = json.encode(model.toJson());
    try {
      final response = await http
          .post(url, headers: header, body: dataBody)
          .timeout(const Duration(seconds: 5));
      if (response.statusCode == 200) {
        await SharedService.setLogginDetails(loginResponseModel(response.body));
        return 0;
      } else {
        return 1;
      }
    } catch (e) {
      return 2;
    }
  }

  static Future<bool> isValidToken(String token) async {
    Uri url = Uri.http(Config.apiURL, Config.isValidTokenAPI);
    final header = {
      "Access-Control-Allow-Origin": "*",
      'Content-Type': 'application/json',
      'Accept': '*/*'
    };
    final response = await http
        .post(url, headers: header, body: jsonEncode({'token': token}))
        .timeout(const Duration(seconds: 5));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<List<Product>> getProducts() async {
    Uri url = Uri.http(Config.apiURL, Config.getProducts);
    final header = {
      "Access-Control-Allow-Origin": "*",
      'Content-Type': 'application/json',
      'Accept': '*/*'
    };
    var token = SharedService.prefs.getString('token');
    final response = await http
        .post(url, headers: header, body: jsonEncode({'token': token}))
        .timeout(const Duration(seconds: 5));
    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      List<Product> productList = jsonList
          .map((json) => Product(
              name: json['name'],
              description: json['description'],
              photo: json['photo'],
              price: json['price'].toDouble()))
          .toList();
      return productList;
    } else {
      return [];
    }
  }
}
