
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../main.dart';
import 'connect.dart';

part 'employees.g.dart';

@JsonSerializable()
class EmployeesList{
  List<Employee> employees;
  EmployeesList({required this.employees});

  factory EmployeesList.fromJson(Map<String, dynamic> json) => _$EmployeesListFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeesListToJson(this);
}

@JsonSerializable()
class Employee{
  @JsonKey(name: "_id")
  final String id;
  final String fullName;
  final int phone;
  final String address;
  final String positionID;

  Employee({required this.id, required this.fullName, required this.phone, required this.address, required this.positionID});

  factory Employee.fromJson(Map<String, dynamic> json) => _$EmployeeFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeToJson(this);
}

Future<EmployeesList> getEmployeesList(BuildContext context) async {
  // print("getEmployeesList");
  String access = Provider.of<Auth>(context).accessToken;
  var getRefresh = Provider.of<Auth>(context).getRefresh;
  // print("access - $access");
  var url = Uri.parse('http://$IP_ADDRESS:$PORT/api/v1/employee');
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
      return EmployeesList.fromJson(json.decode(response2.body));
    } else {
      throw Exception("Error: ${response2.reasonPhrase}");
    }
  }
  if(response.statusCode == 200) {
    return EmployeesList.fromJson(json.decode(response.body));
  } else {
    throw Exception("Error: ${response.reasonPhrase}");
  }
}

Future<Employee> getEmployee(BuildContext context, String id) async {
  String access = Provider.of<Auth>(context).accessToken;
  var getRefresh = Provider.of<Auth>(context).getRefresh;
  // print("access - $access");
  var url = Uri.parse('http://$IP_ADDRESS:$PORT/api/v1/employee/$id');
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
      return Employee.fromJson(json.decode(response2.body));
    } else {
      throw Exception("Error: ${response2.reasonPhrase}");
    }
  }
  if(response.statusCode == 200) {
    return Employee.fromJson(json.decode(response.body));
  } else {
    throw Exception("Error: ${response.reasonPhrase}");
  }

}

Future<Employee> updateEmployee(Auth auth, String id, String fullName, int phone, String address, String positionID) async {
  String access = auth.accessToken;
  var getRefresh = auth.getRefresh;
  // print("access - $access");
  var url = Uri.parse('http://$IP_ADDRESS:$PORT/api/v1/employee');
  Map<String,String> headers = {
    'Authorization': 'Bearer $access',
    'Content-Type': 'application/json'
  };
  var body = json.encode({
    "_id": id,
    "fullName": fullName,
    "phone": phone,
    "address": address,
    "positionID": positionID
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
      return Employee.fromJson(json.decode(response2.body));
    } else {
      throw Exception("Error: ${response2.reasonPhrase}");
    }
  }
  if(response.statusCode == 200) {
    // print("response 200");
    return Employee.fromJson(json.decode(response.body));
  } else {
    throw Exception("Error: ${response.reasonPhrase}");
  }
}

Future<Employee> deleteEmployee(Auth auth, String id) async {
  String access = auth.accessToken;
  var getRefresh = auth.getRefresh;
  // print("access - $access");
  var url = Uri.parse('http://$IP_ADDRESS:$PORT/api/v1/employee/$id');
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
      return Employee.fromJson(json.decode(response2.body));
    } else {
      throw Exception("Error: ${response2.reasonPhrase}");
    }
  }
  if(response.statusCode == 200) {
    return Employee.fromJson(json.decode(response.body));
  } else {
    throw Exception("Error: ${response.reasonPhrase}");
  }

}

Future<Employee> createEmployee(Auth auth, String fullName, int phone, String address, String positionID) async {
  String access = auth.accessToken;
  var getRefresh = auth.getRefresh;
  // print("access - $access");
  var url = Uri.parse('http://$IP_ADDRESS:$PORT/api/v1/employee');
  Map<String,String> headers = {
    'Authorization': 'Bearer $access',
    'Content-Type': 'application/json'
  };
  var body = json.encode({
    "fullName": "${fullName}",
    "phone": phone,
    "address": "${address}",
    "positionID": "${positionID}"
  });
  // print("body create - $body");
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
      return Employee.fromJson(json.decode(response2.body));
    } else {
      throw Exception("Error: ${response2.reasonPhrase}");
    }
  }
  if(response.statusCode == 200) {
    // print("response 200");
    return Employee.fromJson(json.decode(response.body));
  } else {
    throw Exception("Error: ${response.reasonPhrase}");
  }
}