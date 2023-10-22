// ignore_for_file: non_constant_identifier_names, file_names, avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;

class User {
  final int user_id;
  final String user_email;
  final String user_name;
  final String user_password;
  final int user_miles;
  final int user_skypoints;

  User({required this.user_id, required this.user_email, required this.user_name, required this.user_password, required this.user_miles, required this.user_skypoints});

  factory User.fromMap(Map<String, dynamic> json) => User(
    user_id: int.parse(json['user_id']),
    user_email: json['user_email'],
    user_name: json['user_name'],
    user_password: json['user_password'],
    user_miles: int.parse(json['user_miles']),
    user_skypoints: int.parse(json['user_skypoints']),
  );

  Map<String, dynamic> toMap(){
    return {
      'user_id': user_id,
      'user_email': user_email,
      'user_name': user_name,
      'user_password' : user_password,
      'user_miles' : user_miles,
      'user_skypoints' : user_skypoints,
    };
  }
}

class Coupon {
  final String coupon_code;
  final int user_id;
  final int coupon_discount;
  final int coupon_expirationDate;

  Coupon({required this.coupon_code, required this.user_id, required this.coupon_discount, required this.coupon_expirationDate});

  factory Coupon.fromMap(Map<String, dynamic> json) => Coupon(
    coupon_code: json['coupon_code'],
    user_id: int.parse(json['user_id']),
    coupon_discount: int.parse(json['coupon_discount']),
    coupon_expirationDate: int.parse(json['coupon_expirationDate']),
  );

  Map<String, dynamic> toMap(){
    return {
      'coupon_code': coupon_code,
      'user_id': user_id,
      'coupon_discount': coupon_discount,
      'coupon_expirationDate': coupon_expirationDate,
    };
  }
}

class Offer {
  final int offer_id;
  final String offer_destination;
  final String offer_state;
  final int offer_price;
  final int offer_discount;
  final int offer_miles;
  final String offer_url;

  Offer({
    required this.offer_id,
    required this.offer_destination,
    required this.offer_state,
    required this.offer_price,
    required this.offer_discount,
    required this.offer_miles,
    required this.offer_url,
  });

  factory Offer.fromMap(Map<String, dynamic> json) => Offer(
    offer_id: int.parse(json['offer_id']),
    offer_destination: json['offer_destination'],
    offer_state: json['offer_state'],
    offer_price: int.parse(json['offer_price']),
    offer_discount: int.parse(json['offer_discount']),
    offer_miles: int.parse(json['offer_miles']),
    offer_url: json['offer_url'],
  );
}

class DatabaseHelper{
  String serverIp = "192.168.45.85";
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  Future<List<Offer>> getAllOffers() async {
    Uri uri = Uri.parse('http://$serverIp/skysaverapi/getAllOffers.php');
    var res = await http.get(uri, headers: {'Accept':'application/json'});
    var resultRaw = jsonDecode(res.body) as List;
    List<Offer> Users = resultRaw.isNotEmpty ? resultRaw.map((e) => Offer.fromMap(e)).toList() : [];
    return Users;
  }

  Future<String> insertNewUser(User User) async {
     Map map = {
      'user_email': User.user_email,
      'user_name': User.user_name,
      'user_password' : User.user_password,
      'user_miles' : User.user_miles.toString(),
      'user_skypoints' : User.user_skypoints.toString(),
    };

    Uri uri = Uri.parse('http://$serverIp/skysaverapi/insertNewUser.php');

    try
    {
      var response = await http.post(uri, body: map);
      var data = response.body;
      return data;
    }
    on Exception catch (_, e)
    {
      return e.toString();
    }
  }

  Future<User?> getUserByUserEmail (String user_email) async {
    final Map<String, String> queryParameters = {
      'user_email': user_email,
    };

    Uri uri = Uri.parse('http://$serverIp/skysaverapi/getUserByUserEmail.php').replace(queryParameters: queryParameters);
    var res = await http.get(uri, headers: {'Accept':'application/json'});

    if(res.body.substring(0, 10) != '[{"user_id')
    {
      return null;
    }
    else
    {
      var resultRaw = jsonDecode(res.body) as List;
      List<User> user = resultRaw.isNotEmpty ? resultRaw.map((e) => User.fromMap(e)).toList() : [];
      return user.first;
    }
  }

  Future<List<Coupon>> getCouponsByUserId(int user_id) async {
    final Map<String, String> queryParameters = {
      'user_id': user_id.toString(),
    };

    Uri uri = Uri.parse('http://$serverIp/skysaverapi/getCouponsByUserId.php').replace(queryParameters: queryParameters);
    var res = await http.get(uri, headers: {'Accept':'application/json'});

    if(res.body.substring(0, 12) != '[{"coupon_co')
    {
      return [];
    }
    else
    {
      var resultRaw = jsonDecode(res.body) as List;
      List<Coupon> coupons = resultRaw.isNotEmpty ? resultRaw.map((e) => Coupon.fromMap(e)).toList() : [];
      return coupons;
    }
  }
}