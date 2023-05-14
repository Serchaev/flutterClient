import 'package:flutter/material.dart';

import 'Statefull/EmployeeItemStateFull.dart';

class EmployeeItem extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black87,
        title: Text(
          "Данные сотрудника"
        ),
      ),
      body: EmployeeItemStateFull(args["id"]),
    );
  }

}