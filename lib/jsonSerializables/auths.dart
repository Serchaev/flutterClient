// import './PositionModel.dart';
import 'dart:convert';

// import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';

// import '../main.dart';
import 'connect.dart';

part 'auths.g.dart';


@JsonSerializable()
class Auths {
  String accessToken;
  String refreshToken;
  User user;

  Auths({required this.accessToken, required this.refreshToken, required this.user});

  factory Auths.fromJson(Map<String, dynamic> json) => _$AuthsFromJson(json);

  Map<String, dynamic> toJson() => _$AuthsToJson(this);
}

@JsonSerializable()
class User {
  String userId;
  List<String> userRole;

  User({required this.userId, required this.userRole});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

Future<Auths> getNewTokens(String refreshToken) async {
  // var headers = {
  //   'Content-Type': 'application/json'
  // };
  // var request = http.Request('POST', Uri.parse('http://192.168.0.25:8000/auth/refresh'));
  // request.body = json.encode({
  //   "refreshToken": refreshToken
  // });
  // request.headers.addAll(headers);
  // final response = await request.send();
  // if (response.statusCode == 200) {
  //   print(await response.);
  // }


  var url = Uri.parse('http://$IP_ADDRESS:$PORT/auth/refresh');
  Map<String,String> headers = {
    'Content-Type': 'application/json'
  };
  var body = json.encode({"refreshToken": refreshToken});
  // final jsonStr = {"refreshToken": refreshToken};
  final response = await http.post(
      url,
      headers: headers,
      body: body
  );

  // print("response ???");
  // print("response ${response.statusCode}");
  if(response.statusCode == 200) {
    // print("response 200");
    // print("response body ${response.body}");
    return Auths.fromJson(json.decode(response.body));
    // return Auths.fromJson((await response.stream.bytesToString()) as Map<String, dynamic>);
  } else {
    throw Exception("Error: ${response.reasonPhrase}");
  }
}

Future<Auths> login(String login, String password) async {
  var url = Uri.parse('http://$IP_ADDRESS:$PORT/auth/login');
  Map<String,String> headers = {
    'Content-Type': 'application/json'
  };
  var body = json.encode({
    "name": login,
    "password": password
  });
  // final jsonStr = {"refreshToken": refreshToken};
  final response = await http.post(
      url,
      headers: headers,
      body: body
  );

  // print("response ???");
  // print("response ${response.statusCode}");
  if(response.statusCode == 200) {
    // print("response 200");
    // print("response body ${response.body}");
    return Auths.fromJson(json.decode(response.body));
    // return Auths.fromJson((await response.stream.bytesToString()) as Map<String, dynamic>);
  } else {
    throw Exception("Error: ${response.reasonPhrase}");
  }
}

Future<Auths> registration(String name, String email, String password) async {
  var url = Uri.parse('http://$IP_ADDRESS:$PORT/auth/registration');
  Map<String,String> headers = {
    'Content-Type': 'application/json'
  };
  var body = json.encode({
    "name": name,
    "email": email,
    "password": password
  });
  // final jsonStr = {"refreshToken": refreshToken};
  final response = await http.post(
      url,
      headers: headers,
      body: body
  );

  // print("response ???");
  // print("response ${response.statusCode}");
  if(response.statusCode == 200) {
    // print("response 200");
    // print("response body ${response.body}");
    return await login(name, password);
    // return Auths.fromJson((await response.stream.bytesToString()) as Map<String, dynamic>);
  } else {
    throw Exception("Error: ${response.reasonPhrase}");
  }
}