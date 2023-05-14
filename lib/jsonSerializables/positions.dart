// import './PositionModel.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../main.dart';
import 'connect.dart';

part 'positions.g.dart';

@JsonSerializable()
class PositionsList{
  List<Position> positions;
  PositionsList({required this.positions});

  factory PositionsList.fromJson(Map<String, dynamic> json) => _$PositionsListFromJson(json);

  Map<String, dynamic> toJson() => _$PositionsListToJson(this);
}

@JsonSerializable()
class Position {
  @JsonKey(name: "_id")
  final String id;
  final String name;
  final int salary;

  Position({required this.id, required this.name, required this.salary});

  factory Position.fromJson(Map<String, dynamic> json) => _$PositionFromJson(json);

  Map<String, dynamic> toJson() => _$PositionToJson(this);
}

Future<PositionsList> getPositionsList(BuildContext context) async {
  String access = Provider.of<Auth>(context).accessToken;
  var getRefresh = Provider.of<Auth>(context).getRefresh;
  print("access - $access");
  var url = Uri.parse('http://$IP_ADDRESS:$PORT/api/v1/position');
  final response = await http.get(
    url,
    headers: {
      'Authorization': 'Bearer $access',
    },
  );
  if(response.statusCode == 401) {
    print("error 401");
    String newAccess = await getRefresh();
    print("newAccess - $newAccess");
    final response2 = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $newAccess',
      },
    );
    if(response2.statusCode == 200) {
      return PositionsList.fromJson(json.decode(response2.body));
    } else {
      throw Exception("Error: ${response2.reasonPhrase}");
    }
  }
  if(response.statusCode == 200) {
    return PositionsList.fromJson(json.decode(response.body));
  } else {
    throw Exception("Error: ${response.reasonPhrase}");
  }
}

Future<Position> getPosition(BuildContext context, String id) async {
  String access = Provider.of<Auth>(context).accessToken;
  var getRefresh = Provider.of<Auth>(context).getRefresh;
  // print("access - $access");
  var url = Uri.parse('http://$IP_ADDRESS:$PORT/api/v1/position/$id');
  final response = await http.get(
    url,
    headers: {
      'Authorization': 'Bearer $access',
    },
  );
  if(response.statusCode == 401) {
    // print("error 401");
    String newAccess = await getRefresh();
    // print("newAccess - $newAccess");
    final response2 = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $newAccess',
      },
    );
    if(response2.statusCode == 200) {
      return Position.fromJson(json.decode(response2.body));
    } else {
      throw Exception("Error: ${response2.reasonPhrase}");
    }
  }
  if(response.statusCode == 200) {
    return Position.fromJson(json.decode(response.body));
  } else {
    throw Exception("Error: ${response.reasonPhrase}");
  }

}

Future<Position> updatePosition(Auth auth, String id, String name, int salary) async {
  String access = auth.accessToken;
  var getRefresh = auth.getRefresh;
  // print("access - $access");
  var url = Uri.parse('http://$IP_ADDRESS:$PORT/api/v1/position');
  Map<String,String> headers = {
    'Authorization': 'Bearer $access',
    'Content-Type': 'application/json'
  };
  var body = json.encode({
    "_id": id,
    "name": name,
    "salary": "$salary"
  });
  print("body put - $body");
  final response = await http.put(
      url,
      headers: headers,
      body: body
  );
  if(response.statusCode == 401) {
    // print("error 401");
    String newAccess = await getRefresh();
    // print("newAccess - $newAccess");
    Map<String,String> headers2 = {
      'Authorization': 'Bearer $newAccess',
      'Content-Type': 'application/json'
    };
    final response2 = await http.put(
        url,
        headers: headers2,
        body: body
    );
    if(response2.statusCode == 200) {
      // print("response 200");
      return Position.fromJson(json.decode(response2.body));
    } else {
      throw Exception("Error: ${response2.reasonPhrase}");
    }
  }
  if(response.statusCode == 200) {
    // print("response 200");
    return Position.fromJson(json.decode(response.body));
  } else {
    throw Exception("Error: ${response.reasonPhrase}");
  }
}

Future<Position> deletePosition(Auth auth, String id) async {
  String access = auth.accessToken;
  var getRefresh = auth.getRefresh;
  // print("access - $access");
  var url = Uri.parse('http://$IP_ADDRESS:$PORT/api/v1/position/$id');
  final response = await http.delete(
    url,
    headers: {
      'Authorization': 'Bearer $access',
    },
  );
  if(response.statusCode == 401) {
    // print("error 401");
    String newAccess = await getRefresh();
    // print("newAccess - $newAccess");
    final response2 = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $newAccess',
      },
    );
    if(response2.statusCode == 200) {
      return Position.fromJson(json.decode(response2.body));
    } else {
      throw Exception("Error: ${response2.reasonPhrase}");
    }
  }
  if(response.statusCode == 200) {
    return Position.fromJson(json.decode(response.body));
  } else {
    throw Exception("Error: ${response.reasonPhrase}");
  }

}

Future<Position> createPosition(Auth auth, String name, int salary) async {
  String access = auth.accessToken;
  var getRefresh = auth.getRefresh;
  // print("access - $access");
  var url = Uri.parse('http://$IP_ADDRESS:$PORT/api/v1/position');
  Map<String,String> headers = {
    'Authorization': 'Bearer $access',
    'Content-Type': 'application/json'
  };
  var body = json.encode({
    "name": name,
    "salary": "$salary"
  });
  // print("body put - $body");
  final response = await http.post(
      url,
      headers: headers,
      body: body
  );
  if(response.statusCode == 401) {
    // print("error 401");
    String newAccess = await getRefresh();
    // print("newAccess - $newAccess");
    Map<String,String> headers2 = {
      'Authorization': 'Bearer $newAccess',
      'Content-Type': 'application/json'
    };
    final response2 = await http.put(
        url,
        headers: headers2,
        body: body
    );
    if(response2.statusCode == 200) {
      // print("response 200");
      return Position.fromJson(json.decode(response2.body));
    } else {
      throw Exception("Error: ${response2.reasonPhrase}");
    }
  }
  if(response.statusCode == 200) {
    // print("response 200");
    return Position.fromJson(json.decode(response.body));
  } else {
    throw Exception("Error: ${response.reasonPhrase}");
  }
}