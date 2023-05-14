import 'package:flutter/material.dart';

import 'Statefull/EmployeeAddStateFull.dart';

class EmployeeAdd extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        centerTitle: true,
        title: Text(
            "Добавление должности"
        ),
      ),
      body: EmployeeAddStateFull(context),
    );
  }

}