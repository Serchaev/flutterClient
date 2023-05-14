// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employees.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeesList _$EmployeesListFromJson(Map<String, dynamic> json) =>
    EmployeesList(
      employees: (json['employees'] as List<dynamic>)
          .map((e) => Employee.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EmployeesListToJson(EmployeesList instance) =>
    <String, dynamic>{
      'employees': instance.employees,
    };

Employee _$EmployeeFromJson(Map<String, dynamic> json) => Employee(
      id: json['_id'] as String,
      fullName: json['fullName'] as String,
      phone: json['phone'] as int,
      address: json['address'] as String,
      positionID: json['positionID'] as String,
    );

Map<String, dynamic> _$EmployeeToJson(Employee instance) => <String, dynamic>{
      '_id': instance.id,
      'fullName': instance.fullName,
      'phone': instance.phone,
      'address': instance.address,
      'positionID': instance.positionID,
    };
