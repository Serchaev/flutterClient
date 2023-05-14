
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import 'Statefull/Employee.dart';

class Employees extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<Auth>(context).user;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        centerTitle: true,
        title: const Text(
            "Сотрудники"
        ),
      ),
      body: Employee(context),
      floatingActionButton: user.userRole.contains("MODER") ? FloatingActionButton(
        onPressed: () async{
          final result = await Navigator.pushNamed(context, "/employeeAdd");
          print("result - $result");
          if(result != null){
            Navigator.pop(context);
            Navigator.pushNamed(context, "/employees");
          }
        },
        backgroundColor: Colors.black87,
        child: const Icon(Icons.add),
      ) : null,
    );
  }

}